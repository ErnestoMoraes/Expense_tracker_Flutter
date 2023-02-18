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
  final dollarEC = TextEditingController();
  final centsEC = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    Provider.of<ExpanseData>(context, listen: false).prepareData();
  }

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
              decoration: const InputDecoration(hintText: 'Expense name'),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dollarEC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Dollars'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: centsEC,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Cents'),
                  ),
                ),
              ],
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
    String amountEC = '${dollarEC.text}.${centsEC.text}';
    ExpenseItem newExpense = ExpenseItem(
      name: nameEC.text,
      amount: amountEC,
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
    dollarEC.clear();
    centsEC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpanseData>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            backgroundColor: Colors.black,
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: [
              // week summary
              ExpenseSumary(startOfWeek: value.startOfWeekDate()),
              const SizedBox(height: 20),
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
