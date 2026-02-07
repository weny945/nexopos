<?php

namespace App\Models;

use App\Classes\Model;
use App\Events\ProductAfterDeleteEvent;
use App\Events\ProductBeforeDeleteEvent;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;

/**
 * @property string   $id
 * @property string   $name
 * @property string   $tax_type
 * @property int      $tax_group_id
 * @property float    $tax_value
 * @property string   $product_type
 * @property string   $type
 * @property bool     $accurate_tracking
 * @property bool     $auto_cogs
 * @property string   $status
 * @property string   $stock_management  Can either be "enabled" or "disabled"
 * @property string   $barcode
 * @property string   $barcode_type
 * @property string   $sku
 * @property string   $description
 * @property int      $thumbnail_id
 * @property int      $category_id
 * @property int      $parent_id
 * @property int      $unit_group
 * @property string   $on_expiration
 * @property bool     $expires           whether or not the product has expired
 * @property bool     $searchable
 * @property int      $author
 * @property string   $uuid
 * @property TaxGroup $tax_group
 *
 * @method static Builder trackingEnabled()
 * @method static Builder trackingDisabled()
 * @method static Builder findUsingBarcode( $barcode )
 * @method static Builder barcode( $barcode )
 * @method static Builder sku( $sku )
 * @method static Builder onSale()
 * @method static Builder hidden()
 * @method static Builder findUsingSKU( $sku )
 * @method static Builder onlyVariations()
 * @method static Builder excludeVariations()
 * @method static Builder withStockEnabled(): Product
 * @method static Builder withStockDisabled(): Product
 * @method static Builder accurateTracking( $argument = true ): Product
 * @method static Builder searchable( $attribute = true ): Product
 * @method static Builder type( $type ): Product
 * @method static Builder notGrouped(): Product
 * @method static Builder grouped(): Product
 * @method static Builder isGroup(): Product
 * @method static Builder notInGroup(): Product
 * @method static Builder inGroup(): Product
 */
class Product extends NsModel
{
    use HasFactory;

    const STOCK_MANAGEMENT_ENABLED = 'enabled';

    const STOCK_MANAGEMENT_DISABLED = 'disabled';

    const EXPIRES_PREVENT_SALES = 'prevent_sales';

    const EXPIRES_ALLOW_SALES = 'allow_sales';

    const TYPE_MATERIALIZED = 'materialized';

    const TYPE_DEMATERIALIZED = 'dematerialized';

    const TYPE_GROUPED = 'grouped';

    const STATUS_AVAILABLE = 'available';

    const STATUS_UNAVAILABLE = 'unavailable';

    protected $table = 'nexopos_' . 'products';

    protected $casts = [
        'accurate_tracking' => 'boolean',
        'auto_cogs' => 'boolean',
    ];

    protected $dispatchesEvents = [
        'deleting' => ProductBeforeDeleteEvent::class,
        'deleted' => ProductAfterDeleteEvent::class,
    ];

    public function setDependencies()
    {
        return [
            OrderProduct::class => Model::dependant(
                local_name: 'name',
                local_index: 'id',
                foreign_index: 'product_id',
                related: Model::related(
                    model: Order::class,
                    foreign_index: 'product_id',
                    local_name: 'code'
                )
            ),
        ];
    }

    public function category()
    {
        return $this->belongsTo( ProductCategory::class, 'category_id', 'id' );
    }

    /**
     * get products having accurate tracking enabled
     *
     * @param Builder
     * @return Builder
     */
    public function scopeTrackingEnabled( $query )
    {
        return $query->where( 'accurate_tracking', true );
    }

    /**
     * get products having accurate tracking enabled
     *
     * @param Builder
     * @return Builder
     */
    public function scopeType( $query, $type )
    {
        return $query->where( 'type', $type );
    }

    /**
     * Add a scope that filter product
     * that aren't grouped
     */
    public function scopeNotGrouped( Builder $query )
    {
        return $query->where( 'type', '!=', self::TYPE_GROUPED );
    }

