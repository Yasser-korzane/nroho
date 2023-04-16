import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
    color: Colors.grey,
    child: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
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
