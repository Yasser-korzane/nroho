import 'package:appcouvoiturage/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:appcouvoiturage/pages/login.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'Poppins'),
    home: Wrapper(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
        '/commencer':(context) => const MyBeginPage(title: 'begin') ,
      },
      theme: ThemeData(
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

    return Scaffold(
      resizeToAvoidBottomInset : false,

      appBar: AppBar(
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
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter valid mail id as abc@gmail.com',
                      hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password',
                      hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
              ),
              Container(
                // height: 50,
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(30)
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text('Login',style: TextStyle(color: Colors.white , fontSize: 18)),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text('Forgot password ? ',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text('New User ?  ',style: TextStyle(color: Colors.grey, fontSize: 15)),
              ),
              Padding(
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
                  child: const Text('create account'),
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
      //bottomNavigationBar: BottomAppBar(),

    );



  }
}