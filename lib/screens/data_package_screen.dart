import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/transaction_store.dart';
import '../services/api_service.dart';

class DataPackageScreen extends StatefulWidget {
  const DataPackageScreen({super.key});

  @override
  State<DataPackageScreen> createState() => _DataPackageScreenState();
}

class _DataPackageScreenState extends State<DataPackageScreen> {
  final _phoneController = TextEditingController();
  String? _operator;
  String? _paket;

  final _operators = const ['Telkomsel', 'Indosat', 'XL', 'Tri', 'Smartfren'];
  final _pakets = const [
    '1 GB / 7 Hari',
    '5 GB / 30 Hari',
    '10 GB / 30 Hari',
    'Unlimited Harian',
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if ((_phoneController.text).trim().isEmpty || _operator == null || _paket == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi nomor, operator, dan paket')),
      );
      return;
    }
    final product = Product(
      operatorName: _operator!,
      name: _paket!,
      type: 'data',
      price: _estimatePrice(_paket!),
    );
    final res = await ApiService.buyDataPackage(
      phone: _phoneController.text.trim(),
      operatorName: _operator!,
      packageName: _paket!,
      price: product.price,
    );
    if (!mounted) return;
    TransactionStore.add(
      phone: _phoneController.text.trim(),
      product: product,
      status: res.success ? 'success' : 'failed',
      message: res.message,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(res.message ?? 'Transaksi diproses')),
    );
    setState(() {
      _operator = null;
      _paket = null;
      _phoneController.clear();
    });
  }

  int _estimatePrice(String paket) {
    if (paket.contains('1 GB')) return 12000;
    if (paket.contains('5 GB')) return 30000;
    if (paket.contains('10 GB')) return 50000;
    return 10000;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paket Data')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _operator,
              items: _operators.map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
              onChanged: (v) => setState(() => _operator = v),
              decoration: const InputDecoration(labelText: 'Operator', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _paket,
              items: _pakets.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _paket = v),
              decoration: const InputDecoration(labelText: 'Paket', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send),
                label: const Text('Proses'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