    /**
     * Filter products if they are grouped products.
     */
    public function scopeGrouped( Builder $query )
    {
        return $query->where( 'type', self::TYPE_GROUPED );
    }

    /**
     * Filter products if they are grouped products.
     *
     * @alias scopeGrouped
     */
    public function scopeIsGroup( Builder $query )
    {
        return $query->where( 'type', self::TYPE_GROUPED );
    }

    /**
     * Filter product that doesn't
     * belong to a group
     */
    public function scopeNotInGroup( Builder $query )
    {
        $subItemsIds = ProductSubItem::get( 'id' )->map( fn( $entry ) => $entry->id )->toArray();

        return $query->whereNotIn( 'id', $subItemsIds );
    }

    /**
     * Filter products that are
     * included as a sub_items.
     */
    public function scopeInGroup( Builder $query )
    {
        $subItemsIds = ProductSubItem::get( 'id' )->map( fn( $entry ) => $entry->id )->toArray();

        return $query->whereIn( 'id', $subItemsIds );
    }

    /**
     * get products having accurate tracking disabled
     *
     * @param Builder
     * @return Builder
     */
    public function scopeTrackingDisabled( $query )
    {
        return $query->where( 'accurate_tracking', false );
    }

    /**
     * get a product using a barcode
     *
     * @param Builder
     * @param string barcode
     * @return Builder
     */
    public function scopeFindUsingBarcode( $query, $barcode )
    {
        // Check if this is an ITF-14 barcode (14 digits, used for packaging)
        // ITF-14 format: [1 digit packaging indicator] + [13 digits EAN-13]
        // Example: 16902890259586 → 6902890259586 → 6902890259589 (corrected)
        if ( strlen( $barcode ) === 14 && ctype_digit( $barcode ) ) {
            // Convert ITF-14 to EAN-13 by removing the first digit (packaging indicator)
            $ean13Barcode = substr( $barcode, 1 );

            // Auto-correct EAN-13 checksum if needed
            $ean13Barcode = $this->correctEAN13Checksum( $ean13Barcode );

            // Try to find product using the converted and corrected EAN-13 barcode
            $result = $query->where( 'barcode', $ean13Barcode )->first();

            // If found with EAN-13, return a query that will find it
            if ( $result instanceof self ) {
                return $query->where( 'id', $result->id );
            }
        }

        // For 13-digit barcodes, also try to correct the checksum
        if ( strlen( $barcode ) === 13 && ctype_digit( $barcode ) ) {
            $correctedBarcode = $this->correctEAN13Checksum( $barcode );

            // If checksum was corrected, search with the corrected version
            if ( $correctedBarcode !== $barcode ) {
                $result = $query->where( 'barcode', $correctedBarcode )->first();
                if ( $result instanceof self ) {
                    return $query->where( 'id', $result->id );
                }
            }
        }

        // Default: search with original barcode
        return $query->where( 'barcode', $barcode );
    }

    /**
     * Correct EAN-13 checksum if invalid (helper method)
     *
     * @param string $barcode 13-digit EAN-13 barcode
     * @return string EAN-13 barcode with corrected checksum
     */
    private function correctEAN13Checksum( string $barcode ): string
    {
        if ( strlen( $barcode ) !== 13 || ! ctype_digit( $barcode ) ) {
            return $barcode;
        }

        // Calculate the correct checksum
        $sum = 0;
        for ( $i = 0; $i < 12; $i++ ) {
            $digit = intval( $barcode[ $i ] );
            // Odd positions (0, 2, 4...) multiply by 1, even positions by 3
            if ( $i % 2 == 0 ) {
                $sum += $digit * 1;
            } else {
                $sum += $digit * 3;
            }
        }

        $correctChecksum = ( 10 - ( $sum % 10 ) ) % 10;
        $currentChecksum = intval( $barcode[ 12 ] );

        // If checksum is incorrect, correct it
        if ( $correctChecksum !== $currentChecksum ) {
            return substr( $barcode, 0, 12 ) . $correctChecksum;
        }

        return $barcode;
    }

