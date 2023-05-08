import 'package:flutter/material.dart';
import 'dart:ui' as ui; 

class confirmation extends StatefulWidget {
  const confirmation({super.key});
  @override
  State<confirmation> createState() => _confirmationState();
}

class _confirmationState extends State<confirmation> {
  final _phoneNumber =
      '00443111111'; //juste un essaie omb3d bdlha 7sab numero de telephone
  final _firstNum = TextEditingController();
  final _secondNum = TextEditingController();
  final _thirdNum = TextEditingController();
  final _fourthNum = TextEditingController();
final heightDevice = ui.window.physicalSize.height;
final widthDevice = ui.window.physicalSize.width;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Verifier mon numéro de téléphone',
            style: TextStyle(
                color: Color.fromARGB(255, 44, 44, 44), fontFamily: 'Poppins'),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 44, 44, 44),
            ),
            onPressed: () {},
          ),
          elevation: 0,
        ),
        body: Column(children: [
          SizedBox(
            height: 60,
          ),
          Center(
            child: Text(
              'Le code a été envoyé' + _phoneNumber,
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'Poppins', fontSize: 20),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: TextField(
                  controller: _firstNum,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: TextField(
                  controller: _secondNum,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: TextField(
                  controller: _thirdNum,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: TextField(
                  controller: _fourthNum,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(15),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Vous n'avez pas reçu le code ?",
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 15, color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Re-envoyer le code',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: GestureDetector(
            onTap: () {},
            child: Text('Recevoire le code de validation via un appel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.black,
                )),
          )),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                String codeNum = _firstNum.toString() +
                    _secondNum.toString() +
                    _thirdNum.toString() +
                    _fourthNum.toString();
                print(codeNum);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                child: Text(
                  'Verifier et créer mon compte',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),
              )),
        ]),
      ),
    ));
  }
}