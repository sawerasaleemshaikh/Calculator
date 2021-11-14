import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String input = "0", solving = "", output = "0";

  appendInputExpression(String s) {
    setState(() {
      if (s == "C") {
        input = "0";
        output = "0";
        solving = "";
      } else if (s == "=") {
        solving = input;
        solving = solving.replaceAll('×', '*');
        solving = solving.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(solving);

          ContextModel cm = ContextModel();
          output = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          output = "Math Error";
        }
      } else {
        if (input == "0") {
          input = s;
        } else {
          input += s;
        }
      }
    });
  }

  Widget reusableButton(String s) {
    int flag = 0;
    if (s == '=') {
      return Expanded(
        child: MaterialButton(
          color: Colors.blue,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

          onPressed: () => appendInputExpression(s),
          padding: EdgeInsets.all(20.0),
          child: Text(
            s,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      );
    } else if (s == 'C') {
      return Expanded(
        child: MaterialButton(
          color: Colors.white,
          onPressed: () => appendInputExpression(s),
          padding: EdgeInsets.all(20.0),
          child: Text(
            s,
            style: TextStyle(fontSize: 25, color: Colors.red),
          ),
        ),
      );
    } else if (s == '÷' || s == '×' || s == '+' || s == '-' || s == '%') {
      return Expanded(
        child: MaterialButton(
          color: Colors.white,
          onPressed: () => appendInputExpression(s),
          padding: EdgeInsets.all(20.0),
          child: Text(
            s,
            style: TextStyle(fontSize: 25, color: Colors.blue),
          ),
        ),
      );
    } else if (s == "( )") {
      for (int i = 0; i < s.length; i++) {
        if (s[i] == "(") {
          flag = 1;
        }
      }

      if (flag == 0) {
        return Expanded(
          child: MaterialButton(
            color: Colors.white,
            onPressed: () => appendInputExpression("("),
            padding: EdgeInsets.all(20.0),
            child: Text(
              "( )",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
        );
      } else {
        return Expanded(
          child: MaterialButton(
            color: Colors.white,
            onPressed: () => appendInputExpression(")"),
            padding: EdgeInsets.all(20.0),
            child: Text(
              "( )",
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
        );
      }
    } else {
      return Expanded(
        child: MaterialButton(
          color: Colors.white,
          onPressed: () => appendInputExpression(s),
          padding: EdgeInsets.all(20.0),
          child: Text(
            s,
            style: TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.all(25),
                child: Text(
                  "Calculator",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              // padding: EdgeInsets.all(25),
              child: Text(
                input,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 60),
              // padding: EdgeInsets.all(25),
              child: Text(
                output,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Row(
              children: [
                reusableButton("C"),
                reusableButton("( )"),
                reusableButton("%"),
                reusableButton("÷"),
              ],
            ),
            Row(
              children: [
                reusableButton("1"),
                reusableButton("2"),
                reusableButton("3"),
                reusableButton("×"),
              ],
            ),
            Row(
              children: [
                reusableButton("4"),
                reusableButton("5"),
                reusableButton("6"),
                reusableButton("+"),
              ],
            ),
            Row(
              children: [
                reusableButton("7"),
                reusableButton("8"),
                reusableButton("9"),
                reusableButton("-"),
              ],
            ),
            Row(
              children: [
                reusableButton("."),
                reusableButton("0"),
                reusableButton("000"),
                reusableButton("="),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
