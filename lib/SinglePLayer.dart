import 'package:flutter/material.dart';
//import './CheckMessage.dart';

class SinglePlayer extends StatefulWidget {
  String player = '', computer = '';
  SinglePlayer(this.player, this.computer);
  @override
  _SinglePlayerState createState() => _SinglePlayerState(player, computer);
}

class _SinglePlayerState extends State<SinglePlayer> {
  String player = '', computer = '';
  _SinglePlayerState(this.player, this.computer);
  AssetImage x = const AssetImage("assets/cross.jpg");
  AssetImage o = const AssetImage("assets/circle.jpg");
  AssetImage empty = const AssetImage("assets/empty.png");

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

  int countEmp = 9;

// This function returns true if there are moves
// remaining on the board. It returns false if
// there are no moves left to play.
  bool isMovesLeft(List<String> board) {
    for (int i = 0; i < 9; i++) if (board[i] == 'emp') return true;
    return false;
  }

  // This is the evaluation function as discussed
  int evaluate(List<String> b) {
    // Checking for Rows for X or O victory.
    for (int row = 0; row <= 6; row += 3) {
      if (b[row] == b[row + 1] && b[row] == b[row + 2]) {
        if (b[row] == computer)
          return 10;
        else if (b[row] == player) return -10;
      }
    }

    // Checking for Columns for X or O victory.
    for (int col = 0; col < 3; col++) {
      if (b[col] == b[col + 3] && b[col] == b[col + 6]) {
        if (b[col] == computer)
          return 10;
        else if (b[col] == player) return -10;
      }
    }

    // Checking for Diagonals for X or O victory.
    if (b[0] == b[4] && b[0] == b[8]) {
      if (b[0] == computer)
        return 10;
      else if (b[0] == player) return -10;
    }

    if (b[2] == b[4] && b[2] == b[6]) {
      if (b[2] == computer)
        return 10;
      else if (b[2] == player) return -10;
    }

    // Else if none of them have won then return 0
    return 0;
  }

  // This is the minimax function. It considers all
  // the possible ways the game can go and returns
  // the value of the board
  int minimax(List<String> board, int depth, bool isMax) {
    max(int a, int b) {
      if (a < b)
        return b;
      else
        return a;
    }

    min(int a, int b) {
      if (a < b)
        return a;
      else
        return b;
    }

    int score = evaluate(board);

    if (score == 10) return score;

    // If Minimizer has won the game return his/her
    // evaluated score
    if (score == -10) return score;

    // If there are no more moves and no winner then
    // it is a tie
    if (isMovesLeft(board) == false) return 0;

    // If this maximizer's move
    if (isMax) {
      int best = -1000;

      // Traverse all cells
      for (int i = 0; i < 9; i++) {
        // Check if cell is empty
        if (board[i] == 'emp') {
          // Make the move//add in show;
          board[i] = computer;

          // Call minimax recursively and choose
          // the maximum value
          best = max(best, minimax(board, depth + 1, !isMax));

          // Undo the move
          board[i] = 'emp';
        }
      }
      return best;
    }

    // If this minimizer's move
    else {
      int best = 1000;

      // Traverse all cells
      for (int i = 0; i < 9; i++) {
        // Check if cell is empty
        if (board[i] == 'emp') {
          // Make the move
          board[i] = player;

          // Call minimax recursively and choose
          // the minimum value
          best = min(best, minimax(board, depth + 1, !isMax));

          // Undo the move
          board[i] = 'emp';
        }
      }
      return best;
    }
  }

  // This will return the best possible move for the player
  findBestMove(List<String> board) {
    int bestVal = -1000;
    int bestMove = -1;

    // Traverse all cells, evaluate minimax function for
    // all empty cells. And return the cell with optimal
    // value.
    for (int i = 0; i < 9; i++) {
      // Check if cell is empty
      if (board[i] == 'emp') {
        // Make the move
        board[i] = computer;

        // compute evaluation function for this
        // move.
        int moveVal = minimax(board, 0, false);

        // Undo the move
        board[i] = 'emp';

        // If the value of the current move is
        // more than the best value, then update
        // best/
        if (moveVal > bestVal) {
          bestMove = i;
          bestVal = moveVal;
        }
      }
    }
    return bestMove;
  }

  String message = '';

  int turn = 0;
  show(int i) {
    if (this.fill[i] == "emp" && countEmp != -1) {
      setState(() {
        this.fill[i] = player;
        countEmp -= 1;
        int n = evaluate(this.fill);
        if (n < 0) {
          this.message = 'You Win';
          countEmp = -1;
        }

        if (countEmp >= 1) {
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              this.fill[findBestMove(this.fill)] = computer;
            });

            countEmp -= 1;
            n = evaluate(this.fill);
            if (n > 0) {
              this.message = 'You Lose';
              countEmp = -1;
            }
          });
        } else {
          if (n == 0) {
            this.message = "It's A Tie";
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
          "Single Player",
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
