<template>
    <div class="h-full w-full py-2">
        <div class="px-2 pb-2" v-if="order">
            <div class="grid grid-cols-2 gap-2">
                <div id="details" class="h-16 flex justify-between items-center border elevation-surface info text-xl md:text-3xl p-2">
                    <span>{{ __( 'Total' ) }} : </span>
                    <span>{{ nsCurrency( order.total ) }}</span>
                </div>
                <div id="payment-status" class="h-16 flex justify-between items-center border elevation-surface success text-xl md:text-3xl p-2">
                    <span>{{ __( 'Paid' ) }} : </span>
                    <span>{{ nsCurrency( order.tendered ) }}</span>
                </div>
                <div class="col-span-2 h-16 flex justify-between items-center elevation-surface border text-xl md:text-3xl p-2 bg-blue-50">
                    <span>{{ __( 'Payment Code' ) }} : </span>
                    <span>{{ maskedCode || __( 'Waiting for input...' ) }}</span>
                </div>
            </div>
        </div>

        <div class="px-2 pb-2">
            <div class="flex flex-col gap-2">
                <!-- Payment Code Input -->
                <div class="elevation-surface border p-4">
                    <label class="block text-sm font-medium mb-2">{{ __( 'Scan or enter Alipay payment code' ) }}</label>
                    <div class="flex gap-2">
                        <input
                            ref="codeInput"
                            v-model="paymentCode"
                            type="text"
                            :placeholder="__( 'Enter 10-18 digit code' )"
                            class="flex-1 h-12 px-4 border text-2xl"
                            @keypress="handleCodeInput"
                            :disabled="processing"
                        />
                        <button
                            v-if="hasCamera"
                            @click="toggleScanner"
                            class="h-12 px-4 bg-primary text-white"
                            :disabled="processing"
                        >
                            <i class="las la-qrcode text-2xl"></i>
                        </button>
                    </div>
                    <p class="text-xs text-gray-500 mt-2">
                        <i class="las la-info-circle"></i>
                        {{ __( 'Use scanner gun or enter code manually' ) }}
                    </p>
                </div>

                <!-- Action Buttons -->
                <div class="grid grid-cols-2 gap-2">
                    <button
                        @click="processPayment"
                        :disabled="!isValidCode || processing"
                        class="h-16 text-xl font-medium"
                        :class="isValidCode && !processing ? 'bg-success text-white' : 'bg-gray-200 text-gray-400 cursor-not-allowed'"
                    >
                        <i v-if="processing" class="las la-spinner la-spin mr-2"></i>
                        <span v-if="processing">{{ __( 'Processing...' ) }}</span>
                        <span v-else>{{ __( 'Confirm Payment' ) }}</span>
                    </button>
                    <button
                        @click="clearCode"
                        :disabled="processing"
                        class="h-16 text-xl font-medium bg-warning text-white"
                    >
                        {{ __( 'Clear' ) }}
                    </button>
                </div>

                <!-- Scanner Modal (if camera enabled) -->
                <div v-if="showScanner" class="elevation-surface border p-4">
                    <div id="qr-reader" class="w-full h-64"></div>
                    <button
                        @click="toggleScanner"
                        class="mt-2 w-full h-10 bg-gray-200"
                    >
                        {{ __( 'Close Scanner' ) }}
                    </button>
                </div>

                <!-- Error Message -->
                <div v-if="errorMessage" class="elevation-surface border p-4 bg-error-tertiary text-white">
                    <i class="las la-exclamation-triangle mr-2"></i>
                    {{ errorMessage }}
                </div>

                <!-- Success Message -->
                <div v-if="successMessage" class="elevation-surface border p-4 bg-success-tertiary text-white">
                    <i class="las la-check-circle mr-2"></i>
                    {{ successMessage }}
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { nsSnackBar } from '~/bootstrap';
import { nsCurrency } from '~/filters/currency';
import { __ } from '~/libraries/lang';
import { Popup } from '~/libraries/popup';

export default {
    name: 'alipay-payment',
    props: ['label', 'identifier'],
    data() {
        return {
            paymentCode: '',
            processing: false,
            showScanner: false,
            hasCamera: false,
            errorMessage: '',
            successMessage: '',
            order: null,
            orderSubscription: null,
        };
    },
    computed: {
        isValidCode() {
            return /^\d{10,18}$/.test(this.paymentCode);
        },
        maskedCode() {
            if (!this.paymentCode) return '';
            return this.paymentCode.replace(/(\d{4})(?=\d)/g, '$1 ');
        },
    },
    mounted() {
        this.orderSubscription = POS.order.subscribe(order => {
            this.order = order;
        });

        // Auto-focus input
        this.$refs.codeInput?.focus();

        // Check for camera support
        this.hasCamera = !!navigator.mediaDevices?.getUserMedia;
    },
    beforeUnmount() {
        if (this.orderSubscription) {
            this.orderSubscription.unsubscribe();
        }
    },
    methods: {
        __,
        nsCurrency,

        handleCodeInput(event) {
            // Only allow numbers
            if (!/^\d*$/.test(event.key)) {
                event.preventDefault();
            }

            // Auto-submit when code is complete
            if (this.paymentCode.length >= 10 && this.paymentCode.length <= 18 && event.key === 'Enter') {
                this.processPayment();
            }
        },

        async processPayment() {
            if (!this.isValidCode || this.processing) {
                return;
            }

            this.processing = true;
            this.errorMessage = '';
            this.successMessage = '';

            try {
                const remainingAmount = this.order.total - this.order.tendered;

                const response = await nsHttpClient.post('/api/payment-codes/pay', {
                    order_id: this.order.id,
                    payment_type: 'alipay-payment',
                    payment_code: this.paymentCode,
                    amount: remainingAmount,
                });

                if (response.status === 'success') {
                    this.successMessage = response.message || __('Payment successful');

                    // Add payment to order
                    POS.addPayment({
                        value: remainingAmount,
                        identifier: this.identifier,
                        selected: false,
                        label: this.label,
                        readonly: false,
                    });

                    // Submit order
                    this.$emit('submit');

                    nsSnackBar.success(response.message || __('Payment successful'));

                    // Clear and reset
                    setTimeout(() => {
                        this.clearCode();
                        this.successMessage = '';
                    }, 2000);
                } else {
                    this.errorMessage = response.message || __('Payment failed');
                    nsSnackBar.error(this.errorMessage);
                }
            } catch (error) {
                this.errorMessage = error.response?.data?.message || error.message || __('An error occurred');
                nsSnackBar.error(this.errorMessage);
            } finally {
                this.processing = false;
            }
        },

        clearCode() {
            this.paymentCode = '';
            this.errorMessage = '';
            this.$refs.codeInput?.focus();
        },

        toggleScanner() {
            if (this.showScanner) {
                this.showScanner = false;
            } else {
                // TODO: Implement QR code scanner
                this.showScanner = true;
                // For now, just show a message
                this.errorMessage = __('Camera scanner not implemented. Please use a scanner gun or enter code manually.');
            }
        },
    },
};
</script>
