import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/budget_chart.dart';
import '../data/mock_data.dart';
import '../widgets/recurring_tile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Auric',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AuricColors.primary,
                ),
              ),
              const SizedBox(height: 24),
              const BudgetChart(),
              const SizedBox(height: 24),
              Text(
                'Upcoming Bills & Income',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AuricColors.secondary,
                ),
              ),
              const SizedBox(height: 12),
              // Animated list of recurring items
              Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemCount: mockRecurring.length,
                    itemBuilder: (context, index) {
                      final item = mockRecurring[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 400),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: RecurringTile(recurring: item),
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
    );
  }
}
