<template>
    <div class="flex flex-col flex-auto ns-linked-product-selector">
        <!-- Label -->
        <label :for="field.name" class="block leading-5 font-medium">
            <slot></slot>
        </label>

        <!-- Info Message -->
        <div class="mb-2 text-info-primary text-xs bg-info-tertiary p-2 rounded mt-1">
            <i class="las la-info-circle"></i>
            {{ __( 'This feature is designed for non-base units (e.g., Box → Bag). Base units should not be linked.' ) }}
        </div>

        <!-- Disabled Message for Base Units -->
        <div v-if="isBaseUnit" class="border rounded p-3 bg-gray-100 text-gray-500 text-sm">
            <i class="las la-lock"></i>
            {{ __( 'This is a base unit and cannot be linked to another product.' ) }}
        </div>

        <!-- Search Input Area (Only for non-base units) -->
        <div v-if="! selectedProduct && ! isBaseUnit" class="relative">
            <div class="border rounded-md focus:shadow-sm flex">
                <input
                    ref="searchInputRef"
                    v-model="searchQuery"
                    @keyup.enter="performSearch"
                    type="text"
                    class="form-input block w-full sm:text-sm sm:leading-5 h-10"
                    :class="disabled ? 'ns-disabled cursor-not-allowed' : ''"
                    :placeholder="placeholder"
                    :disabled="disabled">
                <button
                    v-if="! disabled"
                    @click="performSearch"
                    type="button"
                    class="w-10 h-10 flex items-center justify-center border-l outline-hidden hover:bg-info-primary">
                    <i class="las la-search"></i>
                </button>
            </div>
            <div class="text-xs text-gray-500 mt-1">
                <i class="las la-barcode"></i> {{ __( 'You can also scan a barcode' ) }}
            </div>
        </div>

        <!-- Selected Product Display -->
        <div v-if="selectedProduct" class="border rounded p-3 bg-info-secondary/10">
            <div class="flex justify-between items-start">
                <div class="flex-1">
                    <div class="font-medium text-sm">{{ selectedProduct.name }}</div>
                    <div class="text-xs text-gray-600 mt-1">
                        {{ __( 'Barcode' ) }}: {{ selectedProduct.barcode || selectedProduct.sku || 'N/A' }}
                    </div>
                </div>
                <button
                    v-if="! disabled"
                    @click="clearSelection"
                    type="button"
                    class="text-error hover:text-error-tertiary ml-2">
                    <i class="las la-times text-lg"></i>
                </button>
            </div>
        </div>

        <!-- Search Results -->
        <div v-if="showResults && searchResults.length > 0" class="border-t mt-2 pt-2">
            <div class="max-h-60 overflow-y-auto">
                <div
                    v-for="product in searchResults"
                    :key="product.id"
                    @click.stop="selectProduct( product )"
                    class="p-2 hover:bg-info-primary cursor-pointer border-b border-dashed last:border-0">
                    <div class="text-sm font-medium">{{ product.name }}</div>
                    <div class="text-xs text-gray-500">
                        {{ __( 'Barcode' ) }}: {{ product.barcode || product.sku || 'N/A' }}
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden Input -->
        <input
            type="hidden"
            :name="field.name"
            :value="inputValue">

        <!-- Description -->
        <ns-field-description :field="field"></ns-field-description>
    </div>
</template>

<script lang="ts">
import { nsHttpClient } from '~/bootstrap';
import { __ } from '~/libraries/lang';
import { nsSnackBar } from '~/bootstrap';

export default {
    name: 'ns-linked-product-selector',
    props: {
        field: {
            type: Object,
            required: true
        }
    },
    data: () => ({
        searchQuery: '',
        showResults: false,
        searchResults: [],
        selectedProduct: null,
        isLoading: false
    }),
    computed: {
        disabled() {
            return this.field.disabled || false;
        },
        inputValue() {
            return this.field.value || '';
        },
        placeholder() {
            return this.field.placeholder || __( 'Search product name or barcode...' );
        },
        isBaseUnit() {
            // Check if the current unit is a base unit
            // The field data should include unit information
            if ( this.field.unit && this.field.unit.base_unit ) {
                return this.field.unit.base_unit === 1 || this.field.unit.base_unit === true;
            }
            return false;
        }
    },
    watch: {
        inputValue: {
            immediate: true,
            handler( newValue ) {
                if ( newValue && ! this.selectedProduct && ! this.isBaseUnit ) {
                    this.loadSelectedProduct( newValue );
                } else if ( ! newValue ) {
                    this.selectedProduct = null;
                }
            }
        }
    },
    mounted() {
        // Auto focus search input when component mounts
        if ( ! this.selectedProduct && ! this.disabled && ! this.isBaseUnit && this.$refs.searchInputRef ) {
            this.$refs.searchInputRef.focus();
        }

        // Close search results when clicking outside
        this._clickHandler = ( event ) => {
            if ( this.$el && ! this.$el.contains( event.target ) ) {
                this.showResults = false;
            }
        };
        document.addEventListener( 'click', this._clickHandler );
    },

    beforeUnmount() {
        // Clean up event listener
        if ( this._clickHandler ) {
            document.removeEventListener( 'click', this._clickHandler );
        }
    },
    methods: {
        __,

        performSearch() {
            if ( this.searchQuery.length < 2 ) {
                nsSnackBar.error( __( 'Please enter at least 2 characters' ) );
                return;
            }

            if ( this.isLoading ) {
                return;
            }

            this.isLoading = true;

            nsHttpClient.post( '/api/products/search', {
                search: this.searchQuery,
                limit: 10
            }).subscribe({
                next: ( response ) => {
                    // The API returns a direct array of products
                    this.searchResults = Array.isArray( response ) ? response : [];
                    this.showResults = this.searchResults.length > 0;

                    if ( this.searchResults.length === 0 ) {
                        nsSnackBar.info( __( 'No products found' ) );
                    }
                },
                error: ( error ) => {
                    console.error( error );
                    nsSnackBar.error( __( 'An error occurred while searching' ) );
                },
                complete: () => {
                    this.isLoading = false;
                }
            });
        },

        selectProduct( product ) {
            this.selectedProduct = product;
            this.searchQuery = '';
            this.searchResults = [];
            this.showResults = false;

            // Update field value directly
            if ( this.field ) {
                this.field.value = product.id;
            }

            // Emit change event
            this.$emit( 'change', product.id );
        },

        clearSelection() {
            this.selectedProduct = null;

            // Update field value directly
            if ( this.field ) {
                this.field.value = '';
            }

            this.$emit( 'change', '' );
        },

        loadSelectedProduct( productId ) {
            nsHttpClient.get( `/api/products/${productId}` ).subscribe({
                next: ( response ) => {
                    // The API returns a direct product object
                    if ( response && response.id ) {
                        this.selectedProduct = response;
                    }
                },
                error: ( error ) => {
                    console.error( '[LinkedProductSelector] Failed to load product:', error );
                }
            });
        }
    }
}
</script>
