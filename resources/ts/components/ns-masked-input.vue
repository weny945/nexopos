<template>
    <div class="flex flex-col mb-2 flex-auto ns-input" :class="hasError ? 'has-error' : 'is-pristine'">
        <label v-if="field.label && field.label.length > 0" :for="field.name" class="block leading-5 font-medium">
            <slot></slot>
        </label>
        <div :class="(field.description || (field.errors && field.errors.length > 0) ? 'mb-2' : '')" class="mt-1 relative overflow-hidden border rounded-md focus:shadow-sm">
            <div v-if="leading" class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <span class="leading sm:text-sm sm:leading-5">{{ leading }}</span>
            </div>
            <input
                ref="inputRef"
                :disabled="field.disabled"
                :value="inputValue"
                @input="onInput"
                @focus="onFocus"
                @blur="onBlur"
                :id="field.name"
                :type="inputType"
                :class="inputClass"
                class="block w-full sm:text-sm sm:leading-5 h-10 pr-10"
                :placeholder="field.placeholder || ''"
            />
            <button
                v-if="field.value && String(field.value).length > 0"
                type="button"
                @click="toggleReveal"
                class="absolute inset-y-0 right-0 pr-3 flex items-center cursor-pointer hover:text-blue-500"
                :title="isRevealed ? '隐藏' : '显示'"
            >
                <svg v-if="isRevealed" class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.88 9.88l-3.29-3.29m7.532 7.532l3.29 3.29M3 3l3.59 3.59m0 0A9.953 9.953 0 0112 5c4.478 0 8.268 2.943 9.543 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21" />
                </svg>
                <svg v-else class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                </svg>
            </button>
        </div>
        <ns-field-description :field="field"></ns-field-description>
    </div>
</template>

<script>
export default {
    data() {
        return {
            isRevealed: false,
            isFocused: false,
            isEditing: false,
        };
    },
    computed: {
        hasError() {
            return this.field.errors && this.field.errors.length > 0;
        },
        disabledClass() {
            return this.field.disabled ? 'ns-disabled cursor-not-allowed' : '';
        },
        inputClass() {
            return this.disabledClass + ' ' + this.leadClass;
        },
        leadClass() {
            return this.leading ? 'pl-8' : 'px-4';
        },
        inputType() {
            // Show as password when not revealed
            return this.isRevealed ? 'text' : 'password';
        },
        inputValue() {
            // If editing or revealed, show actual value
            if (this.isEditing || this.isRevealed) {
                return this.field.value || '';
            }
            // Otherwise show masked value
            return this.maskValue(this.field.value);
        }
    },
    methods: {
        toggleReveal() {
            this.isRevealed = !this.isRevealed;
        },
        onFocus() {
            this.isFocused = true;
        },
        onBlur() {
            this.isFocused = false;
            this.isEditing = false;
        },
        onInput(event) {
            this.isEditing = true;
            this.field.value = event.target.value;
            this.$emit('change', this.field);
        },
        maskValue(value) {
            if (!value) {
                return '';
            }
            const strValue = String(value);
            if (strValue.length === 0) {
                return '';
            }
            // Show first 2 and last 4 characters, mask the middle
            if (strValue.length <= 6) {
                return '*'.repeat(strValue.length);
            }
            const firstTwo = strValue.substring(0, 2);
            const lastFour = strValue.substring(strValue.length - 4);
            const maskedMiddle = '*'.repeat(strValue.length - 6);
            return firstTwo + maskedMiddle + lastFour;
        }
    },
    props: ['placeholder', 'leading', 'type', 'field']
};
</script>
