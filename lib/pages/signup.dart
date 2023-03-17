import 'package:appcouvoiturage/pages/home.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // appBar: AppBar(

      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      //   title: Text(widget.title),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('asset/images/Ellipse 5.png'),
            fit: BoxFit.fill,
          )),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /*
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your username',
             ),
          ),
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your First name',
             ),
          ),
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your last name',
             ),
          ),
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your email',
             ),
          ),
          TextFormField(
            decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Enter your phone number',
             ),
          ),*/
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' First Name',
                      hintText: 'Enter your First name '),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'last Name',
                      hintText: 'Enter your last name'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid mail id as abc@esi.dz'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter your secure password'),
                ),
              ),
              Container(
                width: 300,
                //padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
                  },
                  child: Text(
                    'sign up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              /*SizedBox(
            height: 150,
          )*/
            ],
          ),
        ),
      ),
      //),
    );
  }
}
