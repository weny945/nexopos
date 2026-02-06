<?php

/**
 * Table Migration: Add Linked Product Feature
 **/

use App\Classes\Schema;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        if ( Schema::hasTable( 'nexopos_products_unit_quantities' ) ) {
            Schema::table( 'nexopos_products_unit_quantities', function ( Blueprint $table ) {
                // 添加关联商品ID字段
                if ( ! Schema::hasColumn( 'nexopos_products_unit_quantities', 'linked_product_id' ) ) {
                    $table->unsignedBigInteger( 'linked_product_id' )->nullable()->after( 'convert_unit_id' );
                    $table->foreign( 'linked_product_id' )->references( 'id' )->on( 'nexopos_products' )->onDelete( 'SET NULL' );
                }
            } );
        }
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        if ( Schema::hasTable( 'nexopos_products_unit_quantities' ) ) {
            Schema::table( 'nexopos_products_unit_quantities', function ( Blueprint $table ) {
                if ( Schema::hasColumn( 'nexopos_products_unit_quantities', 'linked_product_id' ) ) {
                    $table->dropForeign( 'nexopos_products_unit_quantities_linked_product_id_foreign' );
                    $table->dropColumn( 'linked_product_id' );
                }
            } );
        }
    }
};
