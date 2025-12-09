import 'package:flutter/material.dart';

class StepProgress extends StatelessWidget {
  final int currentStep;
  final List<String> labels;
  const StepProgress({super.key, required this.currentStep, required this.labels});

  Color _colorFor(int index, ColorScheme cs) {
    if (currentStep >= index) return cs.primary;
    return cs.surfaceContainerHighest;
  }

  Widget _dot(int index, ColorScheme cs) {
    final active = currentStep >= index;
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: _colorFor(index, cs),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: active
          ? const Icon(Icons.check, color: Colors.white, size: 18)
          : Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _connector(int index, ColorScheme cs) {
    return Expanded(
      child: Container(
        height: 2,
        color: currentStep > index ? cs.primary : cs.surfaceContainerHighest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Row(
          children: [
            for (int i = 0; i < labels.length; i++) ...[
              _dot(i, cs),
              if (i < labels.length - 1) _connector(i, cs),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final l in labels)
              Expanded(
                child: Text(l, textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant)),
              ),
          ],
        ),
      ],
    );
  }
}
