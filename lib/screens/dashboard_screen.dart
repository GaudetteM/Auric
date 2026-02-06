import 'package:auric/models/recurring.dart';
import 'package:auric/models/transaction.dart';
import 'package:auric/screens/add_recurring_screen.dart';
import 'package:auric/theme/spacing.dart';
import 'package:auric/theme/typography.dart';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/budget_chart.dart';
import '../data/local_data_service.dart';
import '../widgets/recurring_tile.dart';
import 'add_recurring_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
    bool showChart = false;
  Future<void> _editRecurring(Recurring item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddRecurringScreen(editItem: item)),
    );
    if (result == true) {
      setState(() {
        recurringItems = LocalDataService.getRecurring()
            .whereType<Recurring>()
            .toList();
        final uniquePeriods =
            recurringItems
                .map((r) => DateTime(r.startDate.year, r.startDate.month))
                .toSet()
                .toList()
              ..sort((a, b) => b.compareTo(a));
        availablePeriods = uniquePeriods;
        selectedPeriod = availablePeriods.isNotEmpty
            ? availablePeriods.first
            : DateTime.now();
      });
    }
  }

  Future<void> _addRecurring() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddRecurringScreen()),
    );
    if (result == true) {
      setState(() {
        recurringItems = LocalDataService.getRecurring()
            .whereType<Recurring>()
            .toList();
        final uniquePeriods =
            recurringItems
                .map((r) => DateTime(r.startDate.year, r.startDate.month))
                .toSet()
                .toList()
              ..sort((a, b) => b.compareTo(a));
        availablePeriods = uniquePeriods;
        selectedPeriod = availablePeriods.isNotEmpty
            ? availablePeriods.first
            : DateTime.now();
      });
    }
  }

  late List<DateTime> availablePeriods;
  late DateTime selectedPeriod;
  List<Recurring> recurringItems = [];

  @override
  void initState() {
    super.initState();
    recurringItems = LocalDataService.getRecurring()
        .whereType<Recurring>()
        .toList();
    final uniquePeriods =
        recurringItems
            .where((r) => r != null)
            .map((r) => DateTime(r.startDate.year, r.startDate.month))
            .toSet()
            .toList()
          ..sort((a, b) => b.compareTo(a));
    availablePeriods = uniquePeriods;
    selectedPeriod = availablePeriods.isNotEmpty
        ? availablePeriods.first
        : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate totals for selected period
    final periodRecurring = recurringItems.where(
      (r) =>
              // Balance summary card (tap to show chart)
              GestureDetector(
                onTap: () => setState(() => showChart = !showChart),
                child: Container(
                  decoration: BoxDecoration(
                    color: AuricColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: AuricSpacing.md,
                    horizontal: AuricSpacing.lg,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Balance', style: AuricTypography.title),
                          SizedBox(height: AuricSpacing.xs),
                          Text(
                            '4${netBalance.toStringAsFixed(2)}', // $ symbol
                            style: AuricTypography.headline2.copyWith(
                              color: netBalance >= 0
                                  ? AuricColors.success
                                  : AuricColors.danger,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Income', style: AuricTypography.caption),
                          Text(
                            '4${totalIncome.toStringAsFixed(2)}', // $ symbol
                            style: AuricTypography.body.copyWith(
                              color: AuricColors.success,
                            ),
                          ),
                          SizedBox(height: AuricSpacing.xs),
                          Text('Expenses', style: AuricTypography.caption),
                          Text(
                            '4${totalExpense.toStringAsFixed(2)}', // $ symbol
                            style: AuricTypography.body.copyWith(
                              color: AuricColors.danger,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: AuricSpacing.md,
                  horizontal: AuricSpacing.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Balance', style: AuricTypography.title),
                        SizedBox(height: AuricSpacing.xs),
                        Text(
                          '\$${netBalance.toStringAsFixed(2)}', // $ symbol
                          style: AuricTypography.headline2.copyWith(
                            color: netBalance >= 0
                                ? AuricColors.success
                                : AuricColors.danger,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Income', style: AuricTypography.caption),
                        Text(
                          '\$${totalIncome.toStringAsFixed(2)}', // $ symbol
                          style: AuricTypography.body.copyWith(
                            color: AuricColors.success,
                          ),
                        ),
                        SizedBox(height: AuricSpacing.xs),
                        Text('Expenses', style: AuricTypography.caption),
                        Text(
                          '\$${totalExpense.toStringAsFixed(2)}', // $ symbol
                          style: AuricTypography.body.copyWith(
                            color: AuricColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (showChart) ...[
                SizedBox(height: AuricSpacing.lg),
                Container(
                  decoration: BoxDecoration(
                    color: AuricColors.surface,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(AuricSpacing.md),
                  child: const BudgetChart(),
                ),
              ],
              SizedBox(height: AuricSpacing.lg),
              Text('Upcoming Bills & Income', style: AuricTypography.title),
              SizedBox(height: AuricSpacing.sm),
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: recurringItems.length,
                    itemBuilder: (context, index) {
                      final item = recurringItems[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 400),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Container(
                              margin: EdgeInsets.only(bottom: AuricSpacing.sm),
                              decoration: BoxDecoration(
                                color: AuricColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: RecurringTile(
                                recurring: item,
                                onEdit: () => _editRecurring(item),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AuricColors.primary,
        onPressed: _addRecurring,
        child: const Icon(Icons.add),
      ),
    );
  }
}
