import 'package:appcouvoiturage/pages/profilmodification.dart';
import 'package:appcouvoiturage/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:appcouvoiturage/pages/login.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left, color: Colors.black)),
          title: Center(
              child: Text('Profile',
                  style: Theme.of(context).textTheme.headline4)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80')))),
                  ],
                ),
                const SizedBox(height: 10),
                Text('data', style: Theme.of(context).textTheme.headline4),
                const RatingWidget(color: Colors.yellow,rating: 3.5,size: 20.0),
                Text('mohammedgrine@weal.harach',
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 20),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ModifierProfilePage(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      child: const Text('Modifier Profile',
                          style: TextStyle(color: Colors.white)),
                    )),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                //  Menu
                Profilewidget(
                  title: 'Mes Courses',
                  icon: Icons.navigation_rounded,
                  onPress: () {},
                ),
                Profilewidget(
                  title: 'Guide',
                  icon: Icons.my_library_books,
                  onPress: () {},
                ),
                Profilewidget(
                  title: 'Contactez nous',
                  icon: Icons.call,
                  onPress: () {},
                ),
                Profilewidget(
                  title: 'Avis',
                  icon: Icons.comment,
                  onPress: () {},
                ),
                Profilewidget(
                  title: 'Deconnexion',
                  icon: Icons.logout,
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: 'begin')));
                  },
                  endIcon: false,
                  textColor: Colors.redAccent,
                ),
              ],
            ),
          ),
        ));
  }
}

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
    return ListTile(
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
          style:
          Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
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
    );
  }
}



class RatingWidget extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;

  const RatingWidget({super.key, this.rating = 0.0, this.color = Colors.amber, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
            (index) => Icon(
          index < rating.floor() ? Icons.star : Icons.star_border,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
