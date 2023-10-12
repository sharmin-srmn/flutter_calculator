import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String statement = "";
  String result = "0";
  final List<String> buttons = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text ('Calculator'), backgroundColor: Colors.black, ),
        body: Column(
          children: [
            Flexible(flex: 2, child: resultWidget()),
            Expanded(flex: 5, child: _buttons()),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerRight,
            child: Text(
              statement,
              style: const TextStyle(fontSize: 32, color: Colors.white),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15),
          alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buttons() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return _myButton(buttons[index]);
      },
      itemCount: buttons.length,
    );
  }

  _myButton(String text) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonTap(text);
          });
        },
        color: _getColor(text),
        shape: const CircleBorder(),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  handleButtonTap(String text) {
    if (text == "AC") {
      statement = "";
      result = "0";
      return;
    }
    if (text == "=") {
      result = calculate();
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }

    if (text == "C") {
      statement = statement.substring(0, statement.length - 1);
      return;
    }
    statement = statement + text;
  }

  calculate() {
    try {
      var exp = Parser().parse(statement);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Err";
    }
  }

  _getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-") {
      return const Color.fromARGB(255, 233, 93, 0);
    }
    if (text == "C" || text == "AC") {
      return const Color.fromARGB(255, 201, 15, 15);
    }
    if (text == "(" || text == ")") {
      return  Colors.blueGrey;
    }
    return const Color.fromARGB(255, 33, 214, 64);
  }
}
