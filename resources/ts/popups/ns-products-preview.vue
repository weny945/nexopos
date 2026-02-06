<template>
    <div class="shadow-lg w-[85.71vw] lg:w-[60vw] ns-box overflow-hidden flex flex-col">
        <div class="p-2 border-b ns-box-header text-fontcolor text-center font-medium flex justify-between items-center">
            <div>
                {{ __( 'Previewing :' ) }} {{ product.name }}
            </div>
            <div>
                <ns-close-button @click="popup.close()"></ns-close-button>
            </div>
        </div>
        <div class="flex-auto overflow-y-auto ns-box-body">
            <div class="p-2">
                <ns-tabs :active="active" @active="changeActiveTab( $event )">
                    <ns-tabs-item :label="__( 'Units & Quantities' )" identifier="units-quantities">
                        <table class="table ns-table w-full" v-if="hasLoadedUnitQuantities">
                            <thead>
                                <tr>
                                    <th class="p-1 border">{{ __( 'Unit' ) }}</th>
                                    <th width="150" class="text-right p-1 border">{{ __( 'Sale Price' ) }}</th>
                                    <th width="150" class="text-right p-1 border">{{ __( 'Wholesale Price' ) }}</th>
                                    <th width="150" class="text-right p-1 border">{{ __( 'Quantity' ) }}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="unitQuantity of unitQuantities" :key="unitQuantity.id">
                                    <td class="p-1 border text-left">{{ unitQuantity.unit.name }}
                                        <template v-if="product.rawType === 'materialized' && product.rawStockManagement === 'enabled'">
                                            &mdash; <a @click="convert( unitQuantity, product )" class="text-sm text-info-secondary hover:underline border-dashed" href="javascript:void(0)">{{ __( 'Convert' ) }}</a>
                                            <template v-if="unitQuantity.linked_product_id">
                                                &mdash; <a @click="convertToLinkedProduct( unitQuantity, product )" class="text-sm text-success-secondary hover:underline border-dashed" href="javascript:void(0)">{{ __( 'To Linked' ) }}</a>
                                            </template>
                                        </template>
                                    </td>
                                    <td class="p-1 border text-right">{{ nsCurrency( unitQuantity.sale_price  ) }}</td>
                                    <td class="p-1 border text-right">{{ nsCurrency( unitQuantity.wholesale_price  ) }}</td>
                                    <td class="p-1 border text-right">{{ unitQuantity.quantity }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <ns-spinner v-if="! hasLoadedUnitQuantities" size="16" border="4"></ns-spinner>
                    </ns-tabs-item>
                </ns-tabs>
            </div>
        </div>
    </div>
</template>
<script lang="ts">
import { nsCurrency } from '~/filters/currency';
import { nsHttpClient } from '~/bootstrap';
import { nsSnackBar } from '~/bootstrap';
import { __ } from '~/libraries/lang';
import nsProductsConversion from './ns-products-conversion.vue';

declare const Popup;


export default {
    name: 'ns-products-preview',
    props: [ 'popup', 'product' ],
    computed: {
        product() {
            return this.popup.params.product
        }
    },
    methods: {
        __,
        nsCurrency,
        changeActiveTab( event ) {
            this.active     =   event;

            if ( this.active === 'units-quantities' ) {
                this.loadProductQuantities();
            }
        },
        loadProductQuantities() {
            console.log( 'is loadinfg' );
            this.hasLoadedUnitQuantities            =   false;
            nsHttpClient.get( `/api/products/${this.product.id}/units/quantities` )
                .subscribe({
                    next: result => {
                        this.unitQuantities             =   result;
                        this.hasLoadedUnitQuantities    =   true;
                    }
                })
        },
        async convert( unitQuantity, product ) {
            try {
                const promise   =   await new Promise( ( resolve, reject ) => {
                    Popup.show( nsProductsConversion, {
                        unitQuantity,
                        product,
                        resolve,
                        reject
                    })
                });

                this.loadProductQuantities();
            } catch( exception ) {
                console.log({ exception })
            }
        },
        async convertToLinkedProduct( unitQuantity, product ) {
            // Check if linked product is set
            if ( ! unitQuantity.linked_product_id ) {
                nsSnackBar.error( __( 'This unit is not linked to any product.' ) ).subscribe();
                return;
            }

            // Show confirmation dialog
            const confirmation = confirm(
                this.__( 'Convert to Linked Product' ) + '\n\n' +
                this.__( 'This will convert using the unit value defined in the unit group. Proceed?' )
            );

            if ( ! confirmation ) {
                return;
            }

            try {
                const response = await nsHttpClient.post( `/api/products/unit-quantities/${unitQuantity.id}/convert-to-linked`, {
                    quantity: 1
                }).toPromise();

                if ( response.status === 'success' ) {
                    nsSnackBar.success( response.message ).subscribe();
                    this.loadProductQuantities();
                } else {
                    nsSnackBar.error( response.message || __( 'An error occurred' ) ).subscribe();
                }
            } catch ( error ) {
                console.error( error );
                const errorMessage = error.error?.message || error.message || __( 'An error occurred while converting' );
                nsSnackBar.error( errorMessage ).subscribe();
            }
        }
    },
    data() {
        return {
            active : 'units-quantities',
            unitQuantities: [],
            hasLoadedUnitQuantities: false
        }
    },
    mounted() {
        this.loadProductQuantities();
    }
}
</script>