// ignore_for_file: file_names, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'package:foodies/widgets/transactionList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../widgets/chart.dart';
import '../widgets/newTransaction.dart';

class ExpanseHomeScreen extends StatefulWidget {
  const ExpanseHomeScreen({super.key});
  @override
  _ExpanseHomeScreenState createState() => _ExpanseHomeScreenState();
}

class _ExpanseHomeScreenState extends State<ExpanseHomeScreen>
    with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _loadTransactions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getStringList('transactions') ?? [];
    setState(() {
      _userTransactions.clear();
      _userTransactions.addAll(transactions.map((tx) {
        final decodedTx = json.decode(tx);
        return Transaction(
          id: decodedTx['id'],
          title: decodedTx['title'],
          amount: decodedTx['amount'],
          date: DateTime.parse(decodedTx['date']),
        );
      }).toList());
    });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) async {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    // Save transaction to shared preferences
    final prefs = await SharedPreferences.getInstance();
    final transactionData = {
      'id': newTx.id,
      'title': newTx.title,
      'amount': newTx.amount,
      'date': newTx.date.toIso8601String(),
    };
    final transactions = prefs.getStringList('transactions') ?? [];
    transactions.add(json.encode(transactionData));
    prefs.setStringList('transactions', transactions);

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
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) async {
    // Remove transaction from shared preferences
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getStringList('transactions') ?? [];
    transactions.removeWhere((tx) => json.decode(tx)['id'] == id);
    prefs.setStringList('transactions', transactions);

    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Show Chart',
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          Switch(
            activeColor: sliderColor,
            activeTrackColor: white30Color,
            inactiveThumbColor: white54Color,
            inactiveTrackColor: white60Color,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: bgColor,
      title: const Text(
        'Weekly Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
    final txListWidget = SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandScape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: const Icon(
          Icons.add,
          color: bgColor,
          size: 30,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
