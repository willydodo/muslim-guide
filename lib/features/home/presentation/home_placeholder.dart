import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:muslim_guide/l10n/app_localizations.dart';

/// Temporary home placeholder until Phase 10 builds the dashboard.
///
/// Provides navigation buttons to implemented features for testing.
class HomePlaceholder extends ConsumerWidget {
  /// Creates the home placeholder.
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.app_name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.home_greeting,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // القرآن
          ElevatedButton.icon(
            icon: const Icon(Icons.menu_book),
            label: const Text('القرآن الكريم'),
            onPressed: () => context.go('/quran'),
          ),
          const SizedBox(height: 12),
          
          // المواقيت
          ElevatedButton.icon(
            icon: const Icon(Icons.access_time),
            label: const Text('مواقيت الصلاة'),
            onPressed: () => context.go('/prayer'),
          ),
          const SizedBox(height: 12),
          
          // القبلة
          ElevatedButton.icon(
            icon: const Icon(Icons.explore),
            label: const Text('القبلة'),
            onPressed: () => context.go('/qibla'),
          ),
          const SizedBox(height: 12),
          
          // الأذكار
          ElevatedButton.icon(
            icon: const Icon(Icons.auto_stories),
            label: const Text('الأذكار'),
            onPressed: () => context.go('/azkar'),
          ),
          const SizedBox(height: 12),

          // التقويم الهجري
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_month),
            label: const Text('التقويم الهجري'),
            onPressed: () => context.go('/hijri'),
          ),
          const SizedBox(height: 12),
          
          // الإعدادات
          ElevatedButton.icon(
            icon: const Icon(Icons.settings),
            label: const Text('الإعدادات'),
            onPressed: () => context.go('/settings/calculation'),
          ),
        ],
      ),
    );
  }
}
