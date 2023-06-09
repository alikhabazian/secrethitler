import 'package:flutter/material.dart';
import 'package:secret_hitler/rollassigning.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Secret Hitler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _numPlayers = 5;
  List<TextEditingController> playerNameController = [];
  List<Widget> playerWidgets = [];

  void _incrementPlayers() {
    setState(() {
      if (_numPlayers < 10) {
        _numPlayers++;
      }

    });
  }

  void _decrementPlayers() {
    setState(() {
      if (_numPlayers > 5) {
        _numPlayers--;
      }
    });
  }


  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _setPlayers() {
    List<String> playersName = [];
    setState(() {
      for (int i = 0; i < _numPlayers; i++) {
        if (playerNameController[i].text.length != 0) {
          playersName.add(
              playerNameController[i].text
          );
        } else {
          showMessageDialog(context, 'You must fill player ${i+1} name');
          return;
          // break;
        }

      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RollAssigning(data: playersName)),
      );

    });
  }

  void _setUp() {}


  @override
  Widget build(BuildContext context) {
    playerNameController = [];
    playerWidgets = [];
    for (int i = 0; i < _numPlayers; i++) {
      playerNameController.add(new TextEditingController());
    }
    for (int i = 0; i < _numPlayers; i++) {
      playerNameController.add(new TextEditingController());
    }



    for (int i = 0; i < _numPlayers; i++) {
      playerWidgets.add(
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Text('Player ${i + 1} name :'),
                SizedBox(
                  width: 200.0,
                  height: 50.0,

                    child:TextField(

                  controller: playerNameController[i],
                      decoration: InputDecoration(
                        hintText: 'Enter some text',
                        border: OutlineInputBorder(),
                      ),
                ),
                ),
              ]
          )
      );
      playerWidgets.add(SizedBox(height: 16.0));
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
      child:Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 16.0),
            const Text(
              'Number of Players:',
            ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.blue,
                    child: IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: _decrementPlayers,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(16.0),

                    child:Text('$_numPlayers', style: TextStyle(fontSize: 50),)
                ),
                ClipOval(
                  child: Material(
                    color: Colors.blue,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: _incrementPlayers,
                      color: Colors.white,
                    ),
                  ),
                )


              ],
            ),
          ]+playerWidgets,
        ),
      ),),
      floatingActionButton: FloatingActionButton(
        onPressed: _setPlayers,
        tooltip: 'Increment',
        child: const Icon(Icons.arrow_forward_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
