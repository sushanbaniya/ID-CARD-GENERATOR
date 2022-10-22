import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './screens/about.dart';
import './widgets/drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), routes: {
      About.routeName: (ctx) => About(),
    });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _name = '';
  var _subject = '';
  var _year = '';
  var _imageUrl = '';
  final _imageController = TextEditingController();
  final _imageFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _imageFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageController.dispose();
    _imageFocus.dispose();
    _imageFocus.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('ID CARD Generator'),
        backgroundColor: Colors.black,
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Container(
          height: 270,
          width: 450,
          decoration: BoxDecoration(
            border: Border.all(
              width: 3,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    'ACADEMIA INTERNATIONAL COLLEGE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  FaIcon(FontAwesomeIcons.buildingColumns),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NAME: $_name',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text('SUBJECT: $_subject',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                      Text('YEAR: $_year',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: _imageUrl.isEmpty
                          ? Text('')
                          : FittedBox(
                              child: Image.network(
                                _imageUrl,
                                fit: BoxFit.cover,
                              ),
                            )),
                ],
              ),
              SizedBox(height: 20),
              Text('This card must be brought regularly.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
          onPressed: () {
            showModalBottomSheet<dynamic>(
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.80,
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Name'),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              setState(() {
                                _name = value.toString().toUpperCase();
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Name';
                              }
                              return null;
                            }),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Subject'),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              setState(() {
                                _subject = value.toString().toUpperCase();
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Subject';
                              }
                              return null;
                            }),
                        TextFormField(
                            decoration: InputDecoration(labelText: 'Year'),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              setState(() {
                                _year = value.toString().toUpperCase();
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Year';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Enter Number';
                              }
                              if (double.parse(value) < 1 ||
                                  double.parse(value) > 4) {
                                return 'Should be more than one and less than four';
                              }
                              return null;
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                ),
                                margin: EdgeInsets.only(top: 10, right: 10),
                                child: _imageController.text.isEmpty
                                    ? Center(child: Text('Enter URl'))
                                    : FittedBox(
                                        child: Image.network(
                                        _imageController.text,
                                        fit: BoxFit.cover,
                                      ))),
                            Expanded(
                              child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Image URL'),
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  controller: _imageController,
                                  focusNode: _imageFocus,
                                  onSaved: (value) {
                                    setState(() {
                                      _imageUrl = value.toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Url';
                                    }
                                    if (!value.startsWith('http') &&
                                        !value.startsWith('https')) {
                                      return 'Enter Valid Url';
                                    }
                                    return null;
                                  }),
                            ),
                          ],
                        ),
                        ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.black) ,
                            child: Text('Generate ID'),
                            
                            onPressed: () {
                              _saveForm();
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.pen,
            color: Colors.black,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
