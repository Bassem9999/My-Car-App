
import 'package:first_app/information.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

 class Cars extends StatefulWidget {
  final model;
  final price;
  final transimition;
  final kilometers;
  final year;
  final name;
  final phone;
  final city;
  final info;
  final photo1;
  final photo2;
  final photo3;
  final photo4;
  final id;
  final email;
  
  Cars({this.model,this.price,this.transimition,this.kilometers,this.year,this.name,this.phone,this.city,this.info,this.photo1,this.photo2,this.photo3,this.photo4,this.id,this.email});

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {


 favornot() async {
   var data ={'carid':widget.id.toString(),'email':widget.email};
   var url = "http://192.168.1.113/mycar/getfav.php";
   var response = await http.post(Uri.parse(url),body: data);
   var responsebody = jsonDecode(response.body);

    if(responsebody['status']=='fav'){

      Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Information(
        i_model:widget.model,
        i_price:widget.price,
        i_transimition:widget.transimition,
        i_kilometers:widget.kilometers , 
        i_year:widget.year,
        i_name:widget.name,
        i_phone:widget.phone,
        i_city:widget.city,
        i_info:widget.info,
        i_photo1:widget.photo1,
        i_photo2:widget.photo2,
        i_photo3:widget.photo3,
        i_photo4:widget.photo4,
        i_id: widget.id,
        useremail:widget.email,
        i_favourite: true,);
      }));
  }

  else{
     Navigator.of(context).push(MaterialPageRoute(builder: (context){
     return Information(
        i_model:widget.model,
        i_price:widget.price,
        i_transimition:widget.transimition,
        i_kilometers:widget.kilometers , 
        i_year:widget.year,
        i_name:widget.name,
        i_phone:widget.phone,
        i_city:widget.city,
        i_info:widget.info,
        i_photo1:widget.photo1,
        i_photo2:widget.photo2,
        i_photo3:widget.photo3,
        i_photo4:widget.photo4,
        i_id: widget.id,
        useremail:widget.email,
        i_favourite: false,);
    }));
 
  }
 
  }
 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(      
      child: Row(
        children: <Widget>[
           Container(child: Image.network("http://192.168.1.113/mycar/upload/"+widget.photo1,height:120,width: 160,fit: BoxFit.cover,)),
           Column(
             children: <Widget>[
                Container(child: Text("Model : "+widget.model),margin: EdgeInsets.only(left: 10,bottom: 10),),
                Container(child: Text("Price : "+widget.price,style: TextStyle(color: Colors.grey),),margin: EdgeInsets.only(left: 10)),
                Container(child: Text("City : "+widget.city,style: TextStyle(color: Colors.grey),),margin: EdgeInsets.only(left: 15),),
                
             ]
           )
        ],
      ),
      ),
                  onTap: (){
                 // _fav=false;
                  favornot();
                 
          
                  
                     
                  },
    );
  }
} 
  
  
 
 

class List extends StatefulWidget {
  
final l_email;

   List({this.l_email}) ;
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {

Future getdata() async{
    var url = "http://192.168.1.113/mycar/index.php";
    var response = await http.get(Uri.parse(url));
    var responsebody = jsonDecode(response.body);
    return responsebody;
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(alignment: Alignment(-.3,.5),child: Text("Cars")),
        
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
             return ListView.builder( itemCount: snapshot.data.length, itemBuilder:(context,i){
            return Cars(
              model: snapshot.data[i]['model'],
              price: snapshot.data[i]['price'],
              transimition: snapshot.data[i]['transmition'],
              kilometers: snapshot.data[i]['kilometers'],
              year: snapshot.data[i]['year'],
              name: snapshot.data[i]['name'],
              phone: snapshot.data[i]['phone'],
              city: snapshot.data[i]['city'],
              info: snapshot.data[i]['info'],
              photo1: snapshot.data[i]['photo1'],
              photo2: snapshot.data[i]['photo2'],
              photo3: snapshot.data[i]['photo3'],
              photo4: snapshot.data[i]['photo4'],
              id: snapshot.data[i]['id'],
              email: widget.l_email
            );
          });
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
         
        }
        )
        );
    
  }
}

 
 