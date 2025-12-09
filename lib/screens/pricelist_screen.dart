import 'package:flutter/material.dart';

class PricelistScreen extends StatefulWidget {
  const PricelistScreen({super.key});

  @override
  State<PricelistScreen> createState() => _PricelistScreenState();
}

class _PricelistScreenState extends State<PricelistScreen> {
  final _search = TextEditingController();

  final List<Map<String, dynamic>> _data = [
    {
      'operator': 'Telkomsel',
      'pulsa': {
        '5k': '6.500', '10k': '11.500', '20k': '21.500', '25k': '26.500', '50k': '51.500', '100k': '101.500'
      },
      'data': {
        '1 GB / 7 Hari': '12.000', '5 GB / 30 Hari': '30.000', '10 GB / 30 Hari': '50.000', 'Unlimited Harian': '10.000'
      }
    },
    {
      'operator': 'Indosat',
      'pulsa': {
        '5k': '6.300', '10k': '11.300', '20k': '21.300', '25k': '26.300', '50k': '51.300', '100k': '101.300'
      },
      'data': {
        '1 GB / 7 Hari': '11.500', '5 GB / 30 Hari': '29.500', '10 GB / 30 Hari': '48.500', 'Unlimited Harian': '9.500'
      }
    },
    {
      'operator': 'XL',
      'pulsa': {
        '5k': '6.200', '10k': '11.200', '20k': '21.200', '25k': '26.200', '50k': '51.200', '100k': '101.200'
      },
      'data': {
        '1 GB / 7 Hari': '11.800', '5 GB / 30 Hari': '29.800', '10 GB / 30 Hari': '48.800', 'Unlimited Harian': '9.800'
      }
    },
    {
      'operator': 'Tri',
      'pulsa': {
        '5k': '6.100', '10k': '11.100', '20k': '21.100', '25k': '26.100', '50k': '51.100', '100k': '101.100'
      },
      'data': {
        '1 GB / 7 Hari': '11.200', '5 GB / 30 Hari': '29.200', '10 GB / 30 Hari': '48.200', 'Unlimited Harian': '9.200'
      }
    },
    {
      'operator': 'Axis',
      'pulsa': {
        '5k': '6.150', '10k': '11.150', '20k': '21.150', '25k': '26.150', '50k': '51.150', '100k': '101.150'
      },
      'data': {
        '1 GB / 7 Hari': '11.400', '5 GB / 30 Hari': '29.400', '10 GB / 30 Hari': '48.400', 'Unlimited Harian': '9.400'
      }
    },
    {
      'operator': 'Smartfren',
      'pulsa': {
        '5k': '6.250', '10k': '11.250', '20k': '21.250', '25k': '26.250', '50k': '51.250', '100k': '101.250'
      },
      'data': {
        '1 GB / 7 Hari': '11.900', '5 GB / 30 Hari': '29.900', '10 GB / 30 Hari': '48.900', 'Unlimited Harian': '9.900'
      }
    },
  ];

  List<Map<String, dynamic>> get _filtered {
    final q = _search.text.trim().toLowerCase();
    if (q.isEmpty) return _data;
    return _data.where((m) => (m['operator'] as String).toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Harga'),
          bottom: const TabBar(tabs: [Tab(text: 'Pulsa'), Tab(text: 'Paket Data')]),
        ),
        body: TabBarView(
          children: [
            _buildPulsaTab(context),
            _buildDataTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPulsaTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _search,
          decoration: const InputDecoration(
            hintText: 'Cari operator...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        for (final op in _filtered) _operatorCard(context, op, isPulsa: true),
      ],
    );
  }

  Widget _buildDataTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextField(
          controller: _search,
          decoration: const InputDecoration(
            hintText: 'Cari operator...',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
          onChanged: (_) => setState(() {}),
        ),
        const SizedBox(height: 12),
        for (final op in _filtered) _operatorCard(context, op, isPulsa: false),
      ],
    );
  }

  Widget _operatorCard(BuildContext context, Map<String, dynamic> op, {required bool isPulsa}) {
    final title = op['operator'] as String;
    final Map<String, String> items = (op[isPulsa ? 'pulsa' : 'data'] as Map<dynamic, dynamic>)
        .map((key, value) => MapEntry(key.toString(), value.toString()));
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            for (final entry in items.entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text('Rp ${entry.value}', style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
