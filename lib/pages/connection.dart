import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';

class  Connexin extends StatefulWidget {
  const Connexin ({super.key, required this.title});

  final String title;

  @override
  State<Connexin> createState() => _MyConnexinState();
}

class _MyConnexinState extends State<Connexin> {
  @override
  Widget build(BuildContext context) {
    bool visible=false;
    return Scaffold(
       resizeToAvoidBottomInset : false,
       
       appBar: AppBar(
          toolbarHeight: 100,

          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white, 
          title: Text(''),
          flexibleSpace: Container(
           decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse 5.png'),
                  fit: BoxFit.fill,
                  
              )
            ),
          ),
       ),
      body: Center(
        
        child: Column(
          //padding: const EdgeInsets.all(30),
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Container(
              height: 300.0,
              width: 350.0,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Image.asset('assets/images/logo-removebg-preview.png'),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Container(
             // backgroundColor: Color(0xF0F0F0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 163, 160, 160).withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              margin: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.mail,
                        color: Colors.black,
                        size: 20,
                      ),
                  ),
                  new Expanded(     
                    child: TextField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        hintText: "Enterez votre mail example: abc@esi.dz",
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
                     ),
           ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Container(

              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xF0F0F0).withOpacity(0.5),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(6.0),
                color:Color(0xF0F0F0),

                //color:Colors.white
              ),
              margin: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.key,
                        color: Colors.black,
                        size: 20,
                      ),
                  ),
                  new Expanded(     
                    child: TextField(
                      obscureText : visible,
                      //keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Mot de passe',
                        hintText: "Enterez votre mot de passe",
                        hintStyle: TextStyle(color: Colors.black),
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                      
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                InkWell(
                   onTap: (){
                    setState(() {
                      visible = !visible;
                    });
                   },
                    child:
                     Padding(
                      padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          /*Icons.visibility_off,*/
                          visible ? Icons.visibility :Icons.visibility_off, 
                          color: Colors.black,
                          size: 20,
                        ),
                    ),
                  ) ,
                ],
              ),
            ),
          ),
          Container(
            width: 300,
            //padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlue ),
            child: TextButton(onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context) => home(),) );

            },
             child: Text('Connexion',style: TextStyle(fontSize: 18,color: Colors.white),),
             
             ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Mot de passe oublier ?',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text('Voua n avez pas un compte?',style: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
          Container(
            padding: EdgeInsets.all(10),
          //  child: Text('Create Account ',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage(title: " sing up ",)),
            );
            // Navigate back to first route when tapped.
          },
          child: const Text('creer un compte',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
          ),
          ),
          ]
        ),
      ),
    );
  }
}
