import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/drawer.dart';

class About extends StatelessWidget {
  static const routeName = '/about';
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'This App is created by SUSHAN BANIYA.',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              
            ),
            SizedBox(height: 20),
            FaIcon(FontAwesomeIcons.user, color: Colors.white,)
          ],
        ));
  }
}
