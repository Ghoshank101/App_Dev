import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        ExpenseScreen.routeName: (context) => ExpenseScreen(),
        AddExpenseScreen.routeName: (context) => AddExpenseScreen(),
      },
      theme: ThemeData(
        textTheme: TextTheme(
          // Set the default text style with white color
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
          // You can add more TextStyle properties as needed for different text styles
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData = {
    'name': 'Arjun Patel',
    'email': 'arjun.patel1987@gmail.com',
  };

  final List<Map<String, dynamic>> categories = [
    {'name': 'Food', 'total': 100},
    {'name': 'Transportation', 'total': 50},
    {'name': 'Entertainment', 'total': 80},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Budget Tracker')),
      body: Stack(
        children: [
          Image.network(
            'https://cdn.pixabay.com/photo/2021/10/07/15/24/money-6688955_1280.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Profile Info:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['name']),
                subtitle: Text(userData['email']),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Expense Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.money),
                title: Text('Total: Rs. 230'), // Replace with the actual total
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Categories:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(categories[index]['name']),
                      subtitle:
                          Text('Total: Rs. ${categories[index]['total']}'),
                      onTap: () {
                        Navigator.pushNamed(context, ExpenseScreen.routeName,
                            arguments: categories[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  static const routeName = '/expense';

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Map<String, dynamic>> expenses = [
    {'value': 30, 'description': 'Lunch'},
    {'value': 20, 'description': 'Dinner'},
  ];

  void _removeExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryData['name']),
      ),
      body: Stack(
        children: [
          Image.network(
            'https://cdn.pixabay.com/photo/2021/10/07/15/24/money-6688955_1280.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Expenses:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.money),
                      title: Text('Value: Rs. ${expenses[index]['value']}'),
                      subtitle: Text(expenses[index]['description']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _removeExpense(index),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddExpenseScreen.routeName);
                },
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AddExpenseScreen extends StatefulWidget {
  static const routeName = '/addExpense';

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  TextEditingController _valueController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Expense Value'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Expense Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save the expense data and go back to the previous screen
                final newExpense = {
                  'value': int.tryParse(_valueController.text) ?? 0,
                  'description': _descriptionController.text,
                };
                Navigator.pop(context, newExpense);
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
