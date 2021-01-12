import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'reusable_card.dart';
import 'icon_content.dart';
import 'contstants.dart';
import 'results_page.dart';
import 'round_icon_button.dart';
import 'bottom_button.dart';
import 'calculator_brain.dart';

enum GenderType {
  male,
  female,
}

enum Goal{
  fat_loss,
  maintenance,
  gainz,
}


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String goal;
  String selectedActivity;
  GenderType selectedGender;
  int height = 180;
  int weight = 60;
  int age = 20;

  CupertinoTheme iOSPicker(List<String> aList, String pickerType){
    List<Text> pickerItems = [];
    for(String activity in aList){
      pickerItems.add(Text(activity));
    }
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          pickerTextStyle: TextStyle(color: Colors.white, fontSize:  15,),
        ),
      ),
      child: CupertinoPicker(
        diameterRatio: 1,
        backgroundColor: Color(0xFF0A0D22),
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex){
          setState(() {
            if (pickerType == 'goal'){
              goal = aList[selectedIndex];
              print(goal);
            } else{
              selectedActivity = activityList[selectedIndex];
              print(selectedActivity);
            }
          });
        },
        children: pickerItems,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0D22),
      appBar: AppBar(
        title: Center(child: Text('MACRONUTRIENTS CALCULATOR')),
      ),
      body: Column(children: <Widget>[
        Expanded(
          flex:2,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender = GenderType.male;
                      });
                    },
                    colour: selectedGender == GenderType.male ? kActiveCardColour : kInactiveCardColour,
                    cardChild: IconContent(icon: FontAwesomeIcons.mars, label: 'MALE',),
                  ),
              ),
              Expanded(
                  child: ReusableCard(
                    onPress: (){
                      setState(() {
                        selectedGender = GenderType.female;
                      });
                    },
                    colour: selectedGender == GenderType.female ? kActiveCardColour : kInactiveCardColour,
                    cardChild: IconContent(icon: FontAwesomeIcons.venus, label: 'FEMALE',),
                  ),
              ),
            ],
          ),
        ),
        Expanded(child: iOSPicker(activityList, 'activity')),
        Expanded(
          flex: 2,
          child: ReusableCard(
            colour: kActiveCardColour,
            cardChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                  Text(
                    height.toString(),
                    style: kNumberTextStyle,
                  ),
                  Text(
                    'cm',
                    style: kLabelTextStyle,
                  ),
                ],),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    inactiveTrackColor: Color(0xFF8D8E89),
                    activeTrackColor: Colors.white,
                    thumbColor: Color(0xFFEB1555),
                    overlayColor: Color(0x29EB1555),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
    ),
                  child: Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 220.0,
                    onChanged: (double newValue){
                      setState(() {
                        height = newValue.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
        ),
        ),
        Expanded(
          flex: 2,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ReusableCard(
                  colour: kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WEIGHT',
                        style: kLabelTextStyle,
                      ),
                      Text(
                        weight.toString(),
                        style: kNumberTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed:(){
                              setState(() {
                                weight++;
                              });
                            }
                            ),
                          SizedBox(width: 10),
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: (){
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ),
            Expanded(
              child: ReusableCard(
                colour: kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'AGE',
                      style: kLabelTextStyle,
                    ),
                    Text(
                      age.toString(),
                      style: kNumberTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed:(){
                              setState(() {
                                age++;
                              });
                            }
                        ),
                        SizedBox(width: 10),
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState(() {
                              age--;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
        Expanded(child: iOSPicker(goalList, 'goal')),
        BottomButton(
          buttonTitle: 'CALCULATE' ,
          onTap: (){
            CalculatorBrain calc = CalculatorBrain(height: height, weight: weight, activity: selectedActivity, age: age, gender: selectedGender, goal: goal);

            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(
              bmiResult: calc.calculateBMI(),
              resultText: calc.getResult(),
              interpretation: calc.getInterpretation(),
              goalText: calc.getText(),
              proteinResult: calc.calculateProtein(),
              carbResult: calc.calculateCarbs(),
              fatResult: calc.calculateFat(),
            )));
          },
        ),
      ],
      ),
    );
  }
}







