import 'package:flutter/material.dart';
import 'transaction_form.dart';


class Transactions extends StatefulWidget {
  const Transactions({super.key});

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
//List for user inputs 
final List<Map<String, dynamic>> _userTransactions =[];

//Map -> one sumVariable for each month i have 
final Map<String, double> _sumTransactionsMonth ={};

void _deleteTransaction(String beschreibung, double menge, String monat){
  setState((){
    _userTransactions.removeWhere((transaction)=> 
      transaction['beschreibung'] == beschreibung && transaction['menge']==menge);
     
    if(_sumTransactionsMonth.containsKey(monat)){
      _sumTransactionsMonth[monat]= _sumTransactionsMonth[monat]! -menge;
    }
 
  });
}

void _startAddNewTransaction (BuildContext context){
showModalBottomSheet(
  context: context, 
  builder: (_){
  return GestureDetector(
          onTap: () {},
          //opaque- hinders cklick on background widgets
          behavior: HitTestBehavior.opaque,
          //Handing over “varsum” to calculate the sum at the end
          child: TransactionForm(varSum: _addNewTransaction),
        );
      },
  );
}
//every new userinput -> leads to new "neuEintrag" -coming from formular
void _addNewTransaction(String descr, double menge, String monat){
final neuEintrag={
  'beschreibung': descr,
  'menge':menge,
  'monat':monat,
};


 setState(() {
      _userTransactions.add(neuEintrag);

      if (_sumTransactionsMonth.containsKey(monat)){
        _sumTransactionsMonth[monat] = _sumTransactionsMonth[monat]! + menge;
      } else {
        _sumTransactionsMonth[monat] = menge;
      }
    });
  }



@override
Widget build(BuildContext context) {
  // new List for my groupedtransactions -> divided by months
  // first - check if there is the current month existing in my list (no null!)
  // then adding it into my groupT-list from my old _userTransaction -list
  // if the month is not exisiting, we create new List for current month
  //for me: meine map enthält die verschiedenen Listen, die Listen haben die Monatsnamen als Keys
    Map<String, List<Map<String, dynamic>>> groupedTransactions = {};
    for (var transaction in _userTransactions) {
      String month = transaction['monat'];
      if (groupedTransactions.containsKey(month)) {
        groupedTransactions[month]!.add(transaction);
      } else {
        groupedTransactions[month] = [transaction];
      }
    }

    List<String> months = groupedTransactions.keys.toList();
    months.sort((a, b)=> monthsInorder.indexOf(a).compareTo(monthsInorder.indexOf(b)));
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
            //für jeden Monat wird ein column widget erstellt
            //mit verschiendnen kindderwidgets
              itemCount: months.length,
              itemBuilder: (context, monthIndex) {
                 String month = months[monthIndex];
                  List<Map<String, dynamic>> transactions = groupedTransactions[month]!;
                  
                  double currentSumMonth= _sumTransactionsMonth[month] ?? 0.0; 
                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text('$month - Summe : $currentSumMonth',
          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,
          ),
          ),
),

//for me:Spread Operator übernimmt meine Transaktionen liste und entpackt sie einzeln
// im column - so als würde man sie hier selbste inzeln codiren....
...transactions.asMap().entries.map((entry) {
    int transactionIndex=entry.key;
    Map <String, dynamic> transaction= entry.value;
   bool isPositive = transaction['menge'] >= 0;

                     
               // bool isPositive = _userTransactions[index]['menge'] >= 0;
                return Dismissible(
                  //key to identify my widget
                  key: Key(transaction['beschreibung']+ transaction['menge'].toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction){
                    //set new state! see top
                    _deleteTransaction(transaction['beschreibung'],transaction['menge'], transaction['monat'],);
                  //  ScaffoldMessenger.of(context)
                    //.showSnackBar(SnackBar(content: Text('$transactionIndex deleted')));
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  
               
                  child: Container(
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
                          ' ${transaction['menge']}',
                          style: NewTextStyle.arialBlack10Bold.copyWith(color:Colors.white)
                          ),
                      ), 
                      ),
                      Container(
                         padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(' ${transaction['beschreibung']}',
                         style: NewTextStyle.arialBlack10Bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                );
              }
            ).toList(),
                    ],
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

