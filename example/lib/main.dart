
import 'package:eazigrid/eazigrid.dart';
import 'package:flutter/material.dart';

void main() {
  EaziGridFlowHandler.handleEaziError();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EaziGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Eazigrid Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, this.totalItems = 30}) : super(key: key);

  final String title;
  final double totalItems;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: EaziGrid(
              isScrollable: true,
              horizontalAlignment: EaziAlignment.start,
              children: [
              for(int i=0; i<=widget.totalItems; i++)
                TestGridItem(itemIndex: i)
            ]),
          ),
          Text('EaziGrid', style: TextStyle(fontSize: 30),)
        ]
      ),
    );
  }
}

class TestGridItem extends StatelessWidget {
  const TestGridItem({
    Key? key,
    required this.itemIndex,
  }) : super(key: key);

  final int itemIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.description, color: Colors.white,),
          const SizedBox(height: 5,),
          Text('$itemIndex\ntest item', textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)
        ],
      ),
    );
  }
}
