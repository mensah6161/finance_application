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
  //zwei eingabe felder
  final beschreibungsVal = TextEditingController();
  final mengenVal = TextEditingController();
  // Liste der Monate
  final List<String> monate = [
    'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
    'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
  ];
    //? damit es auch wert null annehmen kann oder late
 String? selectedMonat; 


  void _submitData() {
    final enteredBeschreib = beschreibungsVal.text;
    final enteredMenge = double.tryParse(mengenVal.text);
    if (enteredBeschreib.isEmpty || enteredMenge == null || selectedMonat == null) {
      print("Missing inputs!");
     return;  
    }
//Übergabe der werte an varSum funktion:
//selected Monat daha eklenmedi....
//varsum i transactiona yollamam lazim!
    widget.varSum(
      enteredBeschreib,
      enteredMenge,
      selectedMonat,
    );
//after enter close of bottomform
    Navigator.of(context).pop();  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Neue Transaktion'),
      ),
      body: SingleChildScrollView(  // Macht das Formular scrollbar
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: beschreibungsVal,
                decoration: const InputDecoration(
                  labelText: 'Beschreibung',
                  border: InputBorder.none,
                ),
              ),
              TextField(
                controller: mengenVal,
                decoration: const InputDecoration(
                  labelText: 'Betrag',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButton<String>(
                value: selectedMonat,
                hint: const Text('Monat auswählen'),
                isExpanded: true,
                items: monate.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonat = newValue;
                  });
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: _submitData,
                child: const Text('Enter!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
