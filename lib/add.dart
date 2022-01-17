import 'dart:io';
import 'package:first_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Addcar extends StatefulWidget {
  const Addcar({ Key? key }) : super(key: key);

  @override
  _AddcarState createState() => _AddcarState();
}

class _AddcarState extends State<Addcar> {

   File? _file1;
   File? _file2;
   File? _file3;
   File? _file4;
   bool? _source;

    showsource(fi) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog( 
        title: Row(
          children: [
            Container( padding: EdgeInsets.only(left: 10),
            child: ElevatedButton(child: Text("Camera"),onPressed: (){
              setState(() {
                _source = true;
              });
               if(fi == _file1){ pickimage1();}
          else if(fi == _file2){ pickimage2();}
          else if(fi == _file3){ pickimage3();}
          else if(fi == _file4){ pickimage4();}
            },
            )),
            Container(padding: EdgeInsets.only(left: 40),child: ElevatedButton(child: Text("Gallary"),onPressed: (){
              setState(() {
                _source = false;
              });
               if(fi == _file1){ pickimage1();}
          else if(fi == _file2){ pickimage2();}
          else if(fi == _file3){ pickimage3();}
          else if(fi == _file4){ pickimage4();}
            },)),
          ],
        ),
        backgroundColor: Colors.black54,
      );
    }
    );
    }

Future pickimage1() async {
  final myfile;
 if(_source==true){ myfile =  await ImagePicker().pickImage(source: ImageSource.camera);
}else{
    myfile =  await ImagePicker().pickImage(source: ImageSource.gallery);
}
  setState(() {
     _file1 = File(myfile!.path);
    
  });
}

Future pickimage2() async {
 final myfile;
 if(_source==true){ myfile =  await ImagePicker().pickImage(source: ImageSource.camera);
}else{
    myfile =  await ImagePicker().pickImage(source: ImageSource.gallery);
}
  setState(() {
     _file2 = File(myfile!.path);
    
  });
}

Future pickimage3() async {
 final myfile;
 if(_source==true){ myfile =  await ImagePicker().pickImage(source: ImageSource.camera);
}else{
    myfile =  await ImagePicker().pickImage(source: ImageSource.gallery);
}
  setState(() {
     _file3 = File(myfile!.path);
    
  });
}

Future pickimage4() async {
 final myfile;
 if(_source==true){ myfile =  await ImagePicker().pickImage(source: ImageSource.camera);
}else{
    myfile =  await ImagePicker().pickImage(source: ImageSource.gallery);
}
  setState(() {
     _file4 = File(myfile!.path);
    
  });
}



// Future uploadimage() async {
//   if(_file == null) return;

//   String base64 = base64Encode(_file!.readAsBytesSync());
//   String imagename = _file!.path.split("/").last;
//   print(imagename);
// }


 showmessage(context,text){
   return showDialog(context: context, builder: (context){
     return AlertDialog(title: Text(text),);
   });
 }

  TextEditingController name =  TextEditingController();
  TextEditingController phone =  TextEditingController();
  TextEditingController price =  TextEditingController();
  TextEditingController kilometers =  TextEditingController();
  TextEditingController year =  TextEditingController();
  TextEditingController info =  TextEditingController();

 
  GlobalKey<FormState> form = GlobalKey<FormState>();


  upload() async {
   var formdata = form.currentState;
   formdata!.save();
   if(formdata.validate()){
     if(_file1 == null && _file2 == null && _file3 == null && _file4 == null) return;
  String base64_1 = base64Encode(_file1!.readAsBytesSync());
  String imagename1 = _file1!.path.split("/").last;

  String base64_2 = base64Encode(_file2!.readAsBytesSync());
  String imagename2 = _file2!.path.split("/").last;

  String base64_3 = base64Encode(_file3!.readAsBytesSync());
  String imagename3 = _file3!.path.split("/").last;

  String base64_4 = base64Encode(_file4!.readAsBytesSync());
  String imagename4 = _file4!.path.split("/").last;
  
      var data ={
        'name':name.text,
        'phone':phone.text,
        'city':_city,
        'model':_mark,
        'price':price.text,
        'transimition':_transimition,
        'kilometers':kilometers.text,
         'year':year.text,
         'info':info.text,
         'imagename1':imagename1,
         'image64_1':base64_1,
         'imagename2':imagename2,
         'image64_2':base64_2,
         'imagename3':imagename3,
         'image64_3':base64_3,
         'imagename4':imagename4,
         'image64_4':base64_4,
        };
   var url = "http://192.168.1.113/mycar/upload.php";
   var response = await http.post(Uri.parse(url),body:data);
   var responsebody = jsonDecode(response.body);
  
  if(responsebody['status']=='success'){
    showmessage(context,"Your Car successfully uploaded");
    name.text = phone.text = price.text = kilometers.text = year.text = info.text = "";
    print("success");
  }
  else{
    print("failed");
  }

   }
   
 }


  image(f){
    return Column(
      children: [
        Container(
                  height: 100,
                  width: 80,
                  padding: EdgeInsets.only(right: 5,),
                  child: f == null? Icon(Icons.camera_alt_outlined,size: 40,) : Image.file(f!,scale: 2,),
                ),
         Container(width: 90,
         height: 30,
         padding: EdgeInsets.only(right: 3,left: 3),
         child: ElevatedButton(child: Text("Add Pic"),onPressed: (){
            showsource(f);
           },)),

      ],
    );
  }


