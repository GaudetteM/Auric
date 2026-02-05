import 'transaction.dart';

enum RecurringInterval { daily, weekly, monthly, yearly }

class Recurring {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final DateTime startDate;
  final RecurringInterval interval;

  Recurring({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.startDate,
    required this.interval,
  });
}
