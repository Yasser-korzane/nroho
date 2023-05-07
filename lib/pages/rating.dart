import 'package:flutter/material.dart';

class Rating extends StatefulWidget {
  const Rating({Key? key}) : super(key: key);

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: ElevatedButton(
              child: Text('Evaluation'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          
                          content: Container(
                            height: 300,
                            child: Column(
                              
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:50.0),
                                    child: Text('Comment trouvez-vous ',style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontSize: 20
                                                            ),),
                                  ),
                                ),
                            Center(
                              child: Text('notre service? ',style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20
                                                      ),),
                            ),
                                SizedBox(height:70),
                                Center(
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: List.generate(5, (index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentRating = index + 1;
                                          });
                                        },
                                        child: Icon(
                                          Icons.star,
                                          color: index < currentRating
                                              ? Colors.yellow
                                              : Colors.grey,
                                              size: 40,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Annuler'),
                              onPressed: () {
                                
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                // Do something with the rating
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
