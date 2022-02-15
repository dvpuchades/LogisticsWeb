import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webapp/models/delivery.dart';

import '../constants.dart';

class DeliveryCard extends StatefulWidget {
  const DeliveryCard({Key? key, required this.delivery}) : super(key: key);

  final Delivery delivery;

  @override
  _DeliveryCardState createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard> {
  int _minutes = 0;
  String? _state;
  Timer? _timer;
  String? _amount;

  String _getDeliveryState() {
    if (widget.delivery.dealer != '') {
      if (widget.delivery.finishTime != null) return 'Delivered';
      return 'On-its-way';
    }
    return 'In kitchen';
  }

  void _getDeliveryMinutes() {
    if (_state != 'Delivered') {
      _minutes = DateTime.now().difference(widget.delivery.initTime).inMinutes;
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        setState(() {
          _minutes =
              DateTime.now().difference(widget.delivery.initTime).inMinutes;
          //TODO
        });
      });
    } else {
      _minutes = widget.delivery.finishTime!
          .difference(widget.delivery.initTime)
          .inMinutes;
    }
  }

  @override
  Widget build(BuildContext context) {
    _state = _getDeliveryState();
    _getDeliveryMinutes();
    if (widget.delivery.amount == -1) {
      _amount = '';
    } else {
      _amount = widget.delivery.amount.toString() + ' €';
    }
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
                                    widget.delivery.address +
                                        '\n' +
                                        widget.delivery.postcode!,
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
                              child: Text(_state!,
                                  textAlign: TextAlign.left,
                                  style: const NormalTextStyle())),
                          Container(
                              margin: const EdgeInsets.only(right: 30),
                              child: Text(
                                widget.delivery.city,
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
                              child: Text(_minutes.toString() + ' minutes ago',
                                  textAlign: TextAlign.left,
                                  style: const NormalTextStyle())),
                          Container(
                              margin:
                                  const EdgeInsets.only(right: 30, bottom: 15),
                              child: Text(
                                _amount!,
                                textAlign: TextAlign.right,
                                style: const NormalTextStyle(),
                              )),
                        ],
                      ))
                    ]))));
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 30, right: 30),
        child: SizedBox(
            height: 150,
            width: 330,
            child: Container(
                color: ThemeColors.green,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Container(
                            margin: const EdgeInsets.only(top: 10, left: 25),
                            child: const Icon(
                              Icons.mail,
                              size: 30,
                              color: ThemeColors.white,
                            )),
                      ),
                      Flexible(
                          flex: 5,
                          child: Column(children: [
                            Flexible(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, right: 30),
                                    child: Text(
                                      widget.title,
                                      textAlign: TextAlign.right,
                                      style: const NormalTextStyle(),
                                    ))),
                            Flexible(
                                flex: 3,
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    alignment: Alignment.centerRight,
                                    child: Text(widget.body,
                                        textAlign: TextAlign.left,
                                        style: const NormalTextStyle()))),
                          ]))
                    ]))));
  }
}
