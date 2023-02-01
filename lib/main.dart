import 'package:flutter/material.dart';
import 'package:hangman_1/ui/colors.dart';
import 'package:hangman_1/ui/widget/figure_image.dart';
import 'package:hangman_1/ui/widget/letter.dart';
import 'package:hangman_1/game/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //Game word list
  List<String> wordList = ["FLUTTER","PROGRAMMING","CLASS","SCHOOL",
    "FUTURE", "LANGUAGE","CARRIER","BILL","MOTHER","ARGUE","HANGMAN","GROW","VOTING","SHUT",
    "PILL", "OPPOSED","FLAG","RACE","SPEED","BIAS","HERSELF","DOUGH","RELEASE","SUBJECT",
    "PUSH", "FANTASY","PLAN","LAST","ATTACK","COIN","ONE","STEM","SCAN","ENHANCE",
    "BRICK","SURVIVE","LEADING","STAKE","NERVE","INTENSE","SUSPECT","WHEN","LIE",
    "SPOILED","ANALYSE","VARIANCE","ROLLING","MEANING","RESPECT","PLURAL"];

  //Alphabet
  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: Text("Hangman"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              children: [
               // Figure widget
                figureImage(Game.tries >= 0, "images/hang.png"),
                figureImage(Game.tries >= 1, "images/head.png"),
                figureImage(Game.tries >= 2, "images/body.png"),
                figureImage(Game.tries >= 3, "images/ra.png"),
                figureImage(Game.tries >= 4, "images/la.png"),
                figureImage(Game.tries >= 5, "images/rl.png"),
                figureImage(Game.tries >= 6, "images/ll.png"),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: wordList
                //.split('')
                .map((e) => letter(e.toUpperCase(),
                !Game.selectedChar.contains(e.toUpperCase())))
                .toList(),
          ),

          //the Game keyboard
          SizedBox(
            width: double.infinity,
            height: 250.0,
            child: GridView.count(
              crossAxisCount: 7,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              padding: EdgeInsets.all(8.0),
              children: alphabets.map((e) {
                return RawMaterialButton(
                  onPressed: Game.selectedChar.contains(e)
                      ? null
                      : () {
                    setState(() {
                      Game.selectedChar.add(e);
                      print(Game.selectedChar);
                      if (!wordList.contains(e.toUpperCase())) {
                        Game.tries++;
                      }
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  fillColor: Game.selectedChar.contains(e)
                      ? Colors.black87
                      : Colors.blue,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}