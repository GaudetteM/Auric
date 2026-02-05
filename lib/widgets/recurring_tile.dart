import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/recurring.dart';
import '../theme/colors.dart';

class RecurringTile extends StatelessWidget {
  final Recurring recurring;

  const RecurringTile({super.key, required this.recurring});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AuricColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            recurring.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${recurring.type == TransactionType.income ? '+' : '-'}\$${recurring.amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: recurring.type == TransactionType.income
                  ? AuricColors.success
                  : AuricColors.danger,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
