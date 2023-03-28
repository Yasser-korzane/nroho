import 'package:flutter/material.dart';
import 'package:appcouvoiturage/main.dart';
class MyBeginPag extends StatefulWidget {
  const MyBeginPag({super.key, required this.title});

  final String title;

  @override
  State<MyBeginPag> createState() => _MyBeginPagState();
}

class _MyBeginPagState extends State<MyBeginPag> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,


        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //padding :,
        backgroundColor: Colors.white,
        /* title: Container(
          height: 180 ,
          padding: EdgeInsets.zero,
          child: Image.asset('asset/images/Ellipse 5.png',height: 100,width: 600,),
        )*/
        // title: Text(widget.title),
        title: Text(''),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse 5.png'),
                  fit: BoxFit.fill
              )
          ),
        ),
// width: MediaQuery.of(context).size.width,
//   height: 100,
//   decoration: BoxDecoration(
//     image: DecorationImage(q
//       fit: BoxFit.fill,
//       image: AssetImage("asset/images/Ellipse 5.png"),
//     ),
//   ),
// )
      ),

      body: Center(


        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  child: Image.asset('assets/images/Commencer-removebg-preview.png'),
                ),
              ),
              Container(
                child: Center(
                    child: Text('NRO7O',style: TextStyle(color: Color.fromARGB(255, 6, 41, 69), fontSize: 50,))
                ),
              ),
              Container(
                child: Center(
                    child: Text('Gagner du temps et preserver votre argent ',style: TextStyle(color: Colors.black, fontSize: 20,))
                ),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                    color: Colors.lightBlue ),
                /* child: TextButton(onPressed: (){},
             child: Text('commencer',style: TextStyle(fontSize: 18,color: Colors.white),),

             ),*/
                child : Padding(
                  padding: EdgeInsets.all(2),

                  //  child: Text('Create Account ',style: TextStyle(color: Color.fromARGB(255, 37, 15, 161), fontSize: 15)),
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(

                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(builder: (context) => const Connexin(title: " sing up ",)),
                        );
                        // Navigate back to first route when tapped.
                      },
                      child: const Text('commencer ',style: TextStyle(color: Colors.white, fontSize: 25,backgroundColor: Colors.blue)),
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
