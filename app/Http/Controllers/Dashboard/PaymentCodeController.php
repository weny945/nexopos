<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use App\Services\Gateways\AlipayGateway;
use App\Services\Gateways\WeChatGateway;
use App\Services\PaymentCodeService;
use Exception;
use Illuminate\Http\Request;

class PaymentCodeController extends Controller
{
    protected $paymentCodeService;

    public function __construct(PaymentCodeService $paymentCodeService)
    {
        $this->paymentCodeService = $paymentCodeService;
    }

    /**
     * Process payment code payment
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function pay(Request $request)
    {
        try {
            $request->validate([
                'order_id' => 'required|integer',
                'payment_type' => 'required|in:alipay-payment,wechat-payment',
                'payment_code' => 'required|string|min:10|max:18',
                'amount' => 'required|numeric|min:0.01',
            ]);

            $orderId = $request->input('order_id');
            $paymentType = $request->input('payment_type');
            $paymentCode = $request->input('payment_code');
            $amount = (float) $request->input('amount');
            $authorId = auth()->id();

            $result = $this->paymentCodeService->processPayment(
                $orderId,
                $paymentType,
                $paymentCode,
                $amount,
                $authorId
            );

            return response()->json($result);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Test payment gateway connection
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function testConnection(Request $request)
    {
        try {
            $request->validate([
                'type' => 'required|in:alipay,wechat',
            ]);

            $type = $request->input('type');

            if ($type === 'alipay') {
                $gateway = app()->make(AlipayGateway::class);
            } else {
                $gateway = app()->make(WeChatGateway::class);
            }

            $result = $gateway->testConnection();

            return response()->json($result);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get transactions
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getTransactions(Request $request)
    {
        try {
            $orderId = $request->query('order_id');
            $paymentType = $request->query('payment_type');
            $status = $request->query('status');

            $query = \App\Models\PaymentCodeTransaction::query();

            if ($orderId) {
                $query->where('order_id', $orderId);
            }

            if ($paymentType) {
                $query->where('payment_type', $paymentType);
            }

            if ($status) {
                $query->where('status', $status);
            }

            $transactions = $query->with(['order', 'author'])
                ->orderBy('created_at', 'desc')
                ->paginate($request->query('per_page', 15));

            return response()->json([
                'status' => 'success',
                'data' => $transactions,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Get single transaction
     *
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getTransaction($id)
    {
        try {
            $transaction = $this->paymentCodeService->getTransaction($id);

            return response()->json([
                'status' => 'success',
                'data' => $transaction,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 404);
        }
    }

    /**
     * Handle Alipay callback
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function handleAlipayCallback(Request $request)
    {
        try {
            $data = $request->all();
            $result = $this->paymentCodeService->handlePaymentCallback('alipay', $data);

            if ($result) {
                return response('success');
            }

            return response('fail', 400);
        } catch (Exception $e) {
            logger()->error('Alipay callback error: ' . $e->getMessage());
            return response('fail', 500);
        }
    }

    /**
     * Handle WeChat callback
     *
     * @param Request $request
     * @return \Illuminate\Http\Response
     */
    public function handleWeChatCallback(Request $request)
    {
        try {
            $data = $request->all();
            $result = $this->paymentCodeService->handlePaymentCallback('wechat', $data);

            if ($result) {
                return response()->json([
                    'code' => 'SUCCESS',
                    'message' => 'success',
                ]);
            }

            return response()->json([
                'code' => 'FAIL',
                'message' => 'signature verification failed',
            ], 400);
        } catch (Exception $e) {
            logger()->error('WeChat callback error: ' . $e->getMessage());
            return response()->json([
                'code' => 'FAIL',
                'message' => 'internal error',
            ], 500);
        }
    }

    /**
     * Get payment code configuration
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function getConfig()
    {
        try {
            $config = [
                'alipay' => [
                    'enabled' => ns()->option->get('ns_payment_alipay_enabled') === 'yes',
                    'app_id' => ns()->option->get('ns_payment_alipay_app_id'),
                    'has_config' => !empty(ns()->option->get('ns_payment_alipay_app_id')),
                ],
                'wechat' => [
                    'enabled' => ns()->option->get('ns_payment_wechat_enabled') === 'yes',
                    'mch_id' => ns()->option->get('ns_payment_wechat_mch_id'),
                    'has_config' => !empty(ns()->option->get('ns_payment_wechat_mch_id')),
                ],
            ];

            return response()->json([
                'status' => 'success',
                'data' => $config,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
