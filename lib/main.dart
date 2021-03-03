import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const plataform = const MethodChannel("floating_button");
  int count = 0;
  bool exibindo = false;

  @override
  void initState() {
    super.initState();

    plataform.setMethodCallHandler((call) {
      if(call.method == "touch"){
        setState(() {
          count += 1;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Contagem: " + count.toString()),
            Text("Exibindo: " + exibindo.toString()),
            RaisedButton(
              child: Text("Create"),
              onPressed: () {
                plataform.invokeMethod("create");
              },
            ),
            RaisedButton(
              child: Text("show"),
              onPressed: () {
                plataform.invokeMethod("show");
              },
            ),
            RaisedButton(
              child: Text("hide"),
              onPressed: () {
                plataform.invokeMethod("hide");
              },
            ),

            RaisedButton(
              child: Text("isShowing"),
              onPressed: () {
                plataform.invokeMethod("isShowing").then((value){
                  setState(() {
                    exibindo = value;
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
