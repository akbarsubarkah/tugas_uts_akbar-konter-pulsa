import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/transaction.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionItem item;
  const TransactionDetailScreen({super.key, required this.item});

  Color _statusColor(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return item.status == 'success' ? cs.primary : cs.error;
  }

  IconData _statusIcon() {
    return item.status == 'success' ? Icons.check_circle : Icons.error;
  }

  String _formatTime(DateTime t) {
    final d = '${t.day.toString().padLeft(2, '0')}/${t.month.toString().padLeft(2, '0')}/${t.year}';
    final tm = '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    return '$d • $tm';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final statusColor = _statusColor(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Transaksi')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [statusColor.withValues(alpha: 0.85), statusColor.withValues(alpha: 0.55)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(_statusIcon(), color: statusColor, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.status == 'success' ? 'Transaksi Berhasil' : 'Transaksi Gagal',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTime(item.time),
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Rp ${item.product.price}',
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tag, color: cs.primary),
                            const SizedBox(width: 8),
                            const Text('Informasi Pesanan', style: TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(label: 'ID Transaksi', value: item.id, copyable: true),
                        _InfoRow(label: 'Nomor HP', value: item.phone, copyable: true),
                        _InfoRow(label: 'Operator', value: item.product.operatorName),
                        _InfoRow(label: 'Produk', value: item.product.name),
                        _InfoRow(label: 'Harga', value: 'Rp ${item.product.price}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (item.message != null)
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info, color: cs.primary),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item.message!)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      final text = 'ID: ${item.id}\nNomor: ${item.phone}\nProduk: ${item.product.name}\nHarga: Rp ${item.product.price}';
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Disalin ke clipboard')));
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Salin'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool copyable;
  const _InfoRow({required this.label, required this.value, this.copyable = false});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(color: cs.onSurfaceVariant))),
          Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
          if (copyable)
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Disalin')));
              },
            ),
        ],
      ),
    );
  }
}
