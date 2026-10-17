import 'package:flutter/material.dart';
import 'package:muslim_guide/app/theme/app_spacing.dart';

/// A single Hijri event card showing the event name and days remaining.
class EventCard extends StatelessWidget {
  /// Creates an event card.
  const new({required this.name, required this.daysLabel, super.key});

  /// Localized event name (resolved from ARB by the caller).
  final String name;

  /// Localized days-remaining label (e.g. "tomorrow", "in 5 days").
  final String daysLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name, $daysLabel',
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.event, size: 48),
          title: Text(name),
          subtitle: Text(daysLabel),
        ),
      ),
    );
  }
}

/// Empty state when no upcoming events exist.
class NoEventsView extends StatelessWidget {
  /// Creates the empty view.
  const new({required this.label, super.key});

  /// Localized empty message.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.l),
      child: Center(child: Text(label, textAlign: TextAlign.center)),
    );
  }
}
