import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  //inheritance
  @override //polymorphism
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPicked) {
    bool ans = quizBrain.getQuestionAns();
    setState(() {
      if (quizBrain.isFinished()==true){
      Alert(
      context: context,
      title: 'Finished!',
      desc: 'You\'ve reached the end of the quiz.',
      ).show();

      quizBrain.reset();
      scoreKeeper = [];
      }
      else{
      if (ans == userPicked) {
      scoreKeeper.add(
      Icon(
      Icons.check,
      color: Colors.green,
      ),
      );
      } else {
      scoreKeeper.add(
      Icon(
      Icons.close,
      color: Colors.red,
      ),
      );
      }
      quizBrain.nextQuestion();
      }
    });
  }


  //   List<String> questions = [
  //     'You can lead a cow down stairs but not up stairs.',
  //     'Approximately one quarter of human bones are in the feet.',
  //     'A slug\'s blood is green.'
  //   ];
  //
  //   List<bool> answers = [false, true, true];

  // List<Question> quesSet = [
  //   Question(q: 'You can lead a cow down stairs but not up stairs.', a: false),
  //   Question(q: 'Approximately one quarter of human bones are in the feet.', a: true),
  //   Question(q: 'A slug\'s blood is green.', a: true)
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);

                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children:
          scoreKeeper, //need list of widgets as children and scorekeeper is list of icon widget
        ),
      ],
    );
  }
}
