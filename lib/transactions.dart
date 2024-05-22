import 'package:flutter/material.dart';
import 'transaction_form.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

//erstellen einer State Klasse, 
//die die obere Klasse überschreibt, um State weiterzuegeben
  @override
 _TransactionsState createState() => _TransactionsState();
}

class NewTextStyle {
  static const TextStyle arialBlack10Bold = TextStyle(
    fontFamily: 'Inter',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
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
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: _userTransactions.isNotEmpty
          ? ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (context, index) {
                bool isPositive = _userTransactions[index]['menge'] >= 0;
                return Container(
                  width: 300,
                  height: 60,
                  decoration : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 227, 220, 220),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                   child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                  
                      Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: isPositive ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.circular(10), 
                          ), 
                        child: Center(
                          child: Text(
                          ' ${_userTransactions[index]['menge']}',
                          style: NewTextStyle.arialBlack10Bold.copyWith(color:Colors.white)
                          ),
                      ), 
                      ),
                      Container(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(' ${_userTransactions[index]['beschreibung']}',
                         style: NewTextStyle.arialBlack10Bold,
                        ),
                      ),
                    ],
                  ),
                ),
                );
              },
            )
          : const Center(
              child: Text('Keine Transaktionen'),
            ),
    ),
  );
}
}

