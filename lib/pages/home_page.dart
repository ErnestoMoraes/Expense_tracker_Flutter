import 'package:flutter/material.dart';

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
            child:const  Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  void save() {}
  void cancel() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        centerTitle: true,
      ),
      body: Container(),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
