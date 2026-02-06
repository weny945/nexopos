import { Popup } from "~/libraries/popup";
import nsProductUnitPopup from '~/popups/ns-pos-units.vue';

export class ProductUnitPromise {
    constructor( protected product ) {}

    run() {
        return new Promise( ( resolve, reject ) => {
            const product   =   this.product;

            /**
             * OPTIMIZATION: If product has unit_quantities data already loaded
             * and there's only ONE visible unit quantity, skip the popup entirely
             * to avoid slow API call to /units/quantities
             */
            if (product.$original && product.$original()) {
                const originalProduct = product.$original();
                if (originalProduct.unit_quantities && Array.isArray(originalProduct.unit_quantities)) {
                    const visibleUnits = originalProduct.unit_quantities.filter((uq: any) => uq.visible !== false);
                    if (visibleUnits.length === 1) {
                        // Only one unit available, skip popup and use it directly
                        const unitQuantity = visibleUnits[0];

                        // Match the same structure as the popup resolve
                        resolve({
                            unit_quantity_id: unitQuantity.id,
                            unit_id: unitQuantity.unit_id,
                            unit_name: unitQuantity.unit?.name || '',
                            $quantities: () => unitQuantity  // Return the selected unit quantity object
                        });
                        return;
                    }
                }
            }

            /**
             * If product was scanned via barcode, the unit_id is already set
             * Skip the popup for faster scanning
             */
            if (product.unit_id && !product.$quantities) {
                // Product already has a unit selected, skip popup
                resolve({});
                return;
            }

            // Show popup only when necessary (multiple units or no unit selected)
            Popup.show( nsProductUnitPopup, { resolve, reject, product });
        });
    }
}