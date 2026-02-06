import 'package:hive/hive.dart';
import '../models/recurring.dart';
import '../models/transaction.dart';

class LocalDataService {
  static final recurringBox = Hive.box<Recurring>('recurring');
  static final transactionBox = Hive.box<Transaction>('transactions');

  // Recurring CRUD
  static List<Recurring> getRecurring() => recurringBox.values.toList();

  static Future<void> addRecurring(Recurring item) async {
    await recurringBox.put(item.id, item);
  }

  static Future<void> deleteRecurring(String id) async {
    await recurringBox.delete(id);
  }

  // Transaction CRUD
  static List<Transaction> getTransactions() => transactionBox.values.toList();

  static Future<void> addTransaction(Transaction item) async {
    await transactionBox.put(item.id, item);
  }

  static Future<void> deleteTransaction(String id) async {
    await transactionBox.delete(id);
  }
}
