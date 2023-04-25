import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.white,
    child: Center(
          child: SpinKitThreeBounce(
            color: Colors.blue,
           size: 50.0,
           /* itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
                    decoration: BoxDecoration(
                    color: index.isEven ? Colors.white : Colors.white,
                    ),
                    );
            },*/
          )
    )
  );
  }
}


