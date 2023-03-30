import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';
import 'package:appcouvoiturage/pages/details.dart';
import 'package:appcouvoiturage/pages/profilepage.dart';








class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/commencer',
      routes: {
        '/signin':(context) => const Connexin(title: 'connextion '),
        '/signup':(context) => const MyHomePage(title: 'SingnUp'),
        '/commencer':(context) => const MyBeginPage(title: 'begin'),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Connexin(title: 'Flutter Demo Home Page'),
    );
  }
}

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
                  image: AssetImage('asset/images/Ellipse 5.png'),
                  fit: BoxFit.fill,
                  
              )
            ),
          ),
      
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
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
                child: Image.asset('asset/images/logo-removebg-preview.png'),
              ),
            ),
            /*
            Container(
              padding: EdgeInsets.all(20),
              
              child: TextField(
                decoration: InputDecoration(
                icon: new Icon(Icons.mail),
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enterez votre mail example:abc@esi.dz',
                hintStyle: TextStyle(color: Colors.grey[500])
                ),
              ),
            ),*/
            /*PasswordFormField(
  onSaved: (value) {
    // Enregistrer la valeur du champ de saisie du mot de passe
  },
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer un mot de passe';
    }
    return null;
  },
  obscureText: true,
  hintText: 'Mot de passe',
  labelText: 'Mot de passe',
),*/

          /*Container(
            padding: EdgeInsets.all(20),
            child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: new Icon(Icons.password),
             // border: OutlineInputBorder(),
              labelText: 'Mot de passe ',
              hintText: 'Entere votre mot de passe ',
              hintStyle: TextStyle(color: Colors.grey[500])
            ),
            ),
          ),*/
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
                
                //color:Color(0xF0F0F0),
              
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
           
          /*Container(
           // height: 50,
            width: 300,
            //padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(30),
              
            ),
            child: 
            MaterialButton(color:Colors.blue ,
              height: 50 ,
        
              //MediaQueryData.fromView(80),
              onPressed: () {},

              
              //radius:  BorderRadius.circular(30) ,
              child: Padding(
                padding: const EdgeInsets.all(16),
                //borderRadius: BorderRadius.circular(30),
                child: Text('Login',style: TextStyle(color: Colors.white , fontSize: 18),),
              ),
            )
            ),
          //]
          //),
          */
          Container(
            width: 300,
            //padding: EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
            color: Colors.lightBlue ),
            child: TextButton(onPressed: (){},
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
          /*Center(
            child: RichText(
              TextSpan( 
                text: 'but this is', 
                style: new TextStyle(color: Colors.blue), 
                recognizer: new TapGestureRecognizer()
                onTap = () { launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html');}
            ),
            ),
          ),*/
         
          ] 
        ),
        /*child: Center( 
            child: new InkWell( 
              child: new Text('Open Browser'), 
              onTap: () => launch('https://docs.flutter.io/flutter/services/UrlLauncher-class.html')
            ), 
        ),*/
      
      
      ),
    );
       //bottomNavigationBar: BottomAppBar(;
      
    
    
  }
}
