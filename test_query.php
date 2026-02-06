<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use App\Models\Product;
use Illuminate\Support\Facades\DB;

echo "=== Testing Barcode Query Performance ===\n\n";

// Enable query log
DB::enableQueryLog();

$barcode = '6939936691812';

echo "1. Testing Product query...\n";
$start = microtime(true);
$product = Product::where('barcode', $barcode)
    ->with(['unit_quantities.unit', 'tax_group.taxes'])
    ->first();
$time = (microtime(true) - $start) * 1000;
echo "Time: " . number_format($time, 2) . "ms\n";

if ($product) {
    echo "Product Found: " . $product->name . "\n";
} else {
    echo "Product not found with barcode: $barcode\n";
}

echo "\n2. All Queries Executed:\n";
$queries = DB::getQueryLog();
foreach ($queries as $i => $query) {
    echo "Query " . ($i+1) . ": " . $query['query'] . "\n";
    echo "Time: " . number_format($query['time'], 2) . "ms\n\n";
}

echo "Total Queries: " . count($queries) . "\n";
echo "Total Time: " . number_format(array_sum(array_column($queries, 'time')), 2) . "ms\n";
