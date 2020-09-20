import 'package:daily_routine/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return Card(
          elevation: 1,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(10),
                child:
                    FittedBox(child: Text('\$${transactions[index].amount}')),
              ),
            ),
            title: Text(
              transactions[index].title,
              style: Theme.of(context).textTheme.title,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transactions[index].date),
            ),
            trailing: MediaQuery.of(context).size.width > 460
                ? FlatButton.icon(
                    label: Text('Delete'),
                    onPressed: () => deleteTx(transactions[index].id),
                    icon: Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                  )
                : IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(transactions[index].id)),
          ),
        );
      },
      itemCount: transactions.length,
    );
  }
}
