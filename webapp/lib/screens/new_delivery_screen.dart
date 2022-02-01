import 'package:flutter/material.dart';
import 'package:webapp/constants.dart';

class NewDelivery extends StatelessWidget {
  const NewDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
                height: 400,
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
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: EdgeInsets.all(20),
          child: Column(children: [
            Expanded(child: Text('New Delivery', style: SubtitleTextStyle())),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            )),
            Expanded(
                child: Row(children: [
              Expanded(
                  flex: 6,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                  )),
              Spacer(),
              Expanded(
                  flex: 6,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Postcode',
                    ),
                  ))
            ])),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                labelText: 'Customer',
              ),
            )),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
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
                        onPressed: () {},
                      )))
            ])),
          ])),
    );
  }
}
