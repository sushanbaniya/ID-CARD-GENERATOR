import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/about.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor: Colors.black,
          child: ListView(children:  [
            SizedBox(height: 100),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  FontAwesomeIcons.addressBook, color: Colors.white,
                ),
              ),
              title: const Text('ID CARD Generator', style: TextStyle(color: Colors.white,)), 
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: FaIcon(
                  FontAwesomeIcons.user, color: Colors.white,
                ),
              ),
              title: const Text('ABOUT', style: TextStyle(color: Colors.white,)),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(About.routeName);
              }
            ),
          ]),
        );
  }
  }
