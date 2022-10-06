import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String equation='0';
  String result='0';
  String expression='';
  double equationFontsize=40.0;
  double resultFontsize=50.0;


  buttonPressed(String buttonText){
    setState(() {
      if(buttonText=='C'){
        equation='0';
        result='0';
        equationFontsize=40.0;
        resultFontsize=50.0;
      }
      else if(buttonText == 'X'){
        equation = equation.substring(0, equation.length -1);
      }




      else if(buttonText=='='){
        expression=equation;
        expression = expression.replaceAll('*', '*');
        expression = expression.replaceAll('/', '/');

        try{
        Parser p=Parser();
        Expression exp=p.parse(expression);
        ContextModel cm=ContextModel();
        result='${exp.evaluate(EvaluationType.REAL, cm)}';

        }
        catch(e){
          result='Error';
        }
      }
      else {
        equationFontsize=50.0;
        resultFontsize=40.0;
        if (equation == '0') {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });
  }
 Widget createButton(String btnText, double btnHeight, Color btnColor){
    return Container(
      height: MediaQuery.of(context).size.height*0.1*btnHeight,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
          side: BorderSide(
          color: Colors.grey,
          width: 1.0,
          ),
        ),
        fillColor: btnColor,
        child: Text(btnText,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onPressed: ()=> buttonPressed(btnText),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [
                Colors.purple,
                Colors.red,
              ]
            )
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(right: 10, top: 20),
            alignment: Alignment.centerRight,
            child: Text(equation,
            style: TextStyle(
              fontSize: equationFontsize,
            ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 6,top: 20),
            child: Text(result,
            style: TextStyle(
              fontSize: resultFontsize,
            ),
            ),
          ),
          Expanded(
            child: Divider(
              
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        createButton("C", 1, Colors.redAccent),
                        createButton("X", 1, Colors.purple),
                        createButton("/", 1, Colors.purple),
                      ]
                    ),
                    TableRow(
                        children: [
                          createButton("7", 1, Colors.blueGrey),
                          createButton("8", 1, Colors.blueGrey),
                          createButton("9", 1, Colors.blueGrey),
                        ]
                    ),
                    TableRow(
                        children: [
                          createButton("4", 1, Colors.blueGrey),
                          createButton("5", 1, Colors.blueGrey),
                          createButton("6", 1, Colors.blueGrey),
                        ]
                    ),
                    TableRow(
                        children: [
                          createButton("1", 1, Colors.blueGrey),
                          createButton("2", 1, Colors.blueGrey),
                          createButton("3", 1, Colors.blueGrey),
                        ]
                    ),
                    TableRow(
                        children: [
                          createButton(".", 1, Colors.purple),
                          createButton("0", 1, Colors.blueGrey),
                          createButton("/", 1, Colors.blueGrey),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        createButton('*', 1, Colors.redAccent),
                      ]
                    ),
                    TableRow(
                        children: [
                          createButton('-', 1, Colors.redAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          createButton('+', 1, Colors.redAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          createButton('=', 2, Colors.redAccent),
                        ]
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
