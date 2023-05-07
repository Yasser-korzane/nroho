import 'package:flutter/material.dart';
class TrajetLanceEstSauvegarder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Votre trajet a bien été sauvegardé',
              style: TextStyle(fontFamily: 'Poppins',fontSize: 18,fontWeight: FontWeight.bold , color: Colors.black54),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                'D\'accord',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
