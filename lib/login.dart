// ignore_for_file: prefer_const_constructors
import 'package:first_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
    showdialog(context,text) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text(text),);
    },
    );
  }

   showcircle() {
    return showDialog(context: context, builder: (context) {
      return AlertDialog( 
        title: Row(
          children: [
            Text(" Loading ....    ",style: TextStyle(color: Colors.white),),
            CircularProgressIndicator(),
          ],
        ),
        backgroundColor: Colors.grey,    
      );
    }
    );
    }
  
    
  Future setpref(String prefemail) async{
     
     SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString('email', prefemail);

       print(preferences.getString('email'));
  }

TextEditingController email =  TextEditingController();
TextEditingController password =  TextEditingController();

GlobalKey<FormState> formstatelogin = GlobalKey<FormState>();

String? validemail(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<=4){
      return "Email is too short";
    }
    return null ;
  }  

   String? validpassword( text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<8){
      return "Password should be more than 7 letters";
    }
     return null ;
  }  

 


Login() async {
   var formdata = formstatelogin.currentState;
   formdata!.save();
   if(formdata.validate()){
      var data ={'email':email.text,'password':password.text};
   var url = "http://192.168.1.113/mycar/login.php";
   var response = await http.post(Uri.parse(url),body: data);
   var responsebody = jsonDecode(response.body);
  
  if(responsebody['status']=='success'){
        print("success");
    //print(responsebody['email']);
   Navigator.of(context).push(MaterialPageRoute(builder: (context){return Home(h_email:responsebody['email'],);}));
        setpref(responsebody['email']);
        
  }
  else{
    print("failed");
    showdialog(context, "This Account does't Exist");
  }
   
   }
   
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(alignment: Alignment(-.4,.5),child: Text("Welcome to My Car")), 
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/car7.jpg"),fit: BoxFit.cover),
          ),
          child: ListView(
            //reverse: true,
            children: <Widget>[
              AnimatedContainer(
                 duration:Duration(milliseconds: 600,),
                 margin: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
                   height: 400,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)
                      ),
                 child: Form(
                     key: formstatelogin,
                   child: Column(
                     children: <Widget>[



           Container(
                   padding: EdgeInsets.symmetric(vertical: 30),
                   child: Center(child: Text("Login",style: TextStyle(color:Colors.white ,fontSize: 30,fontWeight: FontWeight.bold),)),
                 ),


                           textfield("Email",false,Icon(Icons.person,color: Colors.white),email,validemail),
                           textfield("Password",true,Icon(Icons.lock,color: Colors.white),password,validpassword),

                  
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      showcircle();
                      Login();
                    },
                    color: Colors.blue,
                    ),
                  ),



                  
           Container(
             margin: EdgeInsets.symmetric(vertical: 30),
             child: InkWell(
                     child: Center(child: Text("Create Account",
                     style: TextStyle(color:Colors.blue,decoration: TextDecoration.underline),
                     )),
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){return Signup();}));
                     },
                   ),
           ),
                    
                       
                     ],
                   ),
                 ),
               )
            ],
          ),
        ),
      );
    
  }
}


textfield(String type,bool secure,Icon icon,TextEditingController mycontroller,valid){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    child: TextFormField(
        obscureText: secure,
        controller: mycontroller,
        validator: valid,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          filled: true,
          fillColor: Colors.black.withOpacity(0.6),
           labelText: type,
           labelStyle: TextStyle(color: Colors.white),
           prefixIcon: icon,

           
        ),


    ),
  );
}