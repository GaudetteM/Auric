import 'package:hive/hive.dart';
import 'transaction.dart';

part 'recurring.g.dart';

@HiveType(typeId: 1)
enum RecurringInterval {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  biweekly,
  @HiveField(3)
  monthly,
  @HiveField(4)
  yearly,
}

@HiveType(typeId: 2)
class Recurring {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final TransactionType type;
  @HiveField(4)
  final DateTime startDate;
  @HiveField(5)
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
