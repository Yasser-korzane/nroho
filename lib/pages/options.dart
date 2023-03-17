import 'package:flutter/material.dart';
import 'package:appcouvoiturage/widgets/customdropdown.dart';
import 'package:appcouvoiturage/widgets/selectabletext.dart';

class options extends StatefulWidget {
  const options({Key? key}) : super(key: key);

  @override
  State<options> createState() => _optionsState();
}

class _optionsState extends State<options> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pop(context)
            },
            icon: const Icon(Icons.chevron_left, color: Colors.black)),
        title: Text('Plus d’informations',
            style: Theme.of(context).textTheme.headline6),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100.0),
            SelectableTextWidget(
                text: 'Acceptez-vous un conducteur qui fume ?           '),
            SizedBox(height: 20.0),
            SelectableTextWidget(
                text:
                'Avez vous un bagage volumineux ?                    '),
            SizedBox(height: 20.0),
            SelectableTextWidget(
                text:
                'Avez vous  des animaux ?                                    '),
            SizedBox(height: 20.0),
            CustomDropdown(options: [1,2,3,4]),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade300,
                  labelText: 'Laisser un commentaire',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  // i can you only a icon (not prefixeIcon) to show the icons out of the Textfield
                  suffixIcon:
                  Icon(Icons.insert_comment_rounded, color: Colors.black)),
            ),
            SizedBox(height: 220.0),
            SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Valider',
                      style: TextStyle(color: Colors.white)),
                )
            ),
          ],
        ),
      ),
    );
  }
}

