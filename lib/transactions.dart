import 'package:flutter/material.dart';
import 'transaction_form.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

//erstellen einer State Klasse, 
//die die obere Klasse überschreibt, um State weiterzuegeben
  @override
 _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> 
{
//Liste kaydi, kullanici inputlari icin
//C-Lang struct in flutter - map! 
final List<Map<String, dynamic>> _userTransactions =[];

void _startAddNewTransaction (BuildContext context){
showModalBottomSheet(
  context: context, 
  builder: (_){
  return GestureDetector(
          onTap: () {},
          //Tippen unabh. aller Grenzen werden erkannt
          behavior: HitTestBehavior.opaque,
          //ich übergebe varSum and 
          child: TransactionForm(varSum: _addNewTransaction),
        );
      },
  );
}

void _addNewTransaction(String descr, double menge, String monat){
final neuEintrag={
  'beschreibung': descr,
  'menge':menge,
  'datum':monat,
};

 setState(() {
      _userTransactions.add(neuEintrag);
    });
  }



@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaktionen'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.green,
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
}
}