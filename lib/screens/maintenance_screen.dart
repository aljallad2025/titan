import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class Workshop {
  final String name;
  final String area;
  final double rating;
  final String eta;
  final String imageUrl;
  const Workshop({
    required this.name,
    required this.area,
    required this.rating,
    required this.eta,
    required this.imageUrl,
  });
}

const workshops = [
  Workshop(
    name: 'ورشة الفارس للسيارات',
    area: 'عمان - الجبيهة',
    rating: 4.9,
    eta: 'خلال ٣٠ دقيقة',
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Auto_Repair_shop.jpg?width=400',
  ),
  Workshop(
    name: 'مركز النخبة للصيانة',
    area: 'عمان - خلدا',
    rating: 4.7,
    eta: 'خلال ساعة',
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Auto_Repair_shop.jpg?width=400',
  ),
  Workshop(
    name: 'كراج السرعة الفائقة',
    area: 'الزرقاء - وسط البلد',
    rating: 4.5,
    eta: 'اليوم مساءً',
    imageUrl: 'https://commons.wikimedia.org/wiki/Special:FilePath/Auto_Repair_shop.jpg?width=400',
  ),
];

class ServiceCategory {
  final String title;
  final IconData icon;
  final List<String> services;
  const ServiceCategory({required this.title, required this.icon, required this.services});
}

const serviceCategories = [
  ServiceCategory(
    title: 'الميكانيكا العامة',
    icon: Icons.build_rounded,
    services: ['تغيير زيت المحرك', 'فحص شامل', 'صيانة دورية', 'سير المحرك'],
  ),
  ServiceCategory(
    title: 'الكهرباء والبطاريات',
    icon: Icons.bolt_rounded,
    services: ['تبديل بطارية', 'فحص الدينامو', 'أعطال كهربائية', 'تركيب إنذار'],
  ),
  ServiceCategory(
    title: 'الإطارات والفرامل',
    icon: Icons.album_rounded,
    services: ['تبديل إطارات', 'صيانة فرامل', 'توازين وميزان', 'فحص المساعدين'],
  ),
  ServiceCategory(
    title: 'التكييف والتبريد',
    icon: Icons.ac_unit_rounded,
    services: ['تعبئة فريون', 'فحص التكييف', 'تنظيف الرادياتير'],
  ),
];

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  String? selectedService;
  int expandedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('حجز خدمة صيانة', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text('اختر القسم ونوع الخدمة، وبعدها ورشة قريبة منك', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          if (selectedService != null)
            Container(
              margin: const EdgeInsets.only(top: 6, bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primaryRed.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryRed),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.primaryRed, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'الخدمة المختارة: $selectedService',
                      style: const TextStyle(color: AppColors.primaryRed, fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 12),
          ...List.generate(serviceCategories.length, (index) {
            final cat = serviceCategories[index];
            final isOpen = expandedCategory == index;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: isOpen ? AppColors.primaryRed : AppColors.border),
              ),
              child: Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => setState(() => expandedCategory = isOpen ? -1 : index),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(cat.icon, color: AppColors.primaryRed, size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(cat.title, style: Theme.of(context).textTheme.titleMedium),
                          ),
                          Icon(
                            isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isOpen)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: cat.services.map((s) {
                          final selected = s == selectedService;
                          return InkWell(
                            onTap: () => setState(() => selectedService = s),
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                              decoration: BoxDecoration(
                                color: selected ? AppColors.primaryRed : AppColors.surfaceElevated,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: selected ? AppColors.primaryRed : AppColors.border),
                              ),
                              child: Text(
                                s,
                                style: TextStyle(
                                  color: selected ? Colors.white : AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            );
          }),
          const SizedBox(height: 12),
          Text('ورشات قريبة منك', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...workshops.map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 110,
                        child: Image.network(
                          w.imageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(color: AppColors.primaryRed, strokeWidth: 2),
                            );
                          },
                          errorBuilder: (context, error, stack) => Container(
                            color: AppColors.surfaceElevated,
                            child: const Icon(Icons.build_rounded, color: AppColors.primaryRed, size: 34),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(w.name, style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 2),
                                  Text(w.area, style: Theme.of(context).textTheme.bodyMedium),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, color: AppColors.warning, size: 14),
                                      const SizedBox(width: 3),
                                      Text('${w.rating}', style: Theme.of(context).textTheme.labelSmall),
                                      const SizedBox(width: 10),
                                      const Icon(Icons.access_time_rounded, color: AppColors.textMuted, size: 14),
                                      const SizedBox(width: 3),
                                      Text(w.eta, style: Theme.of(context).textTheme.labelSmall),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      selectedService == null
                                          ? 'اختر نوع الخدمة أولاً'
                                          : 'تم حجز موعد $selectedService في ${w.name}',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('احجز'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