    /**
     * get a product using a barcode
     *
     * @param Builder
     * @param string barcode
     * @return Builder
     */
    public function scopeBarcode( $query, $barcode )
    {
        return $this->scopeFindUsingBarcode( $query, $barcode );
    }

    /**
     * get a product using a barcode
     *
     * @param  Builder $query
     * @param  string  $sku
     * @return Builder
     */
    public function scopeSku( $query, $sku )
    {
        return $this->scopeFindUsingSKU( $query, $sku );
    }

    /**
     * get products that are on sale.
     *
     * @param Builder
     * @return Builder
     */
    public function scopeOnSale( $query )
    {
        return $query->where( 'status', self::STATUS_AVAILABLE );
    }

    /**
     * get products that aren't on sale.
     *
     * @param Builder
     * @return Builder
     */
    public function scopeHidden( $query )
    {
        return $query->where( 'status', self::STATUS_UNAVAILABLE );
    }

    /**
     * Filter a product using the SKU
     *
     * @param Builder
     * @param string sku
     * @return Builder
     */
    public function scopeFindUsingSKU( $query, $sku )
    {
        return $query->where( 'sku', $sku );
    }

    public function unit_quantities()
    {
        return $this->hasMany( ProductUnitQuantity::class, 'product_id' );
    }

    public function unitGroup()
    {
        return $this->hasOne( UnitGroup::class, 'id', 'unit_group' );
    }

    public function product_taxes()
    {
        return $this->hasMany( ProductTax::class, 'product_id' );
    }

    public function tax_group()
    {
        return $this->hasOne( TaxGroup::class, 'id', 'tax_group_id' );
    }

    public function variations()
    {
        return $this->hasMany( Product::class, 'parent_id' );
    }

    public function galleries()
    {
        return $this->hasMany( ProductGallery::class, 'product_id', 'id' );
    }

    public function procurementHistory()
    {
        return $this->hasMany( ProcurementProduct::class, 'product_id', 'id' );
    }

    public function sub_items()
    {
        return $this->hasMany( ProductSubItem::class, 'parent_id', 'id' );
    }

    public function history()
    {
        return $this->hasMany( ProductHistory::class, 'product_id', 'id' );
    }

    /**
     * Filter query by getting products that are variations
     *
     * @param Builder $query
     * @return Builder;
     */
    public function scopeOnlyVariations( $query )
    {
        return $query->where( 'product_type', 'variation' );
    }

    /**
     * Filter query by getting products that aren't variations
     *
     * @param Builder $query
     * @return Builder;
     */
    public function scopeExcludeVariations( $query )
    {
        return $query->where( 'product_type', '!=', 'variation' );
    }

    /**
     * Filter query by getting product with
     * stock management enabled
     *
     * @param Builder $query
     * @return Builder;
     */
    public function scopeWithStockEnabled( $query )
    {
        return $query->where( 'stock_management', Product::STOCK_MANAGEMENT_ENABLED );
    }

    /**
     * Filter query by getting product with
     * stock management disabled
     *
     * @param Builder $query
     * @return Builder;
     */
    public function scopeWithStockDisabled( $query )
    {
        return $query->where( 'stock_management', Product::STOCK_MANAGEMENT_DISABLED );
    }

    /**
     * Filter query by getitng product with
     * accurate stock enabled or not.
     *
     * @param  Builder $query
     * @return Builder
     */
    public function scopeAccurateTracking( $query, $argument = true )
    {
        return $query->where( 'accurate_tracking', $argument );
    }

    /**
     * Filter product that are searchable
     *
     * @param Builder
     * @return Builder
     */
    public function scopeSearchable( $query, $attribute = true )
    {
        return $query->where( 'searchable', $attribute );
    }
}
