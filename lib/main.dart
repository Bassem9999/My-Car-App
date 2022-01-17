import 'package:first_app/add.dart';
import 'package:first_app/developer.dart';
import 'package:first_app/favourites.dart';
import 'package:first_app/tips.dart';
import 'package:flutter/material.dart';
import 'package:first_app/home.dart';
import 'package:first_app/login.dart';
import 'package:first_app/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cars.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  
  
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Car',
      home: Tips(),

      routes: {
        "login":(context){
          return Login();
        },

        "signup":(context){
          return Signup();
        },
       
      },

    );
  }
}


class Mydrawer extends StatelessWidget {
 
final d_email;

   Mydrawer({this.d_email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[ 
        UserAccountsDrawerHeader
        (accountName: Text(""),
         accountEmail: Text(d_email),  
         decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage("images/car3.jpg",),fit: BoxFit.cover)
         ),
         ),
        ListTile( 
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return Home(h_email: d_email,);}));
          },
        ),

        ListTile(
          leading: Icon(Icons.car_rental),
          title: Text("Cars"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return List(l_email: d_email,);}));
          },
        ),

        ListTile(
          leading: Icon(Icons.favorite),
          title: Text("Favourites"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return Favlist(f_email: d_email,);}));
          },
        ),

        ListTile(
          leading: Icon(Icons.contact_phone_outlined),
          title: Text("Developer"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return Developer();}));
          },
        ),

        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Log out"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){return Login();}));
          },
        ),


      ],),
    );
  }
}