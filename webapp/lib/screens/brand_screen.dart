import 'package:flutter/material.dart';

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
    return Center(
      child: Row(
        children: [
          Container(
              height: 400,
              width: 400,
              child: Card(
                  child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: brandname,
                        obscureText: true,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'password',
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
    );
  }
}
