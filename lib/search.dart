import 'package:first_app/main.dart';
import 'package:first_app/searchedcar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search extends StatefulWidget {
  final s_email;
   Search({this.s_email});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

 
    TextEditingController priceFrom = TextEditingController();
    TextEditingController priceTo   = TextEditingController();
    TextEditingController yearFrom  = TextEditingController();
    TextEditingController yearTo    = TextEditingController();

    GlobalKey<FormState> searchform = GlobalKey<FormState>();





  filter(){
    if(priceFrom.text.isEmpty){
      priceFrom.text="0";
    }
    if(priceTo.text.isEmpty){
      priceTo.text = "1500000000";
    }
    if(yearFrom.text.isEmpty){
      yearFrom.text = "1900";
    }
    if(yearTo.text.isEmpty){
      yearTo.text = "2200";
      
    }
  }

    String? _city;
    String? _mark;
    String? _transimition;

    var cities = ["Cairo","Alexandria","Al-Sharkia","Aswan","Luxor","Al-Minoufia","Al-Garbia",
    "Dakahlia","North Sainai","South Sainia","PortSaid","Dumait","Ismailia","Suiz","Al-Minia",
    "Al-Qalubia","Asuit","Al-Fayoum","Giza","Hurgaida","Kafr Al-Sheikh","Al-Bahr Al-Ahmar",
    ];
    
    var marks = ["Mercides","BMW","Ferrari","Hundai","Toyota","Audi","Dodge","Peigout",
    "Lamburgini","Geely","BYD","Pugatti","Honda","Jeep","Chevorlet","Ford","KIA","Fiat",
    "Suzouki","Nissan","Sang yong","Skoda","Lada","Mazda","Mitsubishu","Obel","Rino","Jaguar",
    "Volkes wagn","Subarou","Alpha Romeo","Siat","Land Rover","Jac","Isuzu","MG","Mini","Sheri",
    "Pourch","Maziratti","Aston Martin","Volvo"
    ];
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(alignment: Alignment(-.4,.5),child: Text("Search Page")),
      ),
      body: Form(
                         key: searchform,
                    child:ListView(
                      children: <Widget>[
                          Container(
                 margin: EdgeInsets.only(top: 10,left: 10,bottom:20),
                 child: Text("Search for your Favourite Car :-",
                 style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
               ),

            
              Row(
                 children: [

                  Container(
                    margin: EdgeInsets.only(left: 20,bottom: 20),
                    child:Text("Car Mark : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 20,left: 57,right: 70),
                     child: DropdownButton(
                        value: _mark,
                        hint: Text("Mark"),
                        dropdownColor: Colors.grey,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(fontSize: 12.6,fontWeight: FontWeight.bold,color: Colors.black),
                        onChanged: (String? newvalue){
                          setState(() {
                            _mark = newvalue ;
                          });
                        },
                       items: marks.map((valueitem){
                        return DropdownMenuItem(
                          value: valueitem, 
                          child: Text(valueitem),
                        );
                       
                       }).toList()
                       
                       ),
                   ),
                 ],
               ),


               

                Row(
                 children: [

                  Container(
                    margin: EdgeInsets.only(left: 20,bottom: 20),
                    child:Text("Transimition : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 20,left: 30,right: 70),
                     child: DropdownButton(
                        value: _transimition,
                        hint: Text("Transimition"),
                        dropdownColor: Colors.grey,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(fontSize: 13.4,fontWeight: FontWeight.bold,color: Colors.black),
                        onChanged: (String? newvalue){
                          setState(() {
                            _transimition = newvalue ;
                          });
                        },
                       items: ["Manual","Auto"].map((valueitem){
                        return DropdownMenuItem(
                          value: valueitem, 
                          child: Text(valueitem),
                        );
                       
                       }).toList()
                       
                       ),
                   ),
                 ],
               ),

               Row(
                 children: [

                  Container(
                    margin: EdgeInsets.only(left: 20,bottom: 20),
                    child:Text("Your City : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 20,left: 57,right: 70),
                     child: DropdownButton(
                        value: _city,
                        hint: Text("City"),
                        dropdownColor: Colors.grey,
                        icon: Icon(Icons.arrow_drop_down),
                        style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.black),
                        onChanged: (String? newvalue){
                          setState(() {
                            _city = newvalue ;
                          });
                        },
                       items: cities.map((valueitem){
                        return DropdownMenuItem(
                          value: valueitem, 
                          child: Text(valueitem),
                        );
                       
                       }).toList()
                       
                       ),
                   ),
                 ],
               ),

               textform("price from",priceFrom,TextInputType.number,),
               textform("Price to",priceTo,TextInputType.number,),
               textform("Year from",yearFrom,TextInputType.datetime,),
               textform("year to",yearTo,TextInputType.datetime,),
              
              Container(
                child: ElevatedButton(child: Text("Search"),
                onPressed: (){
                   var formdata = searchform.currentState;
                       formdata!.save();
                       filter();
                      if(formdata.validate()){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Searchedcar(
                        s_model: _mark,
                        s_transimition: _transimition,
                        s_city: _city,
                        s_priceFrom:priceFrom.text,
                        s_priceTo: priceTo.text,
                        s_yearFrom: yearFrom.text,
                        s_yearTo: yearTo.text,
                        sc_email: widget.s_email,
                        );
                    }));
                      }
                  
                }
                ,),
              )
                      ],
                      )   
              
               
      ),
    );
  }
}


textform(String label,TextEditingController mycontroller ,inputType,){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
    child: TextFormField(
      controller: mycontroller,
      keyboardType:inputType,
     
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
    ),
  );
}
