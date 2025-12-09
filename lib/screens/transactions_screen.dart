import 'package:flutter/material.dart';
import '../state/transaction_store.dart';
import 'transaction_detail_screen.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = TransactionStore.all();

    return Scaffold(
      appBar: AppBar(title: const Text('Transaksi')),
      body: items.isEmpty
          ? const Center(child: Text('Belum ada transaksi'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, _) => const Divider(height: 0),
              itemBuilder: (context, index) {
                final it = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(it.product.type == 'pulsa' ? Icons.phone_android : Icons.wifi),
                  ),
                  title: Text(it.product.name),
                  subtitle: Text('${it.phone} • ${it.product.operatorName}'),
                  trailing: Text('Rp ${it.product.price}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TransactionDetailScreen(item: it),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
