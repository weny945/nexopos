<?php

use App\Classes\FormInput;

return [
    'label' => __( 'Alipay' ),
    'fields' => [
        FormInput::switch(
            label: __( 'Enable Alipay Payment Code' ),
            name: 'ns_payment_alipay_enabled',
            value: ns()->option->get( 'ns_payment_alipay_enabled', 'no' ),
            description: __( 'Enable Alipay payment code scanning on POS.' ),
            options: [
                ['label' => __( 'Yes' ), 'value' => 'yes'],
                ['label' => __( 'No' ), 'value' => 'no'],
            ],
        ),
        FormInput::text(
            label: __( 'Alipay App ID' ),
            name: 'ns_payment_alipay_app_id',
            value: ns()->option->get( 'ns_payment_alipay_app_id', '' ),
            description: __( 'The Alipay application ID.' ),
        ),
        FormInput::maskedTextarea(
            label: __( 'Alipay App Private Key' ),
            name: 'ns_payment_alipay_private_key',
            value: ns()->option->get( 'ns_payment_alipay_private_key', '' ),
            description: __( 'The Alipay application private key (RSA2).' ),
        ),
        FormInput::maskedTextarea(
            label: __( 'Alipay Public Key' ),
            name: 'ns_payment_alipay_public_key',
            value: ns()->option->get( 'ns_payment_alipay_public_key', '' ),
            description: __( 'The Alipay public key for verifying callbacks.' ),
        ),
        FormInput::text(
            label: __( 'Alipay Gateway URL' ),
            name: 'ns_payment_alipay_gateway',
            value: ns()->option->get( 'ns_payment_alipay_gateway', 'https://openapi.alipay.com/gateway.do' ),
            description: __( 'The Alipay gateway URL. Use sandbox URL for testing: https://openapi.alisdk.com/gateway.do' ),
        ),
        FormInput::custom(
            label: __( 'Test Alipay Connection' ),
            component: 'nsAlipayTestConnection',
        ),
    ],
];
