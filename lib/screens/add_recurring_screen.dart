import 'package:flutter/material.dart';
import '../models/recurring.dart';
import '../models/transaction.dart';
import '../data/local_data_service.dart';
import '../theme/colors.dart';
import '../theme/spacing.dart';
import '../theme/typography.dart';

class AddRecurringScreen extends StatefulWidget {
  final Recurring? editItem;
  const AddRecurringScreen({super.key, this.editItem});

  @override
  State<AddRecurringScreen> createState() => _AddRecurringScreenState();
}

class _AddRecurringScreenState extends State<AddRecurringScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  double amount = 0;
  TransactionType type = TransactionType.expense;
  DateTime startDate = DateTime.now();
  RecurringInterval interval = RecurringInterval.monthly;

  @override
  void initState() {
    super.initState();
    final item = widget.editItem;
    if (item != null) {
      title = item.title;
      amount = item.amount;
      type = item.type;
      startDate = item.startDate;
      interval = item.interval;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.editItem == null ? 'Add Recurring' : 'Edit Recurring'),
        backgroundColor: AuricColors.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                style: AuricTypography.body,
                onChanged: (val) => setState(() => title = val),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Enter a title' : null,
              ),
              SizedBox(height: AuricSpacing.md),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                style: AuricTypography.body,
                keyboardType: TextInputType.number,
                onChanged: (val) =>
                    setState(() => amount = double.tryParse(val) ?? 0),
                validator: (val) => val == null || double.tryParse(val) == null
                    ? 'Enter a valid amount'
                    : null,
              ),
              SizedBox(height: AuricSpacing.md),
              DropdownButtonFormField<TransactionType>(
                value: type,
                decoration: const InputDecoration(labelText: 'Type'),
                items: TransactionType.values
                    .map(
                      (t) => DropdownMenuItem(
                        value: t,
                        child: Text(
                          t == TransactionType.income ? 'Income' : 'Expense',
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) =>
                    setState(() => type = val ?? TransactionType.expense),
              ),
              SizedBox(height: AuricSpacing.md),
              DropdownButtonFormField<RecurringInterval>(
                value: interval,
                decoration: const InputDecoration(labelText: 'Interval'),
                items: RecurringInterval.values.map((i) {
                  String label = i.name[0].toUpperCase() + i.name.substring(1);
                  if (i == RecurringInterval.biweekly) label = 'Biweekly';
                  return DropdownMenuItem(value: i, child: Text(label));
                }).toList(),
                onChanged: (val) =>
                    setState(() => interval = val ?? RecurringInterval.monthly),
              ),
              SizedBox(height: AuricSpacing.md),
              ListTile(
                title: Text(
                  'Start Date: ${startDate.toLocal().toString().split(' ')[0]}',
                ),
                trailing: Icon(
                  Icons.calendar_today,
                  color: AuricColors.primary,
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: startDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) setState(() => startDate = picked);
                },
              ),
              SizedBox(height: AuricSpacing.lg),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuricColors.primary,
                  padding: EdgeInsets.symmetric(vertical: AuricSpacing.md),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newRecurring = Recurring(
                      id: widget.editItem?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      amount: amount,
                      type: type,
                      startDate: startDate,
                      interval: interval,
                    );
                    LocalDataService.addRecurring(newRecurring);
                    Navigator.pop(context, true);
                  }
                },
                child: Text(
                  widget.editItem == null ? 'Add' : 'Save',
                  style: AuricTypography.title.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
