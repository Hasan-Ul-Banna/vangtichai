import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: vangtiChai(),
  ));
}

class vangtiChai extends StatefulWidget {
  const vangtiChai({Key? key}) : super(key: key);

  @override
  _vangtiChaiState createState() => _vangtiChaiState();
}

class _vangtiChaiState extends State<vangtiChai> {
  String taka = '';
  List<int> noteNum = [0, 0, 0, 0, 0, 0, 0, 0]; // 500,100,50,20,10,5,2,1
  List<int> noteType = [500, 100, 50, 20, 10, 5, 2, 1];
  double tkGap = 40.0;
  double btnGap = 20.0;

  void calculate(String tk) {
    int taka = int.parse(tk);
    setState(() {
      while (taka != 0) {
        for (int i = 0; i < noteType.length; i++) {
          noteNum[i] = (taka / noteType[i]).floor();
          if (noteNum[i] != 0) {
            taka = taka - (noteNum[i] * noteType[i]);
          }
        }
      }
    });
  }

  Widget txtBoxNoteNum(int i) {
    return (Text(
      '${noteType[i]} : ${noteNum[i]}',
      style: const TextStyle(
        fontSize: 25.0,
      ),
    ));
  }

  Widget numPadBtn(int i, j) {
    int btnVal = 0;
    if (i == 0 || i == 3) {
      btnVal = j;
    } else if (i == 1) {
      btnVal = j + 3;
    } else if (i == 2) {
      btnVal = j + 6;
    }
    return (i==3 && j == 1)? clearBtn() : numBtn(btnVal);
  }

  Widget numBtn(int btnVal){
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: (TextButton(
        onPressed: () {
          taka = taka + '$btnVal';
          calculate(taka);
        },
        child: Text(
          '$btnVal',
          style: const TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        style: TextButton.styleFrom(
          primary: Colors.teal,
          backgroundColor: Colors.grey[400],
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          padding: const EdgeInsets.fromLTRB(28, 10, 28, 10),
        ),
      )),
    );
  }

  Widget clearBtn(){
    return Container(
      margin: EdgeInsets.all(5.0),
      child: (TextButton(
        onPressed: () {
          setState(() {
            taka = '';
            noteNum = [0, 0, 0, 0, 0, 0, 0, 0];
          });
        },
        child: const Text(
          'CLEAR',
          style:
          TextStyle(fontSize: 25.0, color: Colors.black),
        ),
        style: TextButton.styleFrom(
          primary: Colors.teal,
          backgroundColor: Colors.grey[400],
          shape: const BeveledRectangleBorder(
              borderRadius:
              BorderRadius.all(Radius.circular(2))),
          padding: const EdgeInsets.fromLTRB(38, 10, 38, 10),
        ),
      )),
    );
  }

  Widget numPadRow(int i) {
    return (Row(
      children: [
        SizedBox(width: btnGap),
        if(i!=3) for (int j = 1; j < 4; j++) numPadBtn(i, j),
        if(i==3) for (int j = 0; j < 2; j++) numPadBtn(i, j),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('VangtiChai'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(165, 50, 20, 0),
            child: Row(
              children: [
                Text(
                  'Taka: $taka',
                  style: const TextStyle(
                    fontSize: 25.0,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 0; i < noteType.length; i++) txtBoxNoteNum(i),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < 4; i++) numPadRow(i),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
