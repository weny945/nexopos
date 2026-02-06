<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;

/**
 * @property int    $id
 * @property int    $order_id
 * @property int    $order_payment_id
 * @property string $payment_type
 * @property string $payment_code
 * @property string $transaction_id
 * @property float  $amount
 * @property string $status
 * @property string $response_data
 * @property string $error_message
 * @property int    $author
 */
class PaymentCodeTransaction extends NsModel
{
    use HasFactory;

    protected $table = 'nexopos_payment_code_transactions';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'order_id',
        'order_payment_id',
        'payment_type',
        'payment_code',
        'transaction_id',
        'amount',
        'status',
        'response_data',
        'error_message',
        'author',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'amount' => 'decimal:5',
        'response_data' => 'array',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Relationships
     */

    public function order()
    {
        return $this->belongsTo(Order::class, 'order_id');
    }

    public function orderPayment()
    {
        return $this->belongsTo(OrderPayment::class, 'order_payment_id');
    }

    public function author()
    {
        return $this->belongsTo(User::class, 'author');
    }

    /**
     * Scopes
     */

    public function scopeAlipay($query)
    {
        return $query->where('payment_type', 'alipay');
    }

    public function scopeWechat($query)
    {
        return $query->where('payment_type', 'wechat');
    }

    public function scopeSuccess($query)
    {
        return $query->where('status', 'success');
    }

    public function scopeFailed($query)
    {
        return $query->where('status', 'failed');
    }

    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    /**
     * Accessors
     */

    public function getPaymentTypeTextAttribute()
    {
        $types = [
            'alipay' => __('支付宝'),
            'wechat' => __('微信支付'),
        ];

        return $types[$this->payment_type] ?? __('未知');
    }

    public function getStatusTextAttribute()
    {
        $statuses = [
            'pending' => __('处理中'),
            'success' => __('成功'),
            'failed' => __('失败'),
            'refunded' => __('已退款'),
            'cancelled' => __('已取消'),
        ];

        return $statuses[$this->status] ?? __('未知');
    }

    public function getMaskedPaymentCodeAttribute()
    {
        if (strlen($this->payment_code) <= 4) {
            return $this->payment_code;
        }

        return str_repeat('*', strlen($this->payment_code) - 4) . substr($this->payment_code, -4);
    }
}
