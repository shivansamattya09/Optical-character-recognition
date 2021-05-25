import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'main.dart';

void main() => runApp(FfirstRoute());
class FfirstRoute extends StatelessWidget {
  String text;
  FfirstRoute({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Result',style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.black54,
      body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(3),
            child: Center(child: SelectableText(text,style: TextStyle(color: Colors.white),),),
          )
      ),
    );
  }
}