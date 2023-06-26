import 'package:nroho/AppClasses/Trajet.dart';
import 'package:nroho/Services/base%20de%20donnee.dart';
import 'package:nroho/pages/choisirchauffeur.dart';
import 'package:nroho/pages/page_recherche.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class options extends StatefulWidget {
  Trajet trajetReserve ;
  options(this.trajetReserve);
  @override
  State<options> createState() => _optionsState();
}
class _optionsState extends State<options> {
  List<String> nbPlaces = ['1','2','3','4'];
  String ?selectedNb = '1';
  BaseDeDonnee _baseDeDonnee = BaseDeDonnee();
  TextEditingController _commentcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
    // to get acces to trajetReserve do : widget.trajetReserve
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Color(0xff344D59))
        ),
        title: Text('Plus d’informations',
            style: TextStyle(color: Color(0xff344D59),fontFamily: 'Poppins',)),        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(screenWidth*0.03, 0, 10, screenWidth*0.03),
        child: ListView(
          children:[ Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Acceptez-vous un conducteur qui fume ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.0135,
                          fontFamily: 'Poppins',
                        ),),
                      //SizedBox(width: screenWidth*0.35,),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.fumeur,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.fumeur = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avez vous un bagage volumineux ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.016,
                          fontFamily: 'Poppins',
                        ),),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.bagage,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.bagage = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.002),
              Card(color: Colors.white60,margin: EdgeInsets.all(16),
                shape:   RoundedRectangleBorder(
                  side:  BorderSide(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(15)
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Avez vous  des animaux ?',
                        style: TextStyle(
                          fontSize: screenHeight*0.017,
                          fontFamily: 'Poppins',
                        ),),
                      Checkbox(
                        value: widget.trajetReserve.plusInformations.animaux,
                        onChanged: (value) {
                          setState(() {
                            widget.trajetReserve.plusInformations.animaux = value ?? false; // Update 'yes' with the selected value or false if value is null
                          });
                        },
                        activeColor: Colors.blue, // Optional: change the color of the checkbox when selected
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child:
                  Column(
                    children: [
                      Align(alignment: Alignment.centerLeft,child: Text('Avec combien de personnes partez-vous ? ',style: TextStyle(fontWeight: FontWeight.bold),)),
                      SizedBox(height: 4,),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                        ),
                        value: selectedNb,
                        items: nbPlaces
                            .map(
                              (item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (item) {
                          setState(() {
                            selectedNb = item;
                            widget.trajetReserve.plusInformations.nbPlaces = int.parse(item!);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(screenHeight * 0.01, 0, screenHeight * 0.01, 0),
                padding: EdgeInsets.fromLTRB(screenHeight * 0.015, 0, screenHeight * 0.01, 0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _commentcontroller,
                    keyboardType: TextInputType.text,
                    validator: (input) {
                      RegExp regExp = RegExp(r'^[a-zA-Z0-9_]+$');
                      if (input == null || !regExp.hasMatch(input)){
                        return 'La Commentaire est non valide' ;
                      }
                      return null;
                    },
                       style: TextStyle(
                         fontWeight: FontWeight.normal,
                         fontSize: screenHeight*0.02,
                         fontFamily: 'Poppins',
                       ),
                        decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        labelText: 'Laisser un commentaire',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        suffixIcon: Icon(Icons.insert_comment_rounded,
                            color: Colors.black)
                        ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.094),

            ],
          ),
      ]
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.51,
          height: size.height * 0.048,
          child: ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()){
                widget.trajetReserve.avis = _commentcontroller.text;
                Navigator.push(context,
                    MaterialPageRoute(builder:(context)=> Page_recherche()));
                List<ConducteurTrajet> monListe = [];
                final stopwatch = Stopwatch()..start();
                Duration duration = Duration(seconds: 10);
                while (stopwatch.elapsed < duration ) {
                  monListe = await _baseDeDonnee.chercherConductuersPossibles(FirebaseAuth.instance.currentUser!.uid, widget.trajetReserve);
                }
                stopwatch.stop();
                if(monListe.isEmpty){
                  showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                          content: Text("Il n'y a pas de chauffeurs disponibles pour le moment, essayez ultérieurment"),
                          actions: <Widget>[
                            TextButton(
                                onPressed:(){
                                  Navigator.pop(context);
                                },
                                child: Text("ok"))
                          ],
                        );
                      }
                  );
                  //Navigator.pop(context);
                  Navigator.pop(context);
                }else{
                  String idTrajetReserve = await _baseDeDonnee.saveTrajetReserveAsSubcollection(FirebaseAuth.instance.currentUser!.uid, widget.trajetReserve);
                  widget.trajetReserve.id = idTrajetReserve;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DriverListPage(monListe,widget.trajetReserve)));
                }
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
