import 'package:calculator/constans/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(List<String> args) {
  runApp(myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  Widget getrow(String text1, String text2, String text3, String text4) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            backgroundColor: getbackground(text1),
          ),
          onPressed: () {
            if (text1 == "ac") {
              setState(() {
                result = "";
                inputuser = "";
              });
            } else {
              button_press(text1);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 32,
                color: getforground(text1),
              ),
            ),
          ),
        ),

        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            backgroundColor: getbackground(text2),
          ),
          onPressed: () {
            if (text2 == "ce") {
              if (inputuser.length > 0) {
                setState(() {
                  inputuser = inputuser.substring(0, inputuser.length - 1);
                });
              }
            } else {
              button_press(text2);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 32,
                color: getforground(text2),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            backgroundColor: getbackground(text3),
          ),
          onPressed: () {
            button_press(text3);
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              text3,
              style: TextStyle(
                fontSize: 32,
                color: getforground(text3),
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            backgroundColor: getbackground(text4),
          ),
          onPressed: () {
            if (text4 == "=") {
              Parser parser = Parser();
              Expression expression = parser.parse(inputuser);
              ContextModel contextModel = ContextModel();
              double eval =
                  expression.evaluate(EvaluationType.REAL, contextModel);
              setState(() {
                result = eval.toString();
              });
            } else {
              button_press(text4);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              text4,
              style: TextStyle(
                fontSize: 32,
                color: getforground(text4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 200,
                  color: backgroundGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          inputuser,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: textGreen, fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          result.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white, fontSize: 42),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getrow("ac", "ce", "%", "/"),
                      getrow("7", "8", "9", "*"),
                      getrow("4", "5", "6", "-"),
                      getrow("1", "2", "3", "+"),
                      getrow("0", "00", ".", "="),
                    ],
                  ),
                  height: 200,
                  color: backgroundGreyDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getbackground(String text) {
    var list = ["ac", "ce", "%", "/", "*", "-", "+", "="];
    for (var item in list) {
      if (item == text) {
        return backgroundGrey;
      }
    }

    return backgroundGreyDark;
  }

  Color getforground(String text) {
    var list = ["ac", "ce", "%", "/", "*", "-", "+", "="];
    for (var item in list) {
      if (item == text) {
        return textGreen;
      }
    }

    return textGrey;
  }

  String inputuser = "";
  var result = "";
  void button_press(String text) {
    setState(() {
      inputuser = inputuser + text;
    });
  }
}
