import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _scoreX = 0;
  int _scoreO = 0;
  bool _turnOfO = true;
  int _filledBoxes = 0;

  List<String> _xOrOList = List.generate(9, (index) => '');

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _clearBoard();
              },
            )
          ],
          title: Text(
            'Tic Tac Toe',
            style: kCustomText(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
          ),
        ),
        backgroundColor: Colors.grey[900],
        body: Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  // Points Table
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Player O',
                                style: kCustomText(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _scoreO.toString(),
                                style: kCustomText(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                'Player X',
                                style: kCustomText(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _scoreX.toString(),
                                style: kCustomText(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // Grid
                  Expanded(
                    flex: 3,
                    child: GridView.builder(
                      itemCount: 9,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) => GestureDetector(
                        onTap: () => setState(() {
                          if (_turnOfO && _xOrOList[index] == '') {
                            _xOrOList[index] = 'o';
                            _filledBoxes += 1;
                          } else if (!_turnOfO && _xOrOList[index] == '') {
                            _xOrOList[index] = 'x';
                            _filledBoxes += 1;
                          }

                          _turnOfO = !_turnOfO;
                          _checkTheWinner();
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.withOpacity(0.7)),
                          ),
                          child: Center(
                            child: Text(
                              _xOrOList[index],
                              style: TextStyle(
                                color: _xOrOList[index] == 'x' ? Colors.white : Colors.red,
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Turn
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        _turnOfO ? 'Turn of O' : 'Turn of X',
                        style: kCustomText(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  void _checkTheWinner() {
    // check first row
    if (_xOrOList[0] == _xOrOList[1] && _xOrOList[0] == _xOrOList[2] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second row
    if (_xOrOList[3] == _xOrOList[4] && _xOrOList[3] == _xOrOList[5] && _xOrOList[3] != '') {
      _showAlertDialog('Winner', _xOrOList[3]);
      return;
    }

    // check third row
    if (_xOrOList[6] == _xOrOList[7] && _xOrOList[6] == _xOrOList[8] && _xOrOList[6] != '') {
      _showAlertDialog('Winner', _xOrOList[6]);
      return;
    }

    // check first column
    if (_xOrOList[0] == _xOrOList[3] && _xOrOList[0] == _xOrOList[6] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check second column
    if (_xOrOList[1] == _xOrOList[4] && _xOrOList[1] == _xOrOList[7] && _xOrOList[1] != '') {
      _showAlertDialog('Winner', _xOrOList[1]);
      return;
    }

    // check third column
    if (_xOrOList[2] == _xOrOList[5] && _xOrOList[2] == _xOrOList[8] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    // check diagonal
    if (_xOrOList[0] == _xOrOList[4] && _xOrOList[0] == _xOrOList[8] && _xOrOList[0] != '') {
      _showAlertDialog('Winner', _xOrOList[0]);
      return;
    }

    // check diagonal
    if (_xOrOList[2] == _xOrOList[4] && _xOrOList[2] == _xOrOList[6] && _xOrOList[2] != '') {
      _showAlertDialog('Winner', _xOrOList[2]);
      return;
    }

    if (_filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
      context: context,
      title: title,
      content: winner == '' ? 'The match ended in a draw' : 'The winner is ${winner.toUpperCase()}',
      defaultActionText: 'OK',
      onOkPressed: () {
        _clearBoard();
        Navigator.of(context).pop();
      },
    );

    if (winner == 'o') {
      _scoreO += 1;
    } else if (winner == 'x') {
      _scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() => _xOrOList = List.generate(9, (index) => ''));

    _filledBoxes = 0;
  }
}

Future<void> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String defaultActionText,
  required void Function() onOkPressed,
}) async {
  if (Platform.isIOS || Platform.isMacOS) {
    return await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => onOkPressed(),
            child: Text(defaultActionText),
          ),
        ],
      ),
    );
  }

  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => onOkPressed(),
          child: Text(defaultActionText),
        ),
      ],
    ),
  );
}

TextStyle kCustomText({double fontSize = 16.0, Color? color, FontWeight fontWeight = FontWeight.normal}) =>
    TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight);
