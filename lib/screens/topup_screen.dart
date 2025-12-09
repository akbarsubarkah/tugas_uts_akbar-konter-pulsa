import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/transaction_store.dart';
import '../services/api_service.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  String? _operator;
  String? _nominal;

  final _operators = const ['Telkomsel', 'Indosat', 'XL', 'Tri', 'Axis', 'Smartfren'];
  final _nominals = const ['5.000', '10.000', '20.000', '25.000', '50.000', '100.000'];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_operator == null || _nominal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih operator dan nominal')), 
      );
      return;
    }
    final product = Product(
      operatorName: _operator!,
      name: 'Pulsa ${_nominal!}',
      type: 'pulsa',
      price: _parseNominal(_nominal!),
    );
    final res = await ApiService.topUp(
      phone: _phoneController.text.trim(),
      operatorName: _operator!,
      nominal: product.price,
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
    _formKey.currentState?.reset();
    setState(() {
      _operator = null;
      _nominal = null;
    });
  }

  int _parseNominal(String s) {
    return int.tryParse(s.replaceAll('.', '')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Isi Pulsa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP',
                  prefixIcon: Icon(Icons.phone_android),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Nomor HP wajib';
                  if (v.length < 10) return 'Nomor HP tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _operator,
                items: _operators
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
                onChanged: (v) => setState(() => _operator = v),
                decoration: const InputDecoration(
                  labelText: 'Operator',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _nominal,
                items: _nominals
                    .map((n) => DropdownMenuItem(value: n, child: Text('Rp $n')))
                    .toList(),
                onChanged: (v) => setState(() => _nominal = v),
                decoration: const InputDecoration(
                  labelText: 'Nominal',
                  border: OutlineInputBorder(),
                ),
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
      ),
    );
  }
}
