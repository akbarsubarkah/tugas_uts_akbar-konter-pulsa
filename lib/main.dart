import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/topup_screen.dart';
import 'screens/data_package_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/pricelist_screen.dart';
import 'screens/login_screen.dart';
import 'state/auth_store.dart';

void main() {
  runApp(const KonterPulsaApp());
}

class KonterPulsaApp extends StatelessWidget {
  const KonterPulsaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konter Pulsa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: ValueListenableBuilder(
        valueListenable: AuthStore.currentUser,
        builder: (context, user, _) {
          if (user == null) return const LoginScreen();
          return const HomeShell();
        },
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TopUpScreen(),
    DataPackageScreen(),
    TransactionsScreen(),
    PricelistScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.phone_android), label: 'Isi Pulsa'),
          NavigationDestination(icon: Icon(Icons.wifi), label: 'Paket Data'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Transaksi'),
          NavigationDestination(icon: Icon(Icons.price_change), label: 'Harga'),
        ],
      ),
    );
  }
}
