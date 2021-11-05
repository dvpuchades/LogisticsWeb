import 'package:flutter/material.dart';

import '../textstyle.dart';

class BrandMenu extends StatefulWidget {
  const BrandMenu({Key? key}) : super(key: key);

  @override
  _BrandMenuState createState() => _BrandMenuState();
}

class _BrandMenuState extends State<BrandMenu> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController brandname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 400,
              width: 400,
              child: Card(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: const Text('Create a new brand',
                          style: SubtitleTextStyle())),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: brandname,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.shop),
                          labelText: 'brand name',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a brand name';
                          }
                          return null;
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: brandname,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.restaurant),
                          labelText: 'restaurant name',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a brand name';
                          }
                          return null;
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: brandname,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.location_city),
                          labelText: 'restaurant address',
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a brand name';
                          }
                          return null;
                        },
                      )),
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            //TODO write service
                          }
                        },
                        child: const Text('Submit'),
                      )),
                ],
              ))),
          Container()
        ],
      ),
    ));
  }
}
