import 'package:flutter/material.dart';
import 'package:calculator/key_op.dart';

class CalculatorKey extends StatelessWidget {
  final String keyop;
  final Function(String) callback;

  const CalculatorKey(this.keyop, this.callback);
  
  @override
  Widget build(BuildContext context) {
    double buttonHeight = MediaQuery.of(context).size.height / 12;
    double roundedEdges = 30;
    Color buttonColor;

    if (keyop == KeyOp.equals) {
      buttonColor = Colors.lightGreen[800];
    }
    else {
      buttonColor = Colors.grey[110];
    }

    return Container(
      child: RaisedButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(roundedEdges)),
        child: 
        Text(keyop,
                style: Theme.of(context).textTheme.display1.copyWith(color: Colors.black)
                ),
        onPressed: ()
                {
                  callback(keyop);
                },
        ),
        // elevation: 4,
        height: buttonHeight,
    );
  }
}