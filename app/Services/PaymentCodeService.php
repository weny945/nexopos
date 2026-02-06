<?php

namespace App\Services;

use App\Models\PaymentCodeTransaction;
use App\Exceptions\NotFoundException;
use App\Services\Gateways\AlipayGateway;
use App\Services\Gateways\WeChatGateway;
use Exception;

class PaymentCodeService
{
    /**
     * Process payment code payment
     *
     * @param int $orderId
     * @param string $paymentType
     * @param string $paymentCode
     * @param float $amount
     * @param int $authorId
     * @return array
     */
    public function processPayment(int $orderId, string $paymentType, string $paymentCode, float $amount, int $authorId): array
    {
        // Validate payment code format
        $this->validatePaymentCode($paymentCode, $paymentType);

        // Create transaction record
        $transaction = $this->createTransaction([
            'order_id' => $orderId,
            'payment_type' => $paymentType,
            'payment_code' => $this->encryptPaymentCode($paymentCode),
            'amount' => $amount,
            'status' => 'pending',
            'author' => $authorId,
        ]);

        // Process payment based on type
        try {
            if ($paymentType === 'alipay-payment') {
                $gateway = app()->make(AlipayGateway::class);
                $result = $gateway->pay($paymentCode, $amount, $orderId);
            } elseif ($paymentType === 'wechat-payment') {
                $gateway = app()->make(WeChatGateway::class);
                $result = $gateway->pay($paymentCode, $amount, $orderId);
            } else {
                throw new Exception(__('Unsupported payment type: %s', $paymentType));
            }

            // Update transaction status
            if ($result['success']) {
                $this->updateTransactionStatus($transaction->id, 'success', $result);
                return [
                    'status' => 'success',
                    'message' => __('Payment successful'),
                    'transaction_id' => $transaction->id,
                    'gateway_transaction_id' => $result['transaction_id'] ?? null,
                ];
            } else {
                $this->updateTransactionStatus($transaction->id, 'failed', $result);
                return [
                    'status' => 'error',
                    'message' => $result['message'] ?? __('Payment failed'),
                    'transaction_id' => $transaction->id,
                ];
            }
        } catch (Exception $e) {
            $this->updateTransactionStatus($transaction->id, 'failed', [
                'error' => $e->getMessage(),
            ]);
            throw $e;
        }
    }

    /**
     * Validate payment code format
     *
     * @param string $code
     * @param string $type
     * @return bool
     */
    public function validatePaymentCode(string $code, string $type): bool
    {
        if (empty($code)) {
            throw new Exception(__('Payment code cannot be empty'));
        }

        // Alipay and WeChat payment codes are 10-18 digits
        if (!preg_match('/^\d{10,18}$/', $code)) {
            throw new Exception(__('Invalid payment code format. Must be 10-18 digits.'));
        }

        return true;
    }

    /**
     * Create transaction record
     *
     * @param array $data
     * @return PaymentCodeTransaction
     */
    public function createTransaction(array $data): PaymentCodeTransaction
    {
        return PaymentCodeTransaction::create($data);
    }

    /**
     * Update transaction status
     *
     * @param int $transactionId
     * @param string $status
     * @param array $responseData
     * @return bool
     */
    public function updateTransactionStatus(int $transactionId, string $status, array $responseData = []): bool
    {
        $transaction = PaymentCodeTransaction::find($transactionId);

        if (!$transaction) {
            throw new NotFoundException(__('Transaction not found'));
        }

        $transaction->status = $status;

        if (!empty($responseData)) {
            $transaction->response_data = json_encode($responseData);

            if (isset($responseData['transaction_id'])) {
                $transaction->transaction_id = $responseData['transaction_id'];
            }

            if (isset($responseData['error'])) {
                $transaction->error_message = $responseData['error'];
            }
        }

        return $transaction->save();
    }

    /**
     * Get transaction by ID
     *
     * @param int $transactionId
     * @return PaymentCodeTransaction
     */
    public function getTransaction(int $transactionId): PaymentCodeTransaction
    {
        $transaction = PaymentCodeTransaction::find($transactionId);

        if (!$transaction) {
            throw new NotFoundException(__('Transaction not found'));
        }

        return $transaction;
    }

    /**
     * Get transactions by order ID
     *
     * @param int $orderId
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function getTransactionsByOrder(int $orderId)
    {
        return PaymentCodeTransaction::where('order_id', $orderId)->get();
    }

    /**
     * Encrypt payment code for storage
     *
     * @param string $code
     * @return string
     */
    protected function encryptPaymentCode(string $code): string
    {
        // Use Laravel's encryption
        return encrypt($code);
    }

    /**
     * Decrypt payment code
     *
     * @param string $encryptedCode
     * @return string
     */
    public function decryptPaymentCode(string $encryptedCode): string
    {
        try {
            return decrypt($encryptedCode);
        } catch (\Exception $e) {
            return '';
        }
    }

    /**
     * Handle payment callback
     *
     * @param string $type
     * @param array $data
     * @return bool
     */
    public function handlePaymentCallback(string $type, array $data): bool
    {
        try {
            if ($type === 'alipay') {
                $gateway = app()->make(AlipayGateway::class);
                $verified = $gateway->verifyCallback($data);
            } elseif ($type === 'wechat') {
                $gateway = app()->make(WeChatGateway::class);
                $verified = $gateway->verifyCallback($data);
            } else {
                return false;
            }

            if (!$verified) {
                return false;
            }

            // Find transaction by order_id or out_trade_no
            $orderId = $data['order_id'] ?? $data['out_trade_no'] ?? null;
            $transaction = PaymentCodeTransaction::where('order_id', $orderId)
                ->where('status', 'pending')
                ->first();

            if ($transaction) {
                $this->updateTransactionStatus($transaction->id, 'success', $data);
            }

            return true;
        } catch (Exception $e) {
            logger()->error('Payment callback error: ' . $e->getMessage());
            return false;
        }
    }
}
