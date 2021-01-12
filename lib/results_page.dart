import 'input_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'contstants.dart';
import 'package:bmi_calculator/reusable_card.dart';
import 'bottom_button.dart';

class ResultsPage extends StatelessWidget {

  ResultsPage({@required this.interpretation, @required this.bmiResult, @required this.resultText, @required this.proteinResult, @required this.carbResult, this.fatResult, this.goalText});
  final String bmiResult;
  final String resultText;
  final String interpretation;
  final String proteinResult;
  final String carbResult;
  final String fatResult;
  final String goalText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(goalText, style: kBodyWeightTextStyle, textAlign: TextAlign.center,),
                    Text('Protein: $proteinResult', style: kBodyWeightTextStyle,),
                    Text('Carbs: $carbResult', style: kBodyWeightTextStyle,),
                    Text('Fat: $fatResult', style: kBodyWeightTextStyle,),
                    Text(
                      resultText.toUpperCase(),
                      style: kResultTextStyle,
                    ),
                    Text(
                      bmiResult,
                      style: kBMITextStyle,
                    ),
                    Text(
                      interpretation,
                      style: kBodyWeightTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              buttonTitle: 'RE-CALCULATE' ,
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

