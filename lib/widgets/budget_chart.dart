import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/mock_data.dart';
import '../models/transaction.dart';
import '../theme/colors.dart';

class BudgetChart extends StatelessWidget {
  const BudgetChart({super.key});

  @override
  Widget build(BuildContext context) {
    final double incomeTotal = mockRecurring
        .where((r) => r.type == TransactionType.income)
        .fold(0.0, (sum, r) => sum + r.amount);
    final double expenseTotal = mockRecurring
        .where((r) => r.type == TransactionType.expense)
        .fold(0.0, (sum, r) => sum + r.amount);

    final double maxValue =
        (incomeTotal > expenseTotal ? incomeTotal : expenseTotal) * 1.2;

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuricColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BarChart(
        BarChartData(
          maxY: maxValue,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barsSpace: 16,
              barRods: [
                // Income Bar
                BarChartRodData(
                  toY: incomeTotal,
                  width: 24,
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [
                      AuricColors.success.withOpacity(0.7),
                      AuricColors.success,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxValue,
                    color: AuricColors.background.withOpacity(0.3),
                  ),
                ),
                // Expenses Bar
                BarChartRodData(
                  toY: expenseTotal,
                  width: 24,
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                    colors: [
                      AuricColors.danger.withOpacity(0.7),
                      AuricColors.danger,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: maxValue,
                    color: AuricColors.background.withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ],
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text('Income', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 16),
                      Text('Expenses', style: TextStyle(color: Colors.white)),
                    ],
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
        swapAnimationDuration: const Duration(milliseconds: 800),
        swapAnimationCurve: Curves.easeOutCubic,
      ),
    );
  }
}
