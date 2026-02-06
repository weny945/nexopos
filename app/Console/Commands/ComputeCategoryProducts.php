<?php

namespace App\Console\Commands;

use App\Models\ProductCategory;
use App\Services\ProductCategoryService;
use Illuminate\Console\Command;

class ComputeCategoryProducts extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'categories:compute {id?}';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Recursively compute product counts for categories. Use: categories:compute [category_id]';

    /**
     * Execute the console command.
     */
    public function handle(ProductCategoryService $categoryService)
    {
        $categoryId = $this->argument('id');

        if ($categoryId) {
            // Compute for specific category
            $category = ProductCategory::find($categoryId);

            if (!$category) {
                $this->error("Category with ID {$categoryId} not found.");
                return 1;
            }

            $this->info("Computing products for category: {$category->name}");
            $categoryService->computeProducts($category);
            $this->info("✓ Done! Total items: {$category->total_items}");
        } else {
            // Compute for all root categories (will recursively compute all children)
            $this->info('Computing products for all categories...');

            $rootCategories = ProductCategory::whereNull('parent_id')
                ->orWhere('parent_id', 0)
                ->get();

            $bar = $this->output->createProgressBar($rootCategories->count());
            $bar->start();

            foreach ($rootCategories as $rootCategory) {
                $categoryService->computeProducts($rootCategory);
                $bar->advance();
            }

            $bar->finish();
            $this->newLine();
            $this->info('✓ All category product counts have been updated!');
        }

        return 0;
    }
}
