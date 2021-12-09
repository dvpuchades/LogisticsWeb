import 'package:flutter/material.dart';

import '../constants.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard(
      {Key? key,
      required this.address,
      required this.postcode,
      required this.city,
      required this.state,
      required this.amount,
      required this.minutes})
      : super(key: key);

  final String address;
  final String postcode;
  final String city;
  final String state;
  final double amount;
  final int minutes;

  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 30, right: 30),
        child: SizedBox(
            height: 150,
            width: 330,
            child: Container(
                color: ThemeColors.black,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 50),
                                  child: const Icon(
                                    Icons.fastfood,
                                    size: 30,
                                    color: ThemeColors.white,
                                  )),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 15, right: 30),
                                  child: Text(
                                    widget.address + '\n' + widget.postcode,
                                    textAlign: TextAlign.right,
                                    style: const NormalTextStyle(),
                                  )),
                            ],
                          )),
                      Flexible(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 30),
                              child: Text(widget.state,
                                  textAlign: TextAlign.left,
                                  style: const NormalTextStyle())),
                          Container(
                              margin: const EdgeInsets.only(right: 30),
                              child: Text(
                                widget.city,
                                textAlign: TextAlign.right,
                                style: const NormalTextStyle(),
                              )),
                        ],
                      )),
                      Flexible(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin:
                                  const EdgeInsets.only(left: 30, bottom: 15),
                              child: Text(
                                  widget.minutes.toString() + ' minutes ago',
                                  textAlign: TextAlign.left,
                                  style: const NormalTextStyle())),
                          Container(
                              margin:
                                  const EdgeInsets.only(right: 30, bottom: 15),
                              child: Text(
                                widget.amount.toString() + ' €',
                                textAlign: TextAlign.right,
                                style: const NormalTextStyle(),
                              )),
                        ],
                      ))
                    ]))));
  }
}
