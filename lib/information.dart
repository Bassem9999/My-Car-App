import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Information extends StatefulWidget {
  final i_model;
  final i_price;
  final i_transimition;
  final i_kilometers;
  final i_year;
  final i_name;
  final i_phone;
  final i_city;
  final i_info;
  final i_photo1;
  final i_photo2;
  final i_photo3;
  final i_photo4;
  final i_id;
  final useremail;
  bool i_favourite;
  Information({ this.i_model, this.i_price, this.i_transimition, this.i_kilometers, this.i_year, this.i_name, this.i_phone, this.i_city, this.i_info, this.i_photo1,this.i_photo2,this.i_photo3,this.i_photo4, this.i_id,this.useremail, required this.i_favourite});

  

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {

 // bool favourite = false;
  
showOwner() {
    return showDialog(context: context, builder: (context) {
      return Container(
        margin: EdgeInsets.only(bottom: 250,top: 200),
        child: AlertDialog( 
          title: Text("The Owner") ,
          
          content: Column(
            children: [
              Row(
                children: [
                  Text(" Name :   ",style: TextStyle(color: Colors.black),),
                  Text(widget.i_name,style: TextStyle(color: Colors.black),),                
                ],
              ),
              Row(
                children: [
                  Text(" Phone :   ",style: TextStyle(color: Colors.black),),
                  Text(widget.i_phone,style: TextStyle(color: Colors.black),),                
                ],
              ),
            ],
          ), 
          backgroundColor: Colors.white,    
        ),
      );
      
    }
    );
    }

 
  fav() async {
   var data ={'carid':widget.i_id.toString(),'email':widget.useremail,'favourite':widget.i_favourite.toString()};
   var url = "http://192.168.1.113/mycar/favourite.php";
   var response = await http.post(Uri.parse(url),body: data);
   var responsebody = jsonDecode(response.body);
    if(responsebody['status']=='success'){
        print("success");  
  }
  else{
    print("failed");
   
  }
  // print(responsebody['status']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Info"),
        actions: [
          IconButton(
            icon: widget.i_favourite?Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_border),
            tooltip: "Add to Favourites",
            onPressed: (){                
               print(widget.useremail);
               setState(() {
                  widget.i_favourite = !widget.i_favourite;
               });   
               fav();
               print(widget.i_favourite);
            },
            splashColor: Colors.red,
            ),

            IconButton(
            icon:  Icon(Icons.phone_forwarded),
            tooltip: "Contact with the Owner",
            onPressed: (){                
              showOwner();
            },
            splashColor: Colors.red,
            ),
            
        ],
        
      ),

        drawer: Mydrawer(d_email: widget.useremail,),

      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
              width: 400,
              child: Carousel(
                images: [
             Image.network("http://192.168.1.113/mycar/upload/"+widget.i_photo1),
             Image.network("http://192.168.1.113/mycar/upload/"+widget.i_photo2),
             Image.network("http://192.168.1.113/mycar/upload/"+widget.i_photo3),
             Image.network("http://192.168.1.113/mycar/upload/"+widget.i_photo4),
                ],
              ),
            ),


            Container(
              margin: EdgeInsets.only(top:10,left: 10,right: 10),
              child: Text("Informations about the Car",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
            ),


            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),color: Colors.black.withOpacity(0.15)
              ),
              child: Text(widget.i_info,style: TextStyle(fontSize: 15),),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              height: 50,
              child: Text("Mark :                                   "+widget.i_model,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              height: 50,
              child: Text("Price :                                   "+widget.i_price,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              height: 50,
              child: Text("Transimition :                      "+widget.i_transimition,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              height: 50,
              child: Text("Kilometers :                         "+widget.i_kilometers,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey,
              height: 50,
              child: Text("Year :                                     "+widget.i_year,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),

              Container(
              padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
              color: Colors.white,
              height: 50,
              child: Text("City :                                      "+widget.i_city,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),


// Container(
//               margin: EdgeInsets.only(top:30,left: 7,right: 10,bottom: 10),
//               child: Text("Informations about the Owner",
//               style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
//             ),

//             Container(
//               padding: EdgeInsets.all(10),
//               color: Colors.grey,
//               height: 50,
//               child: Text("Owner :   "+widget.i_name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//             ),

//             Container(
//               padding: EdgeInsets.all(10),
//               color: Colors.white,
//               height: 50,
//               child: Text("Phone :    "+widget.i_phone,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
//             ),


          ],
        ),
      ),
    );
  }
}