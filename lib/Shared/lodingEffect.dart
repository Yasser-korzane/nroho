import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.brown,
    child: Center(
          child: SpinKitFadingCircle(
            itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
                    decoration: BoxDecoration(
                    color: index.isEven ? Colors.red : Colors.green,
                    ),
                    );
            },
          )
    )
  );
  }
}
