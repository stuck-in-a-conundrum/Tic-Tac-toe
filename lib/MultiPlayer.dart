import 'package:flutter/material.dart';

class MultiPlayer extends StatefulWidget {
  @override
  _MultiPlayerState createState() => _MultiPlayerState();
}

class _MultiPlayerState extends State<MultiPlayer> {
  AssetImage x = AssetImage("assets/cross.jpg");
  AssetImage o = AssetImage("assets/circle.jpg");
  AssetImage empty = AssetImage("assets/empty.png");

  List<String> fill = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      this.fill = [
        "emp",
        "emp",
        "emp",
        "emp",
        "emp",
        "emp",
        "emp",
        "emp",
        "emp"
      ];
    });

    @override
    Widget build(BuildContext context) {
      return Container();
    }
  }

  int evaluate(List<String> b) {
    // Checking for Rows for X or O victory.
    for (int row = 0; row <= 6; row += 3) {
      if (b[row] == b[row + 1] && b[row] == b[row + 2]) {
        if (b[row] == 'x')
          return 1;
        else if (b[row] == 'o') return 0;
      }
    }

    // Checking for Columns for X or O victory.
    for (int col = 0; col < 3; col++) {
      if (b[col] == b[col + 3] && b[col] == b[col + 6]) {
        if (b[col] == 'x')
          return 1;
        else if (b[col] == 'o') return 0;
      }
    }

    // Checking for Diagonals for X or O victory.
    if (b[0] == b[4] && b[0] == b[8]) {
      if (b[0] == 'x')
        return 1;
      else if (b[0] == "o") return 0;
    }

    if (b[2] == b[4] && b[2] == b[6]) {
      if (b[2] == 'x')
        return 1;
      else if (b[2] == 'o') return 0;
    }

    // Else if none of them have won then return 0
    return 2;
  }

  int player = 1, countEmp = 9;
  String message = "";
  show(int i) {
    if (this.fill[i] == "emp" && countEmp != -1) {
      setState(() {
        if (player == 1) {
          this.fill[i] = 'x';
          player = 0;
        } else {
          this.fill[i] = 'o';
          player = 1;
        }
        countEmp -= 1;
        print(countEmp);
        if (countEmp == 0) {
          this.message = "It's a Tie!";
          countEmp = -1;
        } else {
          int n = evaluate(this.fill);
          if (n != 2) {
            this.message = n == 0 ? 'O Wins' : 'X Wins';
            countEmp = -1;
          }
        }
      });
    }
  }

  @override
  AssetImage photo(String value) {
    switch (value) {
      case ('x'):
        return x;
        break;
      case ('o'):
        return o;
        break;
      default:
        return empty;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "2 player",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF192A56),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0),
              itemCount: this.fill.length,
              itemBuilder: (context, i) => SizedBox(
                width: 75.0,
                height: 75.0,
                child: MaterialButton(
                  onPressed: () {
                    this.show(i);
                  },
                  child: Image(
                    image: this.photo(this.fill[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: 50.0, color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }
}
