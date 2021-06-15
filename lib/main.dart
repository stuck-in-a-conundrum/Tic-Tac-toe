import 'package:flutter/material.dart';
import './MultiPlayer.dart';
import './SinglePLayer.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  AssetImage x = const AssetImage("assets/cross.jpg");
  AssetImage o = const AssetImage("assets/circle.jpg");
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
      ),
      body: Container(
        padding: const EdgeInsets.all(70),
        child: Column(children: [
          Container(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultiPlayer()),
                );
              },
              child: const Text(
                "Two Player",
                style: TextStyle(
                  fontSize: 50,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Choose'),
                  content: const Text('Choose your preference: '),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SinglePlayer('x', 'o')),
                      ),
                      child: Image.asset("assets/cross.jpg",
                          height: 50, width: 50),
                    ),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SinglePlayer('o', 'x'),
                        ),
                      ),
                      child: Image.asset("assets/circle.jpg",
                          height: 50, width: 50),
                    ),
                  ],
                ),
              ),
              child: const Text(
                "Single Player",
                style: TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
            ),
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          ),
        ]),
      ),
    );
  }
}
