import 'package:first_app/add.dart';
import 'package:first_app/cars.dart';
import 'package:first_app/main.dart';
import 'package:first_app/prices.dart';
import 'package:first_app/search.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'favourites.dart';

//import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget {
  final h_email;

   Home({ this.h_email});
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


   

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Container(alignment: Alignment(-.3,.5),child: Text("Home")),
      ),
      drawer: Mydrawer(d_email:widget.h_email,),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/car8.jpg"),fit: BoxFit.fill)
        ),
        
        child:GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) ,
        children: <Widget> [
               
               Container(
                 margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.black.withOpacity(0.6),
                   ),
                 child: InkWell(
                   child: GridTile(child: Column(children: <Widget>[
                     Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.add_circle_outline_rounded,size: 70,color: Colors.lightBlueAccent,)),
                     Container(margin: EdgeInsets.only(top: 20),
                     child: Text("Add your Car",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 20 ),))
                   ],)),
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){return Addcar();}));
                },
                 ),
               ),


                Container(
                   margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.black.withOpacity(0.6),
                   ),
                  child: InkWell(
                   child: GridTile(child: Column(children: <Widget>[
                     Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.car_rental,size: 70,color: Colors.lightBlueAccent,)),
                     Container(margin: EdgeInsets.only(top: 20),
                     child: Text("Search for a Car",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 19 ),))

                   ],)),
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){return List(l_email: widget.h_email);}));
                   },
               ),
                ),


                 Container(
                   margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.black.withOpacity(0.6),
                   ),
                  child: InkWell(
                   child: GridTile(child: Column(children: <Widget>[
                     Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.search,size: 70,color: Colors.lightBlueAccent,)),
                     Container(margin: EdgeInsets.only(top: 20),
                     child: Text("Advanced Search",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 19 ),))

                   ],)),
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context){return Search(s_email: widget.h_email,);}));
                   },
               ),
                ),




                Container(
                 margin: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(40),
                   color: Colors.black.withOpacity(0.6),
                 ),
                 child: GridTile(child: Column(children: <Widget>[
                   Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.car_repair_outlined,size: 70,color: Colors.lightBlueAccent,)),
                   Container(margin: EdgeInsets.only(top: 20),
                   child: Text("Car Service",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 19 ),))

                 ],)),
               ),


               Container(
                  margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.black.withOpacity(0.6),
                   ),
                 child: InkWell(
                   child: GridTile(child: Column(children: <Widget>[
                     Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.favorite_outline_outlined,size: 70,color: Colors.lightBlueAccent,)),
                     Container(margin: EdgeInsets.only(top: 20),
                     child: Text("Favorites",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 19 ),))

                   ],)),

                   onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context){return Favlist(f_email: widget.h_email);}));

                   },
                 ),
               ),

                Container(
                  margin: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(40),
                     color: Colors.black.withOpacity(0.6),
                   ),
                 child: InkWell(
                   child: GridTile(child: Column(children: <Widget>[
                     Container(margin: EdgeInsets.only(top: 20),child: Icon(Icons.price_check,size: 70,color: Colors.lightBlueAccent,)),
                     Container(margin: EdgeInsets.only(top: 20),
                     child: Text("Car Prices",style: TextStyle(color:Colors.lightBlueAccent,fontSize: 19 ),))

                   ],)),

                   onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context){return Prices();}));

                   },
                 ),
               ),
        ],),
      ),
  
    );
    
    
  }
}