// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      redColor,
      blueColor,
      greenColor,
      orangeColor,
      purpleColor,
      tealColor,
      pinkColor,
      indigoColor,
      limeColor,
      amberColor,
      brownColor,
      deepPurpleColor,
      deepOrangeColor,
    ];
    _bgColor = availableColors[Random().nextInt(13)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: white30Color,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            20), // Adjust the circular border radius as needed
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 20,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '€${widget.transaction.amount}',
                style: const TextStyle(
                    color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: const TextStyle(color: textColor),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: const TextStyle(color: white60Color),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: redColor,
                ),
                label: const Text('Delete', style: TextStyle(color: textColor)),
                onPressed: () => deleteTrasaction(context),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: redColor,
                ),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTrasaction(context),
              ),
      ),
    );
  }

  Future<dynamic> deleteTrasaction(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: white30Color,
        title: const Text(
          "Are you sure you want to delete this ",
          style: TextStyle(color: whiteColor),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: redColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            onPressed: () {
              widget.deleteTx(widget.transaction.id);
              Navigator.pop(context);
            },
            child: const Text('Yes', style: TextStyle(color: whiteColor)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No', style: TextStyle(color: whiteColor)),
          ),
        ],
      ),
    );
  }
}
