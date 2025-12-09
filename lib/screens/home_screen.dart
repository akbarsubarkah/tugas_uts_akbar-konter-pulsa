import 'package:flutter/material.dart';
import '../state/transaction_store.dart';
import '../state/auth_store.dart';
import 'topup_screen.dart';
import 'data_package_screen.dart';
import 'transactions_screen.dart';
import 'pricelist_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beranda')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ValueListenableBuilder(
            valueListenable: AuthStore.currentUser,
            builder: (context, user, _) {
              final name = user?.name ?? 'Pengguna';
              final cs = Theme.of(context).colorScheme;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primary.withValues(alpha: 0.15), cs.primary.withValues(alpha: 0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: cs.primary,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Halo, $name', style: Theme.of(context).textTheme.titleMedium),
                          Text('Selamat datang di Konter Pulsa', style: TextStyle(color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _StatCard(title: 'Penjualan Hari Ini', value: 'Rp ${TransactionStore.todayTotal()}'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(title: 'Transaksi Hari Ini', value: '${TransactionStore.todayCount()}'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('Aksi Cepat', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _QuickAction(icon: Icons.phone_android, label: 'Isi Pulsa', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TopUpScreen()));
              }),
              _QuickAction(icon: Icons.wifi, label: 'Paket Data', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const DataPackageScreen()));
              }),
              _QuickAction(icon: Icons.receipt_long, label: 'Transaksi', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TransactionsScreen()));
              }),
              _QuickAction(icon: Icons.price_change, label: 'Harga', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PricelistScreen()));
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cs.surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: cs.onSurfaceVariant)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
