import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator_homepage_screen extends StatefulWidget {
  const calculator_homepage_screen({Key? key}) : super(key: key);

  @override
  State<calculator_homepage_screen> createState() => _calculator_homepage_screenState();
}

class _calculator_homepage_screenState extends State<calculator_homepage_screen> {

  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    'AC',
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
    'C',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[


          SizedBox(
            height: MediaQuery.of(context).size.height / 3,


            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: TextStyle(
                    fontSize: 32,
                    color: Colors.white
                  ),),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ),


              ],
            ),
          ),


          Divider(color: Colors.white,),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.3
                ),
                itemCount: buttonList.length,
                itemBuilder: (BuildContext context,int index){
                  return CustomButton(
                    buttonList[index]
                  );
                }
              ),
            ),
          ),


        ],
      ),
    );
  }


  Widget CustomButton(String text){
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(-3,-3),
            )
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }


  getColor(String text){
    if(
        text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")"
    ){
       return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text){
    if(text == "AC") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    if(text == "=") {
      return Color.fromARGB(255, 104, 204, 159);
    }
    return Color(0xFF1d2630);
  }


  handleButtons(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }

    if (text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0,userInput.length -1);
        return;
      }
      else{
        return null;
      }
    }

    if(text == "="){
      result = calculate();
      userInput = result;

      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
        return;
      }

      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }


  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }catch(e){
      return "Error";
    }
  }
}
