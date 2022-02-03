import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';
import 'package:webapp/models/restaurant.dart';
import 'package:webapp/services/delivery.dart';
import 'package:webapp/services/restaurant.dart';

class NewDelivery extends StatelessWidget {
  const NewDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
                height: 450,
                width: 700,
                child: Container(child: DeliveryForm()))));
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(children: [
                Expanded(
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
                  decoration: InputDecoration(
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
                        decoration: InputDecoration(
                          labelText: 'City',
                        ),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: postcode,
                        decoration: InputDecoration(
                          labelText: 'Postcode',
                        ),
                      ))
                ])),
                Expanded(
                    child: TextFormField(
                  controller: customer,
                  decoration: InputDecoration(
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
                        decoration: InputDecoration(
                          labelText: 'Phone',
                        ),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: amount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                        ),
                      ))
                ])),
                Expanded(
                    child: DropdownButtonFormField(
                  items: RestaurantBuffer.getInstance()
                      .all
                      .map((restaurant) => DropdownMenuItem(
                          child: Text(restaurant.name), value: restaurant.id))
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
                            child: Text('Cancel',
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
                            child: Text('Create',
                                style: TextStyle(color: Colors.white)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                                createDelivery(
                                        address.text,
                                        city.text,
                                        postcode.text,
                                        phone.text,
                                        customer.text,
                                        double.parse(amount.text),
                                        restaurantId)
                                    .then((result) => {
                                          if (result.isEmpty)
                                            {Navigator.pop(context)}
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(content: Text(result)),
                                              )
                                            }
                                        });
                              }
                            },
                          )))
                ])),
              ]))),
    );
  }
}
