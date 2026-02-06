<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\DB;

echo "=== Checking Barcode Indexes ===\n\n";

$tables = [
    'nexopos_products' => ['barcode'],
    'nexopos_products_unit_quantities' => ['barcode'],
    'nexopos_procurement_products' => ['barcode'],
];

$missingIndexes = [];

foreach ($tables as $table => $columns) {
    echo "Table: $table\n";

    $indexes = DB::select("SHOW INDEX FROM `$table`");

    $indexedColumns = [];
    foreach ($indexes as $index) {
        $indexedColumns[] = $index->Column_name;
    }

    foreach ($columns as $column) {
        if (in_array($column, $indexedColumns)) {
            echo "  ✓ $column is indexed\n";
        } else {
            echo "  ✗ $column is NOT indexed (MISSING)\n";
            $missingIndexes[] = ['table' => $table, 'column' => $column];
        }
    }

    echo "\n";
}

if (!empty($missingIndexes)) {
    echo "=== Missing Indexes (SLOW!) ===\n";
    echo "The following indexes should be added:\n\n";

    foreach ($missingIndexes as $index) {
        $sql = "ALTER TABLE `{$index['table']}` ADD INDEX `idx_{$index['column']}` (`{$index['column']}`);";
        echo "$sql\n";
    }

    echo "\nWould you like to add these indexes now? (y/n): ";
} else {
    echo "All barcode columns are indexed!\n";
}
