<template>
    <div class="ns-alipay-test-connection">
        <div class="border border-box-edge rounded p-4 bg-box-background">
            <h3 class="font-semibold mb-2 text-fontcolor">{{ __('Test Connection') }}</h3>
            <p class="text-sm text-fontcolor-light mb-3">
                {{ __('Click the button below to test the Alipay configuration and connection.') }}
            </p>
            <div class="flex items-center gap-2 flex-wrap">
                <button
                    @click="testConnection"
                    :disabled="testing"
                    class="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
                >
                    <span v-if="testing">{{ __('Testing...') }}</span>
                    <span v-else>{{ __('Test Alipay Connection') }}</span>
                </button>
                <span v-if="result" :class="['text-sm', result.success ? 'text-green-500' : 'text-red-500']" class="flex items-center">
                    <template v-if="result.success">
                        ✓ {{ result.message }}
                    </template>
                    <template v-else>
                        ✗ {{ result.message }}
                    </template>
                </span>
            </div>
            <div v-if="result && result.details" class="mt-3 p-3 bg-gray-100 rounded text-sm overflow-auto max-h-40">
                <pre class="whitespace-pre-wrap text-xs text-fontcolor">{{ result.details }}</pre>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { __ } from '~/libraries/lang';

declare const nsHttpClient;

export default {
    name: 'ns-alipay-test-connection',
    data() {
        return {
            testing: false,
            result: null as { success: boolean, message: string, details: string } | null,
        }
    },
    methods: {
        __,
        testConnection() {
            this.testing = true;
            this.result = null; // Clear previous result

            nsHttpClient.post('/api/payment-codes/config/test', {
                type: 'alipay'
            }).subscribe({
                next: (response) => {
                    this.testing = false;

                    // nsHttpClient returns the response directly, not wrapped in data
                    const isSuccess = response.success === true;

                    if (isSuccess) {
                        this.result = {
                            success: true,
                            message: response.message || __('Connection successful!'),
                            details: JSON.stringify(response, null, 2)
                        };
                    } else {
                        this.result = {
                            success: false,
                            message: response.message || __('Connection failed'),
                            details: JSON.stringify(response, null, 2)
                        };
                    }
                },
                error: (error) => {
                    this.testing = false;
                    this.result = {
                        success: false,
                        message: __('Connection failed: ') + (error.message || __('Unknown error')),
                        details: JSON.stringify(error, null, 2)
                    };
                }
            });
        }
    }
}
</script>

<style scoped>
.ns-alipay-test-connection {
    width: 100%;
}

.ns-alipay-test-connection > div {
    min-height: auto;
}
</style>
