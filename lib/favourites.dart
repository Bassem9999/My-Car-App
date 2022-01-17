import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cars.dart';




class Favlist extends StatefulWidget {
  
final f_email;

   Favlist({this.f_email}) ;
  @override
  _FavlistState createState() => _FavlistState();
}

class _FavlistState extends State<Favlist> {

Future getdata() async{
    var data = {'email':widget.f_email};
    var url = "http://192.168.1.113/mycar/showfav.php";
    var response = await http.post(Uri.parse(url),body: data);
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
              email: widget.f_email
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


