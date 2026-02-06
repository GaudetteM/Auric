import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/local_data_service.dart';
import '../models/transaction.dart';
import '../theme/colors.dart';

class BudgetChart extends StatelessWidget {
  const BudgetChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Gather recurring and transaction data
    final recurring = LocalDataService.getRecurring();
    final transactions = LocalDataService.getTransactions();

    // Build a timeline of dates and net balance
    final List<DateTime> dates = [];
    final Map<DateTime, double> balanceByDate = {};

    // Add all recurring and transaction dates to the timeline
    for (final r in recurring) {
      dates.add(r.startDate);
    }
    for (final t in transactions) {
      dates.add(t.date);
    }
    dates.sort();
    // Remove duplicates
    final uniqueDates = dates.toSet().toList()..sort();

    double runningBalance = 0;
    for (final date in uniqueDates) {
      // Add all recurring for this date
      for (final r in recurring.where((r) => r.startDate == date)) {
        runningBalance += r.type == TransactionType.income
            ? r.amount
            : -r.amount;
      }
      // Add all transactions for this date
      for (final t in transactions.where((t) => t.date == date)) {
        runningBalance += t.type == TransactionType.income
            ? t.amount
            : -t.amount;
      }
      balanceByDate[date] = runningBalance;
    }

    final spots = <FlSpot>[];
    for (int i = 0; i < uniqueDates.length; i++) {
      spots.add(FlSpot(i.toDouble(), balanceByDate[uniqueDates[i]] ?? 0));
    }

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuricColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          minY: spots.isEmpty
              ? 0
              : spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) * 0.9,
          maxY: spots.isEmpty
              ? 100
              : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) * 1.1,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AuricColors.primary,
              barWidth: 4,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AuricColors.primary.withOpacity(0.3),
                    AuricColors.surface.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= uniqueDates.length) return Container();
                  final date = uniqueDates[idx];
                  return Text(
                    '${date.month}/${date.day}',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
        // Removed swapAnimationDuration and swapAnimationCurve for compatibility
      ),
    );
  }
}
