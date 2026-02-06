import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/recurring.dart';
import 'models/transaction.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecurringIntervalAdapter());
  Hive.registerAdapter(RecurringAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Recurring>('recurring');
  await Hive.openBox<Transaction>('transactions');
  runApp(const AuricApp());
}
