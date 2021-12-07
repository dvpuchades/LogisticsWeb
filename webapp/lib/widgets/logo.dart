import 'package:flutter/material.dart';

import '../constants.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Fattorino', style: LogoTextStyle());
  }
}
