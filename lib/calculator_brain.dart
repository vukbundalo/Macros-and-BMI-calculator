import 'dart:math';
import 'input_page.dart';
class CalculatorBrain {

  CalculatorBrain({this.height, this.weight, this.gender, this.activity, this.age, this.goal});

  final int height;
  final int weight;
  final GenderType gender;
  final String activity;
  final int age;
  final String goal;
  double _bmi;



  String calculateBMI (){
    _bmi = weight / pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }

  double calculateCalories(){
    double calories;
    if (gender == GenderType.male) {
       calories = ((weight * 10) + (height * 6.25) - (age * 5) + 5);
    }
    else {
      calories = ((weight * 10) + (height * 6.25) - (age * 5) - 161);
    }
    return calories;
  }

  int calculateActivity(){
    double caloriesResult = calculateCalories();
    int cal;
    switch (activity) {
      case 'LOW':
        cal = (caloriesResult * 1.1).round();
        break;
      case 'LIGHT':
        cal = (caloriesResult * 1.3).round();
        break;
      case 'HIGH':
        cal = (caloriesResult * 1.5).round();
        break;
      case 'EXTREME':
        cal = (caloriesResult * 1.7).round();
        break;
    }
    return cal;
  }

  String calculateProtein(){
    int calories = calculateActivity();
    String proteins;
    switch (goal) {
      case "FAT LOSS":
        if (calories <= 2000) calories =  (0.9 * calories).round();
        if (calories > 2000) calories =  (0.8 * calories).round();
        proteins = (0.40 * calories / 4).round().toString();
        break;
      case "MAINTENANCE":
        proteins = (0.30 * calories / 4).round().toString();
        break;
      case "MUSCLE GAINS":
        calories += 500;
        proteins = (0.30 * calories / 4).round().toString();
        break;
    }
    return proteins;
  }

  String calculateCarbs(){
    int calories = calculateActivity();
    String carbs;
    switch (goal) {
      case "FAT LOSS":
        if (calories <= 2000) calories =  (0.9 * calories).round();
        if (calories > 2000) calories =  (0.8 * calories).round();
        carbs = (0.40 * calories / 4).round().toString();
        break;
      case "MAINTENANCE":
        carbs = (0.45 * calories / 4).round().toString();
        break;
      case "MUSCLE GAINS":
        calories += 500;
        carbs = (0.45 * calories / 4).round().toString();
        break;
    }
    return carbs;
  }

  String calculateFat(){
    int calories = calculateActivity();
    String fat;
    switch (goal) {
      case "FAT LOSS":
        if (calories <= 2000) calories =  (0.9 * calories).round();
        if (calories > 2000) calories =  (0.8 * calories).round();
        fat = (0.20 * calories / 9).round().toString();
        break;
      case "MAINTENANCE":
        fat = (0.25 * calories / 9).round().toString();
        break;
      case "MUSCLE GAINS":
        calories += 500;
        fat = (0.25 * calories / 9).round().toString();
        break;
    }
    return fat;
  }


  String getResult(){
    if ( _bmi > 25) {
      return 'Overweight';
    }else if(_bmi > 18.5){
      return 'Normal';
    }else{
      return 'Underweight';
    }
  }

  String getInterpretation(){
    if (_bmi >= 25){
      return 'You have a higher than normal body weight. Try to exercise more';
    }else if(_bmi > 18.5){
      return 'You have a normal body weight. Good joob';
    }else{
      return 'You have a lower than normal body weight. You can eat a bit more';
    }
  }

  String getText(){
    if (goal == 'FAT LOSS'){
      return 'If you want to lose weight you should intake:';
    }else if(goal == 'MAINTENANCE'){
      return 'In order to maintain your weight you should intake:';
    }else if (goal == 'MUSCLE GAINS'){
      return 'To gain muscle you should intake:';
    }
  }
}