<?php

use App\Classes\FormInput;

return [
    'label' => __( 'WeChat Pay' ),
    'fields' => [
        FormInput::switch(
            label: __( 'Enable WeChat Payment Code' ),
            name: 'ns_payment_wechat_enabled',
            value: ns()->option->get( 'ns_payment_wechat_enabled', 'no' ),
            description: __( 'Enable WeChat payment code scanning on POS.' ),
            options: [
                ['label' => __( 'Yes' ), 'value' => 'yes'],
                ['label' => __( 'No' ), 'value' => 'no'],
            ],
        ),
        FormInput::text(
            label: __( 'WeChat Merchant ID' ),
            name: 'ns_payment_wechat_mch_id',
            value: ns()->option->get( 'ns_payment_wechat_mch_id', '' ),
            description: __( 'The WeChat Pay merchant ID.' ),
        ),
        FormInput::text(
            label: __( 'WeChat App ID' ),
            name: 'ns_payment_wechat_app_id',
            value: ns()->option->get( 'ns_payment_wechat_app_id', '' ),
            description: __( 'The WeChat application ID (appid or sub_appid).' ),
        ),
        FormInput::maskedText(
            label: __( 'WeChat API Key (v2)' ),
            name: 'ns_payment_wechat_api_key',
            value: ns()->option->get( 'ns_payment_wechat_api_key', '' ),
            description: __( 'The WeChat Pay API key for signing requests (MD5 signature). This is required for Micropay API.' ),
        ),
        FormInput::custom(
            label: __( 'Test WeChat Pay Connection' ),
            component: 'nsWeChatTestConnection',
        ),
    ],
];
