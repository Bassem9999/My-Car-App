import 'package:flutter/material.dart';

class Prices extends StatefulWidget {
  const Prices({ Key? key }) : super(key: key);

  @override
  _PricesState createState() => _PricesState();
}

class _PricesState extends State<Prices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Container(alignment: Alignment(-.3,.5),child: Text("Car Prices")),
      ),
      body: Column(children: <Widget>[

      ],),
    );
  }
}