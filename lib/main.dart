import 'package:flutter/material.dart';
import 'package:lab_3/formvalid.dart';
import 'package:lab_3/ratecourse.dart';

import 'package:lab_3/formtask.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const appTitle = 'Drawer Demo';
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: My Registration',
      style: optionStyle,
    ),
    Text(
      'Index 2: My To Do Tasks',
      style: optionStyle,
    ),
    Text(
      'Index 3: My Rating',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        
        child: ListView(
       
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Home'),
              selected: _selectedIndex == 0,
              onTap: () {
               
                _onItemTapped(0);
              
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('My Registration'),
              selected: _selectedIndex == 1,
              onTap: () {
                
                _onItemTapped(1);
                
               
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FormValid()));
              },
            ),
            ListTile(
              title: const Text('My To Do Tasks'),
              selected: _selectedIndex == 2,
              onTap: () {
                
                _onItemTapped(2);
                
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FormTasks()));
              },
            ),
            ListTile(
              title: const Text('My Rating'),
              selected: _selectedIndex == 3,
              onTap: () {
                // Update the state of the app
                _onItemTapped(3);
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RateCourse()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
