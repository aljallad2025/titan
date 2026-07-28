import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

class MarketplaceScreen extends StatefulWidget {
  final VoidCallback onAddToCart;
  const MarketplaceScreen({super.key, required this.onAddToCart});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  ProductCategory selectedCategory = ProductCategory.tire;
  String? selectedSize;
  String? selectedSeason;

  final sizes = ['205/55R16', '215/60R16', '225/45R17'];
  final seasons = ['صيفي', 'شتوي', 'كل الفصول'];

  @override
  Widget build(BuildContext context) {
    final filtered = demoProducts.where((p) {
      if (p.category != selectedCategory) return false;
      if (selectedCategory == ProductCategory.tire) {
        if (selectedSize != null && p.size != selectedSize) return false;
        if (selectedSeason != null && p.season != selectedSeason) return false;
      }
      return true;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text('السوق', style: Theme.of(context).textTheme.headlineMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _CategoryTab(
                    label: 'الإطارات',
                    selected: selectedCategory == ProductCategory.tire,
                    onTap: () => setState(() => selectedCategory = ProductCategory.tire),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CategoryTab(
                    label: 'قطع الغيار',
                    selected: selectedCategory == ProductCategory.sparePart,
                    onTap: () => setState(() => selectedCategory = ProductCategory.sparePart),
                  ),
                ),
              ],
            ),
          ),
          if (selectedCategory == ProductCategory.tire) ...[
            const SizedBox(height: 14),
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _FilterChip(
                    label: 'كل الأحجام',
                    selected: selectedSize == null,
                    onTap: () => setState(() => selectedSize = null),
                  ),
                  ...sizes.map((s) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _FilterChip(
                          label: s,
                          selected: selectedSize == s,
                          onTap: () => setState(() => selectedSize = s),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 34,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _FilterChip(
                    label: 'كل الفصول',
                    selected: selectedSeason == null,
                    onTap: () => setState(() => selectedSeason = null),
                  ),
                  ...seasons.map((s) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _FilterChip(
                          label: s,
                          selected: selectedSeason == s,
                          onTap: () => setState(() => selectedSeason = s),
                        ),
                      )),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Text('ما في نتائج مطابقة', style: Theme.of(context).textTheme.bodyMedium),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) => ProductCard(
                      product: filtered[i],
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: filtered[i], onAddToCart: widget.onAddToCart),
                        ),
                      ),
                      onAddToCart: widget.onAddToCart,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _CategoryTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryRed : AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.primaryRed : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textSecondary,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryRed.withOpacity(0.15) : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primaryRed : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primaryRed : AppColors.textSecondary,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
