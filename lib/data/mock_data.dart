import '../models/recurring.dart';
import '../models/transaction.dart';

final List<Recurring> mockRecurring = [
  Recurring(
    id: '1',
    title: 'Rent',
    amount: 1200.0,
    type: TransactionType.expense,
    startDate: DateTime(2026, 2, 5),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '2',
    title: 'Spotify',
    amount: 9.99,
    type: TransactionType.expense,
    startDate: DateTime(2026, 2, 10),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '3',
    title: 'Salary',
    amount: 4000.0,
    type: TransactionType.income,
    startDate: DateTime(2026, 2, 1),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '4',
    title: 'Freelance Project',
    amount: 600.0,
    type: TransactionType.income,
    startDate: DateTime(2026, 2, 15),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '5',
    title: 'Electricity Bill',
    amount: 120.0,
    type: TransactionType.expense,
    startDate: DateTime(2026, 2, 12),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '6',
    title: 'Internet',
    amount: 60.0,
    type: TransactionType.expense,
    startDate: DateTime(2026, 2, 8),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '7',
    title: 'Gym',
    amount: 45.0,
    type: TransactionType.expense,
    startDate: DateTime(2026, 2, 3),
    interval: RecurringInterval.monthly,
  ),
  Recurring(
    id: '8',
    title: 'Side Project Income',
    amount: 300.0,
    type: TransactionType.income,
    startDate: DateTime(2026, 2, 20),
    interval: RecurringInterval.monthly,
  ),
];
