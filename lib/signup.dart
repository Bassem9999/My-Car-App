import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {


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

  TextEditingController name =  TextEditingController();
  TextEditingController password =  TextEditingController();
  TextEditingController confirmpassword =  TextEditingController();
  TextEditingController email =  TextEditingController();
 
  GlobalKey<FormState> formstatesignup = GlobalKey<FormState>();


  String? validname(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim().length<=4){
      return "Name is too short";
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

    String? validconfirm( text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
    else if(text.trim()!=password.text){
      return "wrong password";
    }
    return null ;
  }  

    String? validemail(text){
    if(text.trim().isEmpty){
      return "Not Valid";
    }
     return null ;
  }  


  signup() async {
   var formdata = formstatesignup.currentState;
   formdata!.save();
   if(formdata.validate()){
   var data ={'name':name.text,'password':password.text,'email':email.text};
   var url = "http://192.168.1.113/mycar/signup.php";
   var response = await http.post(Uri.parse(url),body: data);
   var responsebody = jsonDecode(response.body);
  if(responsebody['status']=="success"){
    print("success");
   Navigator.of(context).push(MaterialPageRoute(builder: (context){return Home(h_email:responsebody['email'],);}));
  }
  else{
    print("failed");
    showdialog(context, "This Account is Already Exist");
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
            children: <Widget>[
               AnimatedContainer(
                 duration:Duration(milliseconds: 900,),

                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
                   height: 610,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20)
                      ),
                 child: Form(
                    key: formstatesignup,
                   child: Column(
                     children: <Widget>[



           Container(
                   padding: EdgeInsets.symmetric(vertical: 30),
                   child: Center(child: Text("Sign up",style: TextStyle(color:Colors.white ,fontSize: 30,fontWeight: FontWeight.bold),)),
                 ),


                           textfield("Name",false,Icon(Icons.person,color: Colors.white,),name,validname),
                           textfield("Password",true,Icon(Icons.lock,color: Colors.white,),password,validpassword),
                           textfield("Confirm Password",true,Icon(Icons.person,color: Colors.white,),confirmpassword,validconfirm),
                           textfield("Email",false,Icon(Icons.lock,color: Colors.white,),email,validemail),


                  
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: RaisedButton(child: Text("Sign up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){
                      signup();
                      showcircle();
                    },
                    color: Colors.blue,
                    ),
                  ),


                   Container(
             margin: EdgeInsets.symmetric(vertical: 30),
             child: InkWell(
                     child: Center(child: Text("Already have Account",
                     style: TextStyle(color:Colors.blue,decoration: TextDecoration.underline),
                     )),
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){return Login();}));
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

textfield(String type,bool secure,Icon icon,TextEditingController mycontroller, valid){
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
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