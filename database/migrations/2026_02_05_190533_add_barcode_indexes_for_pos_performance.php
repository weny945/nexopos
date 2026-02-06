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
        Schema::table('nexopos_products', function (Blueprint $table) {
            // Add index on barcode for fast barcode scanning
            $table->index('barcode', 'idx_barcode');
        });

        Schema::table('nexopos_products_unit_quantities', function (Blueprint $table) {
            // Add index on barcode for fast barcode scanning
            $table->index('barcode', 'idx_barcode');
        });

        Schema::table('nexopos_products', function (Blueprint $table) {
            // Add composite index for POS searches (product_type + status)
            $table->index(['product_type', 'status'], 'idx_product_type_status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('nexopos_products', function (Blueprint $table) {
            $table->dropIndex('idx_barcode');
            $table->dropIndex('idx_product_type_status');
        });

        Schema::table('nexopos_products_unit_quantities', function (Blueprint $table) {
            $table->dropIndex('idx_barcode');
        });
    }
};
