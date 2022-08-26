import 'package:eazigrid/eazigrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/assertions.dart';


class MyTestApp extends StatelessWidget {
  MyTestApp({Key? key,  this.totalItems = 30, this.widgetHeight=720, this.widgetWidth=512})
      : super(key: key){
    WidgetsFlutterBinding.ensureInitialized();
  }

  final int totalItems;
  final double widgetHeight;
  final double widgetWidth;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EaziGrid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  TestScreen(totalItems: this.totalItems,
        widgetWidth: this.widgetWidth, widgetHeight: this.widgetHeight, ),
    );
  }

  Function _onError_ignoreOverflowErrors = (
      FlutterErrorDetails details, {
        bool forceReport = false,
      }) {
    assert(details != null);
    assert(details.exception != null);
    // ---

    bool ifIsOverflowError = false;

    var exception = details.exception;
    if (exception is FlutterError) {
      ifIsOverflowError = !exception.diagnostics.any(
          (e) {
            final errorVal =e.value.toString();
            return errorVal.startsWith("A RenderFlex overflowed by")
                && errorVal.contains("eazi_row_widget.dart");
          });
    }
    // Ignore if is overflow error.
    if (ifIsOverflowError) {
      print('Overflow error.');
    }
    else {
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  };
}

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key, required this.totalItems, required this.widgetHeight, required this.widgetWidth}) : super(key: key);

  final int totalItems;
  final double widgetHeight;
  final double widgetWidth;

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Widget'),
      ),
      body: Container(
        height: widget.widgetHeight,
        width: widget.widgetWidth,
        child: SingleChildScrollView(
          child: Column(
              children: [
                EaziGrid(
                    horizontalAlignment: EaziAlignment.start,
                    children: [
                      for(int i=0; i<=widget.totalItems; i++)
                        Container(
                          color: Colors.blue,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.description, color: Colors.white,),
                              const SizedBox(height: 5,),
                              Text('test item: $i', style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        )
                    ]),
                Text('EaziGrid', style: TextStyle(fontSize: 30),)
              ]
          ),
        ),
      ),
    );
  }
}