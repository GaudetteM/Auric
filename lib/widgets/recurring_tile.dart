import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../models/recurring.dart';
import '../theme/colors.dart';

class RecurringTile extends StatelessWidget {
  final Recurring recurring;
  final VoidCallback? onEdit;

  const RecurringTile({super.key, required this.recurring, this.onEdit});

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
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recurring.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '${recurring.type == TransactionType.income ? '+' : '-'}\$${recurring.amount.abs().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: recurring.type == TransactionType.income
                        ? AuricColors.success
                        : AuricColors.danger,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (onEdit != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                onPressed: onEdit,
                tooltip: 'Edit',
              ),
            ),
        ],
      ),
    );
  }
}
