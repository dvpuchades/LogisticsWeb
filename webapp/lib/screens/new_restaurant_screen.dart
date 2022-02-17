import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:webapp/services/restaurant.dart';

import '../constants.dart';

class NewRestaurantScreen extends StatelessWidget {
  const NewRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CreateRestaurantWidget()));
  }
}

class CreateRestaurantWidget extends StatefulWidget {
  const CreateRestaurantWidget({Key? key}) : super(key: key);

  @override
  _CreateRestaurantWidgetState createState() => _CreateRestaurantWidgetState();
}

class _CreateRestaurantWidgetState extends State<CreateRestaurantWidget> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController restaurant = TextEditingController();
  TextEditingController restaurantAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SizedBox(
            height: 400,
            width: 400,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text('Create a new restaurant',
                        style: SubtitleTextStyle())),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: restaurant,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.restaurant),
                        labelText: 'restaurant name',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a restaurant name';
                        }
                        return null;
                      },
                    )),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      controller: restaurantAddress,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: 'restaurant address',
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a restaurant address';
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

                          createRestaurant(
                                  restaurant.text,
                                  restaurantAddress.text,
                                  'ewf',
                                  'bcewf',
                                  LatLng(0, 0))
                              .then((status) => {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(status))),
                                    if (status ==
                                        'Restaurant created successfully')
                                      {Navigator.pop(context)}
                                  });
                        }
                      },
                      child: const Text('Create'),
                    )),
              ],
            ))));
  }
}
