import 'package:flutter/material.dart';
import 'package:calculator/key_op.dart';
import 'package:calculator/calculator_key.dart';
import 'dart:math';

class Calculator extends StatefulWidget {
  Calculator({Key key}): super(key: key);

  @override
 _Calculator createState() {
    return _Calculator();
  }
}

class _Calculator extends State<Calculator> {
  String value;
  String op;

  _Calculator() {
    value = '';
    op = '';
  }

  void _refresh() {
    setState( () {
    });
  }

  void append(text) {
    value += text;
    _refresh();
  }

  // CE operation
  void clear(String x) {
    op = value = '';
    _refresh();
  }

  void setOperator(text) {
    if (value == '') {
      if (text == '-') {
        value = text;
      }
    }
    else { // replace last operator
      String lastKey = value.substring(value.length-1, value.length);
      if (KeyOp.operators.contains(lastKey)) {
        value = value.substring(0, value.length-1) + text;
      }
      else { // evaluate the operation
        evalExpression();
        if (text != '=') { // do not print '='
          value += text;
        }
      }
    }
    if (text != '=') {
      op = text;
    }

    _refresh();
  }

  void evalExpression(){
    if (op == '') {
      return;
    }
    String expression = value;
    var elements = expression.split(op);

    double num1 = double.parse(elements[0]);
    double num2 = double.parse(elements[1]);
    double result = 0.0;

    if (op == '+') {
      result = num1 + num2;
    }
    else if (op == '-') {
      result = num1 - num2;
    }
    else if (op == '*') {
      result = num1 * num2;
    } 
    else if (op == '/') {
      result = num1 / num2;
    } 
    else if (op == '%') {
      result = num1 % num2;
    } 
    else if (op == '/') {
      result = num1 / num2;
    }
    else if (op == '^') {
      result = pow(num1, num2);
    }
    
    // show integer if the result is integer
    // else should double 
    int x = result.toInt();
    if (x.toDouble() == result) {
      value = x.toString();
    }
    else 
    {
      value = result.toStringAsPrecision(6);
    }

    op = '';
  }

  // operations
  void backspace(String x) {
    String tmp = value;
    int len = tmp.length;

    if (len <= 1) {
      clear("");
    }
    else {
      value = tmp.substring(0, len-1);
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 10;
    double sizedBoxWidth = 0;

    return Scaffold(
      body: 
        Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 50,),
          Expanded(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(child: 
                        Text(
                          value,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.display3.copyWith(color: Colors.black),
                          softWrap: true,
                        ),),
                ],
              ),
            ),
            SizedBox(height: sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: 
                <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  CalculatorKey(KeyOp.clear, clear),
                  CalculatorKey(KeyOp.power, setOperator),
                  CalculatorKey(KeyOp.divide, setOperator),
                  CalculatorKey(KeyOp.backspace, backspace),
                  SizedBox(width: sizedBoxWidth,),
              ],
            ),
            SizedBox(height: sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: sizedBoxWidth,),
                CalculatorKey(KeyOp.seven, append),
                CalculatorKey(KeyOp.eight, append),
                CalculatorKey(KeyOp.nine, append),
                CalculatorKey(KeyOp.multiply, setOperator),
                SizedBox(width: sizedBoxWidth,),
              ],
            ),
            SizedBox(height: sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: sizedBoxWidth,),
                CalculatorKey(KeyOp.four, append),
                CalculatorKey(KeyOp.five, append),
                CalculatorKey(KeyOp.six, append),
                CalculatorKey(KeyOp.subtract, setOperator),
                SizedBox(width: sizedBoxWidth,),
              ],
            ),
            SizedBox(height: sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: sizedBoxWidth,),
                CalculatorKey(KeyOp.one, append),
                CalculatorKey(KeyOp.two, append),
                CalculatorKey(KeyOp.three, append),
                CalculatorKey(KeyOp.add, setOperator),
                SizedBox(width: sizedBoxWidth,),
              ],
            ),
            SizedBox(height: sizedBoxHeight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: 
                <Widget>[
                  SizedBox(width: sizedBoxWidth,),
                  CalculatorKey(KeyOp.modulus, setOperator),
                  CalculatorKey(KeyOp.zero, append),
                  CalculatorKey(KeyOp.period, append),
                  CalculatorKey(KeyOp.equals, setOperator),
                  SizedBox(width: sizedBoxWidth,),
                ],
              ),
              SizedBox(height: sizedBoxHeight),
        ],
      )
    );
    }
}