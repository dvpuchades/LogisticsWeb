import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/services/delivery.dart';
import 'package:webapp/services/geocoding.dart';
import 'package:webapp/utils/data.dart';
import 'package:latlong2/latlong.dart';

class NewDelivery extends StatelessWidget {
  const NewDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: SizedBox(height: 450, width: 700, child: DeliveryForm())));
  }
}

class DeliveryForm extends StatefulWidget {
  const DeliveryForm({Key? key}) : super(key: key);

  @override
  _DeliveryFormState createState() => _DeliveryFormState();
}

class _DeliveryFormState extends State<DeliveryForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController customer = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController amount = TextEditingController();
  String restaurantId = '';

  double amountInDouble = -1;
  LatLng? coordinates;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(children: [
                const Expanded(
                    child: Text('New Delivery', style: SubtitleTextStyle())),
                Expanded(
                    child: TextFormField(
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Address',
                  ),
                )),
                Expanded(
                    child: Row(children: [
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a city';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'City',
                        ),
                      )),
                  const Spacer(),
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: postcode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a postcode';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Postcode',
                        ),
                      ))
                ])),
                Expanded(
                    child: TextFormField(
                  controller: customer,
                  decoration: const InputDecoration(
                    labelText: 'Customer',
                  ),
                )),
                Expanded(
                    child: Row(children: [
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                      )),
                  const Spacer(),
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          RegExp regex = RegExp(r'^[0-9,$]');
                          if (!regex.hasMatch(value)) {
                            return 'Please enter a valid amount';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                        ),
                      ))
                ])),
                Expanded(
                    child: DropdownButtonFormField(
                  items: Data.getRestaurants()
                      .entries
                      .map((e) => DropdownMenuItem(
                          child: Text(e.value.name), value: e.value.id))
                      .toList(),
                  onChanged: (value) {
                    restaurantId = value as String;
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a restaurant';
                    }
                    return null;
                  },
                )),
                Expanded(
                    child: Row(children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ))),
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            child: const Text('Create',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                try {
                                  amountInDouble = double.parse(amount.text);
                                } catch (e) {
                                  amountInDouble = -1;
                                }
                                coordinates = await getCoordinates(
                                    address.text, city.text, postcode.text);

                                if (coordinates == null) {
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) => AlertDialog(
                                            title:
                                                const Text("Address not found"),
                                            content: const Text(
                                                "Would you like to continue without show a marker on this address in the map?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Continue"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  createDeliveryAndGo();
                                                },
                                              )
                                            ],
                                          ));
                                } else {
                                  createDeliveryAndGo();
                                }
                              }
                            },
                          )))
                ])),
              ]))),
    );
  }

  void createDeliveryAndGo() {
    createDelivery(address.text, city.text, postcode.text, phone.text,
            customer.text, amountInDouble, restaurantId, coordinates)
        .then((result) => {
              if (result.isEmpty)
                {Navigator.pop(context)}
              else
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result)),
                  )
                }
            });
  }
}
