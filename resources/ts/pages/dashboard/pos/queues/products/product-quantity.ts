import { Popup } from '~/libraries/popup';
import { __ } from '~/libraries/lang';
import nsPosQuantityPopup from '~/popups/ns-pos-quantity-popup.vue';
import { nsSnackBar } from '~/bootstrap';

declare const POS;

export class ProductQuantityPromise {
    constructor( 
        protected product 
    ) {}

    run( data ) {
        return new Promise( ( resolve, reject ) => {
            const product   =   this.product;
            const options   =   POS.options.getValue();

            /**
             * Determine if we should show the quantity popup:
             *
             * Scenario 1: Editing cart product (NOT adding new) -> ALWAYS show popup
             * Scenario 2: Adding new product WITH quantity (e.g., barcode scan) -> skip popup
             * Scenario 3: Adding new product WITHOUT quantity -> show popup IF enabled in settings
             */
            const hasQuantity = this.product.quantity !== undefined && this.product.quantity > 0;
            const showQuantityEnabled = ['yes', 'true', true].includes(options.ns_pos_show_quantity);
            const isAddingNewProduct = POS.processingAddQueue;

            let shouldShowPopup = false;

            if (!isAddingNewProduct) {
                // Editing existing cart product: always show popup
                shouldShowPopup = true;
            } else {
                // Adding new product: show popup only if no quantity AND setting is enabled
                shouldShowPopup = !hasQuantity && showQuantityEnabled;
            }

            if ( shouldShowPopup ) {
                Popup.show( nsPosQuantityPopup, { resolve, reject, product, data });
            } else {
                const quantity = this.product.quantity || 1;

                /**
                 * The stock should be handled differently
                 * according to whether the stock management
                 * is enabled or not.
                 */
                if ( product.$original().stock_management === 'enabled' && product.$original().type === 'materialized' ) {

                    /**
                     * If the stock management is enabled,
                     * we'll pull updated stock from the server.
                     * When a product is added product.id has the real product id
                     * when a product is already on the cart product.id is not set but
                     * product.product_id is defined
                     */
                    const holdQuantity  =   POS.getStockUsage( product.$original().id, data.unit_quantity_id ) - ( product.quantity || 0 );

                    /**
                     * This checks if there is enough
                     * quantity for product that has stock 
                     * management enabled
                     */
                    if ( 
                        quantity > (
                            parseFloat( data.$quantities().quantity ) -
                            /**
                             * We'll make sure to ignore the product quantity 
                             * already added to the cart by substracting the 
                             * provided quantity.
                             */
                            ( holdQuantity )
                        )
                    ) {
                        return nsSnackBar.error( __( 'Unable to add the product, there is not enough stock. Remaining %s' ).replace( '%s', ( data.$quantities().quantity - holdQuantity ).toString() ) );
                    }
                }

                resolve({ quantity });
            }            
        });
    }
}
