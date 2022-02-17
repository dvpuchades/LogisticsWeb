import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:webapp/services/geocoding.dart';
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
  TextEditingController restaurantCity = TextEditingController();
  TextEditingController restaurantPostcode = TextEditingController();

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
                  child: Row(children: [
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: restaurantCity,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.location_city),
                                labelText: 'city',
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a restaurant city';
                                }
                                return null;
                              },
                            ))),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: TextFormField(
                              controller: restaurantPostcode,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.location_pin),
                                labelText: 'postcode',
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a restaurant postcode';
                                }
                                return null;
                              },
                            ))),
                  ]),
                ),
                Container(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          LatLng? coordinates = await getCoordinates(
                              restaurantAddress.text,
                              restaurantCity.text,
                              restaurantPostcode.text);
                          if (coordinates == null) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Address not found'),
                                    content: const Text(
                                        'Could not find the location of the restaurant'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Ok'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          } else {
                            createRestaurant(
                                    restaurant.text,
                                    restaurantAddress.text,
                                    restaurantCity.text,
                                    restaurantPostcode.text,
                                    coordinates)
                                .then((status) => {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(status))),
                                      if (status ==
                                          'Restaurant created successfully')
                                        {Navigator.pop(context)}
                                    });
                          }
                        }
                      },
                      child: const Text('Create'),
                    )),
              ],
            ))));
  }
}
