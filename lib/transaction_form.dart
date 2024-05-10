import 'package:flutter/material.dart';

//Stafeul - cuz state changes while entering content
class TransactionForm extends StatefulWidget {
  // 
  final Function varSum;
  //übergabe der funktion an meinen konstruktor
  const TransactionForm({Key? key, required this.varSum}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  @override
  Widget build(BuildContext context) {
    return Container(); // Placeholder for now
  }
}