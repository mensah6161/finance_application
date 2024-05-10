import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'goal.dart';
import 'transactions.dart';

//CamelCase für Funktionen und variablen - descrVar
//PascalCase für Klassen/Widgets PageWidget 
//Konstanten alles GRO?BUCHSTABEN


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'FinanceApp';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

    final List<Widget>_pageOptions = <Widget>[
      const Dashboard(),
      const Transactions(),
      const Goals(),
    ];


    //change state through change of index by click
    void _clickPage(int indexVar){
      setState(() {
        _pageIndex= indexVar;
      });
    }


//https://api.flutter.dev/flutter/material/BottomNavigationBar-class.html
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Center(
      //  child: _widgetOptions.elementAt(_selectedIndex),
      body: IndexedStack(
        index: _pageIndex,
        children: _pageOptions,
      
      ),
bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Start',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Transaktionen',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.star), 
      label: 'Ziele',
    ),
  ],
  currentIndex: _pageIndex,
  selectedItemColor: const Color.fromARGB(255, 0, 255, 17),
  onTap: _clickPage,
),

    );
  }
}
