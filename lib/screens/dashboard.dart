import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_spacing.dart';
import '../theme/app_radius.dart';
import '../theme/app_shadows.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Timer _timer;
  DateTime _now = DateTime.now();
  bool _online = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime t) => DateFormat('HH:mm').format(t);
  String _formatDate(DateTime t) => DateFormat('dd.MM.yyyy').format(t);
  String _euro(num v) => NumberFormat('#,##0.00', 'en_US').format(v) + '€';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.pureWhite,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pasqyra Live', style: AppTextStyles.pageTitle(size: 20)),
            const SizedBox(height: 2),
            Text(
              'Manager Dashboard · POS System',
              style: AppTextStyles.muted.copyWith(fontSize: 12),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _online = !_online),
                  child: Chip(
                    backgroundColor: _online
                        ? AppColors.softGreenTint
                        : Colors.grey.shade200,
                    label: Row(
                      children: [
                        Icon(
                          _online ? Icons.wifi : Icons.wifi_off,
                          size: 16,
                          color: AppColors.deepForestGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _online ? 'Live' : 'Offline',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  backgroundColor: Colors.white,
                  label: Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: AppColors.mutedGray,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_formatTime(_now)} · ${_formatDate(_now)}',
                        style: AppTextStyles.muted,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.warmOffWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.base),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // KPI Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.6,
                children: [
                  _kpiCard(
                    Icons.euro,
                    'Totali Sot',
                    _euro(1234.56),
                    '+12.5%',
                    subtitle: null,
                  ),
                  _kpiCard(
                    Icons.schedule,
                    'Turni',
                    _euro(842.10),
                    '+8.2%',
                    subtitle: null,
                  ),
                  _kpiCard(
                    Icons.receipt_long,
                    'Porositë Sot',
                    '34',
                    null,
                    subtitle: '12 të hapura',
                  ),
                  _kpiCard(
                    Icons.hourglass_top,
                    'Hapur Aktualisht',
                    _euro(256.20),
                    null,
                    subtitle: '8 tavolina',
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Waiters Performance + Recent Orders row
              Column(
                children: [
                  _waitersCard(),
                  const SizedBox(height: 12),
                  _recentOrdersCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kpiCard(
    IconData icon,
    String label,
    dynamic value,
    String? trend, {
    String? subtitle,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(color: AppColors.lightGreenBorder, width: 1),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.softGreenTint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: AppColors.deepForestGreen),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        label,
                        style: AppTextStyles.muted.copyWith(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  value.toString(),
                  style: AppTextStyles.kpiValue.copyWith(fontSize: 32),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: AppTextStyles.muted.copyWith(fontSize: 12),
                  ),
                ],
              ],
            ),
            if (trend != null)
              Positioned(
                right: 8,
                top: 8,
                child: Chip(
                  label: Text(trend, style: const TextStyle(fontSize: 12)),
                  backgroundColor: AppColors.softGreenTint,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _waitersCard() {
    final List<Map<String, dynamic>> waiters = [
      {'name': 'Arben', 'paid': 120.0, 'open': 24.0, 'total': 144.0},
      {'name': 'Elira', 'paid': 98.5, 'open': 12.0, 'total': 110.5},
      {'name': 'Krenar', 'paid': 75.0, 'open': 8.5, 'total': 83.5},
      {'name': 'Blerim', 'paid': 60.0, 'open': 5.0, 'total': 65.0},
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(color: AppColors.lightGreenBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.softGreenTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.people, color: AppColors.warmGold),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kamarierët', style: AppTextStyles.cardTitle),
                    const SizedBox(height: 2),
                    Text('Performanca sot', style: AppTextStyles.muted),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Text('Emri', style: AppTextStyles.muted),
                    Text('Paguar', style: AppTextStyles.muted),
                    Text('Hapur', style: AppTextStyles.muted),
                    Text('Total', style: AppTextStyles.muted),
                  ],
                ),
                for (Map<String, dynamic> w in waiters)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: AppColors.deepForestGreen,
                              child: Text(
                                (w['name'] as String)[0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              w['name'] as String,
                              style: AppTextStyles.body,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _euro(w['paid'] as num),
                          style: AppTextStyles.body,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _euro(w['open'] as num),
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.mutedOrange,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          _euro(w['total'] as num),
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentOrdersCard() {
    final List<Map<String, dynamic>> orders = [
      {'time': '09:12', 'waiter': 'Arben', 'table': 'T1', 'total': 12.5},
      {'time': '09:45', 'waiter': 'Elira', 'table': 'T3', 'total': 8.0},
      {'time': '10:02', 'waiter': 'Krenar', 'table': 'T2', 'total': 24.0},
      {'time': '11:15', 'waiter': 'Blerim', 'table': 'T5', 'total': 16.5},
      {'time': '11:52', 'waiter': 'Arben', 'table': 'T4', 'total': 6.0},
      {'time': '12:20', 'waiter': 'Elira', 'table': 'T6', 'total': 10.0},
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: const BorderSide(color: AppColors.lightGreenBorder, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.softGreenTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.receipt_long, color: AppColors.warmGold),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Porositë Sot', style: AppTextStyles.cardTitle),
                    const SizedBox(height: 2),
                    Text('Të fundit', style: AppTextStyles.muted),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  children: [
                    Text('Koha', style: AppTextStyles.muted),
                    Text('Kamarier', style: AppTextStyles.muted),
                    Text('Tavolina', style: AppTextStyles.muted),
                    Text('Total', style: AppTextStyles.muted),
                  ],
                ),
                for (Map<String, dynamic> o in orders)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(o['time'] as String),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(o['waiter'] as String),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softGreenTint,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(o['table'] as String),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(_euro(o['total'] as num)),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
