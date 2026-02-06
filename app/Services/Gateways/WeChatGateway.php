<?php

namespace App\Services\Gateways;

use Exception;

class WeChatGateway
{
    private $mchId;
    private $appId;
    private $apiKey;  // V2 API Key
    private $apiUrl = 'https://api.mch.weixin.qq.com';  // V2 API URL

    public function __construct()
    {
        $this->mchId = ns()->option->get('ns_payment_wechat_mch_id');
        $this->appId = ns()->option->get('ns_payment_wechat_app_id');

        // Decrypt API key
        $apiKey = ns()->option->get('ns_payment_wechat_api_key');
        $this->apiKey = $apiKey ? \App\Services\PaymentCodeSecurityService::decrypt($apiKey) : '';
    }

    /**
     * Process payment code payment using WeChat Pay V2 Micropay API
     * 文档: https://pay.weixin.qq.com/wiki/doc/api/micropay.php?chapter=9_10
     *
     * @param string $paymentCode  付款码（18位纯数字）
     * @param float $amount        金额（单位：元）
     * @param int $orderId         订单ID
     * @return array
     */
    public function pay(string $paymentCode, float $amount, int $orderId): array
    {
        try {
            $url = $this->apiUrl . '/pay/micropay';

            // 生成随机字符串
            $nonceStr = md5(uniqid(mt_rand(), true));

            // 构建请求参数
            $params = [
                'appid' => $this->appId,
                'mch_id' => $this->mchId,
                'nonce_str' => $nonceStr,
                'body' => '订单号 #' . $orderId,
                'out_trade_no' => 'ORDER-' . $orderId . '-' . time(),
                'total_fee' => intval($amount * 100), // 转换为分
                'spbill_create_ip' => request()->ip(),
                'auth_code' => $paymentCode, // 付款码，18位纯数字
            ];

            // 生成签名
            $params['sign'] = $this->generateMd5Sign($params);

            // 转换为XML
            $xml = $this->arrayToXml($params);

            // 发送请求
            $client = new \GuzzleHttp\Client();
            $response = $client->post($url, [
                'body' => $xml,
                'headers' => [
                    'Content-Type' => 'application/xml',
                ],
                'verify' => false,
                'timeout' => 30,
            ]);

            $result = $this->xmlToArray($response->getBody()->getContents());

            // 检查返回结果
            if (isset($result['return_code']) && $result['return_code'] === 'SUCCESS') {
                if (isset($result['result_code']) && $result['result_code'] === 'SUCCESS') {
                    return [
                        'success' => true,
                        'transaction_id' => $result['transaction_id'] ?? null,
                        'message' => __('Payment successful'),
                        'data' => $result,
                    ];
                } else {
                    // 错误处理
                    $errorCode = $result['err_code'] ?? 'UNKNOWN';
                    $errorMsg = $result['err_code_des'] ?? $result['return_msg'] ?? __('Payment failed');

                    return [
                        'success' => false,
                        'message' => $errorMsg,
                        'code' => $errorCode,
                        'data' => $result,
                    ];
                }
            }

            return [
                'success' => false,
                'message' => $result['return_msg'] ?? __('Invalid response from WeChat Pay'),
                'data' => $result,
            ];
        } catch (\GuzzleHttp\Exception\RequestException $e) {
            return [
                'success' => false,
                'message' => __('Network error: ') . $e->getMessage(),
                'data' => [],
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => $e->getMessage(),
            ];
        }
    }

    /**
     * Query order status (V2 API)
     *
     * @param string $transactionId
     * @return array
     */
    public function query(string $transactionId): array
    {
        // TODO: Implement order query using V2 API
        // 接口: https://api.mch.weixin.qq.com/pay/orderquery
        return [
            'success' => false,
            'message' => __('Query not implemented yet'),
        ];
    }

    /**
     * Refund payment (V2 API)
     *
     * @param string $transactionId
     * @param float $amount
     * @return array
     */
    public function refund(string $transactionId, float $amount): array
    {
        // TODO: Implement refund using V2 API
        // 接口: https://api.mch.weixin.qq.com/secapi/pay/refund
        return [
            'success' => false,
            'message' => __('Refund not implemented yet'),
        ];
    }

    /**
     * Verify callback signature (V2)
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

        $expectedSign = $this->generateMd5Sign($data);

        return $sign === $expectedSign;
    }

    /**
     * Test connection for V2 API
     *
     * @return array
     */
    public function testConnection(): array
    {
        try {
            if (empty($this->mchId)) {
                return [
                    'success' => false,
                    'message' => __('Merchant ID is missing'),
                ];
            }

            if (empty($this->appId)) {
                return [
                    'success' => false,
                    'message' => __('App ID is missing'),
                ];
            }

            if (empty($this->apiKey)) {
                return [
                    'success' => false,
                    'message' => __('API Key (V2) is missing'),
                ];
            }

            // 测试生成签名
            $testParams = [
                'appid' => $this->appId,
                'mch_id' => $this->mchId,
                'nonce_str' => md5(uniqid(mt_rand(), true)),
                'body' => 'Test',
                'out_trade_no' => 'TEST-' . time(),
                'total_fee' => 1,
            ];

            $sign = $this->generateMd5Sign($testParams);

            if ($sign) {
                return [
                    'success' => true,
                    'message' => __('Connection test successful. WeChat Pay V2 API configuration is valid.'),
                ];
            }

            return [
                'success' => false,
                'message' => __('Failed to generate MD5 signature'),
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => __('Connection test failed: ') . $e->getMessage(),
            ];
        }
    }

    /**
     * Generate MD5 signature (V2 API)
     *
     * @param array $params
     * @return string
     */
    protected function generateMd5Sign(array $params): string
    {
        // 1. 过滤空值和sign
        $params = array_filter($params, function($value) {
            return $value !== '' && $value !== null;
        });

        // 2. 按字母顺序排序
        ksort($params);

        // 3. 拼接成字符串
        $stringToBeSigned = http_build_query($params, '', '&');

        // 4. 在字符串末尾拼接key
        $stringToBeSigned .= '&key=' . $this->apiKey;

        // 5. MD5加密并转为大写
        return strtoupper(md5($stringToBeSigned));
    }

    /**
     * Convert array to XML
     *
     * @param array $arr
     * @return string
     */
    protected function arrayToXml(array $arr): string
    {
        $xml = '<xml>';

        foreach ($arr as $key => $val) {
            if (is_numeric($val)) {
                $xml .= "<{$key}>{$val}</{$key}>";
            } else {
                $xml .= "<{$key}><![CDATA[{$val}]]></{$key}>";
            }
        }

        $xml .= '</xml>';

        return $xml;
    }

    /**
     * Convert XML to array
     *
     * @param string $xml
     * @return array
     */
    protected function xmlToArray(string $xml): array
    {
        return json_decode(json_encode(simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA)), true);
    }
}
