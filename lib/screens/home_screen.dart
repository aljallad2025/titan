import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onAddToCart;
  const HomeScreen({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final featured = demoProducts.take(4).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('أهلاً بك 👋', style: Theme.of(context).textTheme.bodyMedium),
                      Text('TITAN', style: Theme.of(context).textTheme.headlineMedium?.copyWith(letterSpacing: 2)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'دور على إطار أو قطعة غيار...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://commons.wikimedia.org/wiki/Special:FilePath/Replacement_of_car_tires.jpg?width=700',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) => Container(color: AppColors.primaryRedDark),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(color: AppColors.primaryRed.withOpacity(0.78)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'عروض الصيف',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'خصم يوصل ٢٥٪ على إطارات مختارة',
                                  style: TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                  child: const Text('تسوق الآن', style: TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.local_fire_department_rounded, color: Colors.white, size: 44),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 22, 16, 10),
              child: Row(
                children: [
                  _QuickCategory(icon: Icons.trip_origin_rounded, label: 'إطارات'),
                  _QuickCategory(icon: Icons.settings_rounded, label: 'قطع غيار'),
                  _QuickCategory(icon: Icons.build_rounded, label: 'صيانة'),
                  _QuickCategory(icon: Icons.local_offer_rounded, label: 'عروض'),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Text('الأكثر طلباً', style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) => ProductCard(
                  product: featured[i],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ProductDetailScreen(product: featured[i], onAddToCart: onAddToCart)),
                  ),
                  onAddToCart: onAddToCart,
                ),
                childCount: featured.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _QuickCategory extends StatelessWidget {
  final IconData icon;
  final String label;
  const _QuickCategory({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: AppColors.primaryRed, size: 22),
          ),
          const SizedBox(height: 6),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
