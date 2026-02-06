<?php

namespace Database\Seeders;

use App\Models\PaymentType;
use Illuminate\Database\Seeder;

class PaymentCodePaymentTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $author = auth()->id() ?? 1;

        // Alipay Payment Type
        $alipayType = PaymentType::firstOrCreate(
            ['identifier' => 'alipay-payment'],
            [
                'label' => 'Alipay',
                'priority' => 5,
                'active' => false,
                'readonly' => false,
                'author' => $author,
            ]
        );

        $this->command->info($alipayType->wasRecentlyCreated ? '✓ Alipay payment type created' : '- Alipay payment type already exists');

        // WeChat Payment Type
        $wechatType = PaymentType::firstOrCreate(
            ['identifier' => 'wechat-payment'],
            [
                'label' => 'WeChat Pay',
                'priority' => 6,
                'active' => false,
                'readonly' => false,
                'author' => $author,
            ]
        );

        $this->command->info($wechatType->wasRecentlyCreated ? '✓ WeChat Pay payment type created' : '- WeChat Pay payment type already exists');
    }
}
