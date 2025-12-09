import 'package:flutter/material.dart';

class OperatorLogo extends StatelessWidget {
  final String operatorName;
  final double size;
  const OperatorLogo({super.key, required this.operatorName, this.size = 40});

  Color _color(String name, ColorScheme cs) {
    final n = name.toLowerCase();
    if (n.contains('telkomsel')) return Colors.red;
    if (n.contains('indosat')) return Colors.amber;
    if (n.contains('xl')) return Colors.blue;
    if (n.contains('tri')) return Colors.purple;
    if (n.contains('axis')) return Colors.deepPurpleAccent;
    if (n.contains('smartfren')) return Colors.redAccent;
    return cs.primary;
  }

  String _abbr(String name) {
    final n = name.trim();
    if (n.isEmpty) return '?';
    final parts = n.split(' ');
    if (parts.length == 1) {
      if (n.toLowerCase() == 'xl') return 'XL';
      return n.substring(0, n.length >= 2 ? 2 : 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  String _assetPath() {
    final n = operatorName.toLowerCase();
    if (n.contains('telkomsel')) return 'assets/logos/telkomsel.png';
    if (n.contains('indosat')) return 'assets/logos/indosat.png';
    if (n.contains('xl')) return 'assets/logos/xl.png';
    if (n.contains('tri')) return 'assets/logos/tri.png';
    if (n.contains('axis')) return 'assets/logos/axis.png';
    if (n.contains('smartfren')) return 'assets/logos/smartfren.png';
    return 'assets/logos/default.png';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = _color(operatorName, cs);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 5),
      child: Image.asset(
        _assetPath(),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stack) {
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bg.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(size / 5),
            ),
            alignment: Alignment.center,
            child: Text(
              _abbr(operatorName),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: size * 0.4,
              ),
            ),
          );
        },
      ),
    );
  }
}
