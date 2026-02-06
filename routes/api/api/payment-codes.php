<?php

use App\Http\Controllers\Dashboard\PaymentCodeController;
use App\Http\Middleware\NsRestrictMiddleware;
use Illuminate\Support\Facades\Route;

/**
 * Payment Code Routes
 */

// Process payment
Route::post('payment-codes/pay', [PaymentCodeController::class, 'pay'])
    ->middleware(NsRestrictMiddleware::arguments('nexopos.make-orders'));

// Test connection (no permission required - for configuration testing)
Route::post('payment-codes/config/test', [PaymentCodeController::class, 'testConnection']);

// Get configuration (requires settings management permission)
Route::get('payment-codes/config', [PaymentCodeController::class, 'getConfig'])
    ->middleware(NsRestrictMiddleware::arguments('nexopos.manage-settings'));

// Get transactions
Route::get('payment-codes/transactions', [PaymentCodeController::class, 'getTransactions'])
    ->middleware(NsRestrictMiddleware::arguments('nexopos.manage-orders'));

// Get single transaction
Route::get('payment-codes/transactions/{id}', [PaymentCodeController::class, 'getTransaction'])
    ->middleware(NsRestrictMiddleware::arguments('nexopos.manage-orders'));

/**
 * Callback routes (no authentication required)
 */
Route::post('payment-codes/notify/alipay', [PaymentCodeController::class, 'handleAlipayCallback']);
Route::post('payment-codes/notify/wechat', [PaymentCodeController::class, 'handleWeChatCallback']);

