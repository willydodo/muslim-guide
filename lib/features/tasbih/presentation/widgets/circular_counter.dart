import 'package:flutter/material.dart';

/// Circular counter: progress ring + center tap target (48dp+).
class CircularCounter extends StatelessWidget {
  /// Creates a circular counter.
  const new({
    required this.progress,
    required this.count,
    required this.target,
    required this.onTap,
    super.key,
    this.semanticsLabel,
  });

  /// Progress 0.0–1.0.
  final double progress;

  /// Current count.
  final int count;

  /// Target repetitions.
  final int target;

  /// Called on tap.
  final VoidCallback onTap;

  /// Accessibility label.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      button: true,
      label: semanticsLabel ?? '$count / $target',
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 220,
                height: 220,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor:
                      theme.colorScheme.surfaceContainerHighest,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$count',
                    style: theme.textTheme.displayMedium,
                    textDirection: TextDirection.ltr,
                  ),
                  Text(
                    '/ $target',
                    style: theme.textTheme.titleMedium,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
