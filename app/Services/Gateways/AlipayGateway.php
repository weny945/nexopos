<?php

namespace App\Services\Gateways;

use Exception;

class AlipayGateway
{
    private $appId;
    private $privateKey;
    private $publicKey;
    private $gatewayUrl;

    public function __construct()
    {
        $this->appId = ns()->option->get('ns_payment_alipay_app_id');

        // Decrypt sensitive data
        $privateKey = ns()->option->get('ns_payment_alipay_private_key');
        $this->privateKey = $privateKey ? \App\Services\PaymentCodeSecurityService::decrypt($privateKey) : '';

        $publicKey = ns()->option->get('ns_payment_alipay_public_key');
        $this->publicKey = $publicKey ? \App\Services\PaymentCodeSecurityService::decrypt($publicKey) : '';

        $this->gatewayUrl = ns()->option->get('ns_payment_alipay_gateway', 'https://openapi.alipay.com/gateway.do');
    }

    /**
     * Process payment code payment
     *
     * @param string $paymentCode
     * @param float $amount
     * @param int $orderId
     * @return array
     */
    public function pay(string $paymentCode, float $amount, int $orderId): array
    {
        try {
            // Build request parameters
            $params = [
                'app_id' => $this->appId,
                'method' => 'alipay.trade.pay',
                'charset' => 'UTF-8',
                'sign_type' => 'RSA2',
                'timestamp' => date('Y-m-d H:i:s'),
                'version' => '1.0',
                'biz_content' => json_encode([
                    'out_trade_no' => 'ORDER-' . $orderId . '-' . time(),
                    'total_amount' => number_format($amount, 2, '.', ''),
                    'scene' => 'bar_code',
                    'auth_code' => $paymentCode,
                ], JSON_UNESCAPED_UNICODE),
            ];

            // Sign request
            $params['sign'] = $this->generateSign($params);

            // Send request
            $response = $this->sendRequest($params);
            $result = json_decode($response, true);

            // Check response
            if (isset($result['alipay_trade_pay_response'])) {
                $response_data = $result['alipay_trade_pay_response'];

                if ($response_data['code'] === '10000') {
                    return [
                        'success' => true,
                        'transaction_id' => $response_data['trade_no'] ?? null,
                        'message' => __('Payment successful'),
                        'data' => $response_data,
                    ];
                } else {
                    return [
                        'success' => false,
                        'message' => $response_data['sub_msg'] ?? $response_data['msg'] ?? __('Payment failed'),
                        'code' => $response_data['code'],
                        'data' => $response_data,
                    ];
                }
            }

            return [
                'success' => false,
                'message' => __('Invalid response from Alipay'),
                'data' => $result,
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Query order status
     *
     * @param string $transactionId
     * @return array
     */
    public function query(string $transactionId): array
    {
        // TODO: Implement query functionality
        return [
            'success' => false,
            'message' => __('Query not implemented yet'),
        ];
    }

    /**
     * Refund payment
     *
     * @param string $transactionId
     * @param float $amount
     * @return array
     */
    public function refund(string $transactionId, float $amount): array
    {
        // TODO: Implement refund functionality
        return [
            'success' => false,
            'message' => __('Refund not implemented yet'),
        ];
    }

    /**
     * Verify callback signature
     *
     * @param array $data
     * @return bool
     */
    public function verifyCallback(array $data): bool
    {
        if (!isset($data['sign'])) {
            return false;
        }

        $sign = $data['sign'];
        unset($data['sign']);
        unset($data['sign_type']);

        $expectedSign = $this->generateSign($data);

        return $sign === $expectedSign;
    }

    /**
     * Test connection
     *
     * @return array
     */
    public function testConnection(): array
    {
        try {
            if (empty($this->appId)) {
                return [
                    'success' => false,
                    'message' => __('App ID is missing'),
                ];
            }

            if (empty($this->privateKey)) {
                return [
                    'success' => false,
                    'message' => __('Private key is missing'),
                ];
            }

            if (empty($this->publicKey)) {
                return [
                    'success' => false,
                    'message' => __('Public key is missing'),
                ];
            }

            // Try to build a test request
            $testParams = [
                'app_id' => $this->appId,
                'method' => 'alipay.trade.pay',
                'charset' => 'UTF-8',
                'sign_type' => 'RSA2',
                'timestamp' => date('Y-m-d H:i:s'),
                'version' => '1.0',
                'biz_content' => json_encode([
                    'out_trade_no' => 'TEST-' . time(),
                    'total_amount' => '0.01',
                    'scene' => 'bar_code',
                    'auth_code' => '123456789012345678',
                ], JSON_UNESCAPED_UNICODE),
            ];

            $sign = $this->generateSign($testParams);

            if ($sign) {
                return [
                    'success' => true,
                    'message' => __('Connection test successful. Configuration is valid.'),
                ];
            }

            return [
                'success' => false,
                'message' => __('Failed to generate signature'),
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => __('Connection test failed: ') . $e->getMessage(),
            ];
        }
    }

    /**
     * Generate signature
     *
     * @param array $params
     * @return string
     */
    protected function generateSign(array $params): string
    {
        // Sort parameters
        ksort($params);

        // Build query string
        $stringToBeSigned = '';
        foreach ($params as $k => $v) {
            if ($v !== '' && !is_array($v)) {
                $stringToBeSigned .= "$k=$v&";
            }
        }

        $stringToBeSigned = rtrim($stringToBeSigned, '&');

        // Sign with RSA2
        $privateKey = "-----BEGIN RSA PRIVATE KEY-----\n" .
            wordwrap($this->privateKey, 64, "\n", true) .
            "\n-----END RSA PRIVATE KEY-----";

        openssl_sign($stringToBeSigned, $sign, $privateKey, OPENSSL_ALGO_SHA256);

        return base64_encode($sign);
    }

    /**
     * Send HTTP request
     *
     * @param array $params
     * @return string
     */
    protected function sendRequest(array $params): string
    {
        $client = new \GuzzleHttp\Client();

        $response = $client->post($this->gatewayUrl, [
            'form_params' => $params,
            'verify' => false, // For development only
            'timeout' => 30,
        ]);

        return $response->getBody()->getContents();
    }
}
