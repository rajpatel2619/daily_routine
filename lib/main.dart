import 'package:daily_routine/widgets/chart.dart';
import 'package:daily_routine/widgets/new_transaction.dart';
import 'package:daily_routine/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:daily_routine/models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weekly Expanses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 17),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New groceries', amount: 89.99, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Weekly Expanses'),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: (_userTransactions.isEmpty)
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'No Transactions ( ^ _ ^ ) ',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 25),
                  ),
                  // SizedBox(
                  //   height: 70,
                  // ),
                  Image(image: AssetImage("assets/images/money.png")),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.3,
                      child: Chart(_recentTransactions)),
                  Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      child: TransactionList(
                          _userTransactions, _deleteTransaction)),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
