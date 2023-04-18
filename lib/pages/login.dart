import 'package:appcouvoiturage/pages/connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBeginPage extends StatefulWidget {
  final String title;

  const MyBeginPage({super.key, required this.title});


  @override
  State<MyBeginPage> createState() => _MyBeginPageState();
}

class _MyBeginPageState extends State<MyBeginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(''),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ellipse.png'),
                  fit: BoxFit.fill)),
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 300.0,
                width: 350.0,
                padding: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                ),
                child: Center(
                  child: Image.asset(
                      'assets/images/commencer.png'),
                ),
              ),
              Container(
                child: Center(
                    child: Text('NRO7O',
                        style: TextStyle(
                          color: Color.fromARGB(255, 6, 41, 69),
                          fontSize: 50,
                        ))),
              ),
              Container(
                child: Center(
                    child: Text('Gagner du temps et preserver votre argent ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ))),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue),
                /* child: TextButton(onPressed: (){},
             child: Text('commencer',style: TextStyle(fontSize: 18,color: Colors.white),),

             ),*/
                child: Padding(
                  padding: EdgeInsets.all(2),

                  //  child: Text('Create Account ',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: GestureDetector(
                      onTap: (){
                        Get.to( ()=> Connexin(title: 'sin up'),transition: Transition.zoom);
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Connexin(title: 'sin up'),));
                        },
                        child: const Text('commencer ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                backgroundColor: Colors.blue)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
      //),
    );
  }
}
