import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cars.dart';

class Searchedcar extends StatefulWidget {
  
  final s_model;
  final s_priceFrom;
  final s_priceTo;
  final s_transimition;
  final s_yearFrom;
  final s_yearTo;
  final s_city;
  final sc_email;

   Searchedcar({ this.s_model, this.s_priceFrom, this.s_priceTo, this.s_transimition, this.s_yearFrom, this.s_yearTo, this.s_city,this.sc_email});




  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Searchedcar> {


 
Future getdata() async{
    var data ={'model': widget.s_model,
               'pricefrom':widget.s_priceFrom,
               'priceto':widget.s_priceTo,
               'transimition':widget.s_transimition,
               'yearfrom':widget.s_yearFrom,
               'yearto':widget.s_yearTo,
               'city':widget.s_city,
               };
    var url = "http://192.168.1.113/mycar/search.php";
    var response = await http.post(Uri.parse(url),body:data);
    var responsebody = jsonDecode(response.body);
    return responsebody;
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(alignment: Alignment(-.3,.5),child: Text("Cars")),
        
      ),
      body:FutureBuilder(
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
                    email: widget.sc_email,
                  );
                });
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
               
              }
              ),
          
        
      
        );
  }
}