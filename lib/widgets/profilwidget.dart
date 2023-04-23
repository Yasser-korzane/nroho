import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profilewidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;
  const Profilewidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final double defaultPadding = 10;
    return GestureDetector(
      onTap: (){
        Get.to(transition: Transition.rightToLeftWithFade,() => context);
      },
      child: ListTile(
        onTap: onPress,
        contentPadding: EdgeInsets.only(left: 30.0,right: 30.0),
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.blueGrey.withOpacity(0.1),
          ),
          child:  Icon(icon, color: Colors.blueGrey),
        ),
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: screenHeight*0.018,
              fontFamily: 'Poppins',
              color: textColor,
            ),
            ),
        trailing: endIcon
            ? Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.blueGrey.withOpacity(0.1),
            ),
            child: const Icon(Icons.chevron_right,
                size: 18.0, color: Colors.grey))
            : null,
      ),
    );
  }
}