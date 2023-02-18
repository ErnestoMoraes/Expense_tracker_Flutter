import 'package:expense_tracker/components/expense_sumary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expanse_data.dart';
import 'package:expense_tracker/expense/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameEC = TextEditingController();
  final amountEC = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameEC,
            ),
            TextField(
              controller: amountEC,
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: nameEC.text,
      amount: amountEC.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpanseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clearControllers();
  }

  void cancel() {
    Navigator.pop(context);
    clearControllers();
  }

  void clearControllers() {
    nameEC.clear();
    amountEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpanseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
             // week summary
              ExpenseSumary(startOfWeek: value.startOfWeekDate()),
              // expense list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpanseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpanseList()[index].name,
                  amount: value.getAllExpanseList()[index].amount,
                  dateTime: value.getAllExpanseList()[index].dateTime,
                ),
              ),
            ],
          )),
    );
  }
}
