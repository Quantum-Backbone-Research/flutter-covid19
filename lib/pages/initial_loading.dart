import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:covid19/services/summary.dart';

import '../main.dart';

class InitialLoading extends StatelessWidget {
  void _updateCountries(BuildContext context) async {
    Summary summary = Summary();
    await summary.updateSummary();

    Navigator.pushReplacementNamed(context, ChooseLocationRoute,
        arguments: {'summary': summary});
  }

  @override
  Widget build(BuildContext context) {
    _updateCountries(context);

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SpinKitSquareCircle(
        color: Colors.amber,
        size: 50.0,
      ),
    );
  }
}
