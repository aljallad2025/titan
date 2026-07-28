import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  const ProductDetailScreen({super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تفاصيل المنتج')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 220,
                width: double.infinity,
                color: AppColors.surface,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryRed),
                    );
                  },
                  errorBuilder: (context, error, stack) => Icon(
                    iconFor(product.icon.name),
                    color: AppColors.primaryRed,
                    size: 80,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(product.brand, style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: AppColors.warning, size: 18),
                const SizedBox(width: 4),
                Text('${product.rating}', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(width: 6),
                Text('(${product.reviews} تقييم)', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Text('${product.price.toStringAsFixed(0)} د.أ',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                if (product.oldPrice != null) ...[
                  const SizedBox(width: 10),
                  Text('${product.oldPrice!.toStringAsFixed(0)} د.أ',
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textMuted, decoration: TextDecoration.lineThrough)),
                ],
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  if (product.category == ProductCategory.tire) ...[
                    _SpecRow(label: 'المقاس', value: product.size ?? '-'),
                    _SpecRow(label: 'معدل الحمل والسرعة', value: product.loadSpeedRating ?? '-'),
                    _SpecRow(label: 'الفصل المناسب', value: product.season ?? '-'),
                  ] else ...[
                    _SpecRow(label: 'يناسب', value: '${product.carMake} - ${product.carModel}'),
                    _SpecRow(label: 'رقم القطعة', value: product.partNumber ?? '-'),
                  ],
                  _SpecRow(
                    label: 'التوفر',
                    value: product.inStock ? 'متوفر' : 'غير متوفر',
                    valueColor: product.inStock ? AppColors.success : AppColors.primaryRed,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: product.inStock
                ? () {
                    onAddToCart();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت الإضافة إلى السلة')),
                    );
                  }
                : null,
            icon: const Icon(Icons.shopping_cart_rounded),
            label: const Text('أضف إلى السلة'),
          ),
        ),
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;
  const _SpecRow({required this.label, required this.value, this.valueColor, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(
            value,
            style: TextStyle(
              color: valueColor ?? AppColors.textPrimary,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
