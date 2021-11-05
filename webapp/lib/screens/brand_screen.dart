import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:webapp/services/brand.dart';

import '../style.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SizedBox(
                  width: 600,
                  height: 100,
                  child: TypeAheadField(
                    textFieldConfiguration: const TextFieldConfiguration(
                        autofocus: true,
                        style: TextStyle(color: Colors.green),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true)),
                    suggestionsCallback: (pattern) async {
                      return await getBrandSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                          leading: const Icon(Icons.search),
                          title: Text(suggestion as String));
                    },
                    onSuggestionSelected: (suggestion) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    },
                    errorBuilder: (context, error) {
                      return const ListTile(
                          leading: Icon(Icons.error),
                          title: Text('No brand suggested'));
                    },
                  ))),
          SizedBox(
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