String? validname(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<=4){
      return "Name is too short";
    }
    return null ;
  }  

   String? validphone( text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<11){
      return "Phone number should be more than 10 numbers";
    }
     return null ;
  }  

    String? validprice( text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    
    return null ;
  }  

    String? validkilometers(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
     return null ;
  }  

  String? validyear(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<4){
      return "Non valid Year";
    }
     return null ;
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
        title: Container(alignment: Alignment(-.4,.5),child: Text("Add Your Car")),

        ),
        drawer:Mydrawer(),
        body: Form(
          key: form,
          child: ListView(children: <Widget>[
          
               Container(
                 margin: EdgeInsets.only(top: 10,left: 10,bottom:20),
                 child: Text("Please Complete this Form :-",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
               ),
               Row(
                 children: <Widget>[
                 image(_file1),
                 image(_file2),
                 image(_file3),
                 image(_file4),
                 
                 ],
               ),
            

               Container(
                 margin: EdgeInsets.only(left: 10,top: 10),
                 child: Text("Personal Info :-",
                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.blue,decoration: TextDecoration.underline),),
               ),


               textform("Your Name",name,TextInputType.name,validname),
               textform("Phone Number",phone,TextInputType.phone,validphone),

               Row(
                 children: [

                  Container(
                    margin: EdgeInsets.only(left: 20,bottom: 30),
                    child:Text("Your City : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 40,left: 57,right: 70),
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

               Container(
                 margin: EdgeInsets.only(left: 10,top: 20),
                 child: Text("Car Info :-",
                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.blue,decoration: TextDecoration.underline),),
               ),

                Row(
                 children: [

                  Container(
                    margin: EdgeInsets.only(left: 20,bottom: 30),
                    child:Text("Car Mark : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 40,left: 57,right: 70),
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
                    margin: EdgeInsets.only(left: 20,bottom: 30),
                    child:Text("Transimition : ",style:TextStyle(fontSize:17,fontWeight:FontWeight.bold))
                  ),
                   Container(
                     width: 100,
                     margin: EdgeInsets.only(top:10,bottom: 40,left: 30,right: 70),
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
               
               textform("KiloMeters",kilometers,TextInputType.number,validkilometers),
               textform("Model Year",year,TextInputType.datetime,validyear),
               textform("the Price",price,TextInputType.number,validprice),

               Container(
                 height: 200,
                 margin: EdgeInsets.symmetric(horizontal: 10),
                 child: TextFormField(
                  maxLines: 7,
                  controller: info,
                   decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Write  Informations about Your Car"
                   ),
                 ),
               ),
               
               
               Container(
                 margin: EdgeInsets.symmetric(horizontal: 110),
                 child:RaisedButton(
                   child: Text("Upload my Car",style: TextStyle(color: Colors.white),),
                   color: Colors.blueAccent,
                   onPressed: (){upload();},
                 ) ,
                 )

          ],),
        ),
    );
  }
  


textform(String label,TextEditingController mycontroller,inputType,valid){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
    child: TextFormField(
      controller: mycontroller,
      keyboardType:inputType,
        validator: valid,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
    ),
  );
}
}