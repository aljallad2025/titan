import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      (Icons.receipt_long_rounded, 'طلباتي'),
      (Icons.directions_car_filled_rounded, 'سياراتي المحفوظة'),
      (Icons.location_on_rounded, 'العناوين'),
      (Icons.payment_rounded, 'وسائل الدفع'),
      (Icons.notifications_rounded, 'الإشعارات'),
      (Icons.help_rounded, 'المساعدة والدعم'),
      (Icons.settings_rounded, 'الإعدادات'),
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(color: AppColors.primaryRed, shape: BoxShape.circle),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('أحمد الشامي', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 2),
                  Text('079xxxxxxx', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: menuItems.asMap().entries.map((e) {
                final isLast = e.key == menuItems.length - 1;
                return Container(
                  decoration: BoxDecoration(
                    border: isLast ? null : const Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: ListTile(
                    leading: Icon(e.value.$1, color: AppColors.primaryRed, size: 22),
                    title: Text(e.value.$2, style: Theme.of(context).textTheme.bodyLarge),
                    trailing: const Icon(Icons.arrow_back_ios_rounded, size: 14, color: AppColors.textMuted),
                    onTap: () {},
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout_rounded, size: 18),
            label: const Text('تسجيل الخروج'),
          ),
        ],
      ),
    );
  }
}
