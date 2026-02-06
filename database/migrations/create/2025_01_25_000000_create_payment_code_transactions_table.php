<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('nexopos_payment_code_transactions', function (Blueprint $table) {
            $table->id();
            $table->integer('order_id');
            $table->bigInteger('order_payment_id')->nullable();
            $table->string('payment_type', 50)->index(); // alipay, wechat
            $table->string('payment_code', 255); // 付款码（加密存储）
            $table->string('transaction_id', 255)->nullable()->unique(); // 第三方交易号
            $table->decimal('amount', 18, 5);
            $table->string('status', 50)->default('pending')->index(); // pending, success, failed, refunded, cancelled
            $table->text('response_data')->nullable(); // 支付响应数据（JSON）
            $table->text('error_message')->nullable(); // 错误信息
            $table->integer('author'); // 操作员ID
            $table->timestamps();

            // 索引
            $table->index('order_id');
            $table->index('created_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('nexopos_payment_code_transactions');
    }
};
