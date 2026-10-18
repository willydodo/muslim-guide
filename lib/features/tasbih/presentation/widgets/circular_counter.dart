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
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Fit the ring inside the available space so 200% text scale
            // cannot overflow; the number text stays full-size (no FittedBox)
            // per accessibility rules.
            final side = constraints.biggest.shortestSide;
            final ringSize = side.isFinite && side > 0
                ? side.clamp(120.0, 280.0)
                : 220.0;
            return SizedBox(
              width: ringSize,
              height: ringSize,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: ringSize,
                    height: ringSize,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '/ $target',
                        style: theme.textTheme.titleMedium,
                        textDirection: TextDirection.ltr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
