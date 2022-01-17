import 'package:flutter/material.dart';

class Developer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container(alignment: Alignment(-.3,.5),child: Text("Developer")),
      ),
      body: Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("Welcom to MyCar App ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),   
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("developed by :  Eng/ Bassem Ramadan   ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      )    
      ],),
    );
  }
}