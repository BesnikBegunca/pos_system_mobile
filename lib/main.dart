import 'package:flutter/material.dart';
import 'theme/app_colors.dart';
import 'theme/app_text_styles.dart';
import 'theme/app_spacing.dart';
import 'theme/app_radius.dart';
import 'theme/app_shadows.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.deepForestGreen,
      primary: AppColors.deepForestGreen,
      surface: AppColors.pureWhite,
      onSurface: AppColors.charcoalText,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'POS Stats',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        scaffoldBackgroundColor: AppColors.warmOffWhite,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.pureWhite,
          elevation: 0,
          titleTextStyle: AppTextStyles.sectionTitle,
          iconTheme: IconThemeData(color: AppColors.deepForestGreen),
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: AppColors.pureWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepForestGreen,
            foregroundColor: AppColors.pureWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.deepForestGreen,
            side: const BorderSide(color: AppColors.lightGreenBorder),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.button),
            ),
            minimumSize: const Size.fromHeight(48),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.pureWhite,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightGreenBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightGreenBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppColors.deepForestGreen, width: 2),
          ),
          hintStyle: const TextStyle(
            color: AppColors.lightGreenText,
            fontSize: 14,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.deepForestGreen,
          contentTextStyle: const TextStyle(color: Colors.white),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.softGreenTint,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.dialog),
          ),
          elevation: 0,
          titleTextStyle: AppTextStyles.cardTitle,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 1,
      'title': 'Porosia #1',
      'items': 'Çaj, Kafe, Pizza',
      'price': 12.50,
      'time': '2026-05-15 09:12',
    },
    {
      'id': 2,
      'title': 'Porosia #2',
      'items': 'Kafe',
      'price': 2.50,
      'time': '2026-05-16 11:03',
    },
    {
      'id': 3,
      'title': 'Porosia #3',
      'items': 'Pizza',
      'price': 8.00,
      'time': '2026-05-16 12:20',
    },
  ];

  Widget _buildProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 36,
                child: Icon(Icons.person, size: 36),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emri: Agron D.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Biznesi: Kafe & Pizza',
                    style: TextStyle(color: AppColors.mediumGreenText),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tel: +355 69 000 0000',
                    style: TextStyle(color: AppColors.mediumGreenText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.storefront),
              title: const Text('Adresa e biznesit'),
              subtitle: const Text('Rruga Kryesore 12, Tiranë'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('agron@example.com'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrders() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.receipt_long,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            title: Text('${order['title']} - ${order['items']}'),
            subtitle: Text(order['time']),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${order['price'].toStringAsFixed(2)}€',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${order['id']}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatus() {
    final latest = _orders.isNotEmpty ? _orders.last : null;
    final total = _orders.fold<double>(
      0,
      (sum, o) => sum + (o['price'] as double),
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Porosia e fundit',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(latest != null ? '${latest['items']}' : '—'),
                        const SizedBox(height: 8),
                        Text(
                          latest != null
                              ? '${latest['price'].toStringAsFixed(2)}€'
                              : '0.00€',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.pie_chart, color: AppColors.mutedOrange),
                            SizedBox(width: 8),
                            Text(
                              'Totali porosive',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_orders.length} porosi',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${total.toStringAsFixed(2)}€',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: AppColors.infoBlue),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Kohë (i lejuar për momentin)')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyForIndex(int index) {
    switch (index) {
      case 0:
        return _buildProfile();
      case 1:
        return _buildOrders();
      case 2:
        return _buildStatus();
      default:
        return const Center(child: Text('Pa përmbajtje'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('POS Stats')),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CircleAvatar(
                      radius: 28,
                      child: Icon(Icons.storefront, size: 28),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'POS Statistics',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Mobile-only analytics',
                      style: TextStyle(color: AppColors.lightGreenText),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profili'),
                selected: _selectedIndex == 0,
                onTap: () {
                  setState(() => _selectedIndex = 0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.list_alt),
                title: const Text('Porosite'),
                selected: _selectedIndex == 1,
                onTap: () {
                  setState(() => _selectedIndex = 1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.insights),
                title: const Text('Gjendja'),
                selected: _selectedIndex == 2,
                onTap: () {
                  setState(() => _selectedIndex = 2);
                  Navigator.pop(context);
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Rreth'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: _bodyForIndex(_selectedIndex),
    );
  }
}
