import 'package:covid19/main.dart';
import 'package:covid19/services/covid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Covid covid;

  const Loading(this.covid);

  _getData(BuildContext context) async {
    await covid.getData();

    Navigator.pushReplacementNamed(context, DetailRoute,
        arguments: {'covid': covid});
  }

  @override
  Widget build(BuildContext context) {
    _getData(context);

    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SpinKitDoubleBounce(
        color: Colors.pink,
        size: 100.0,
      ),
    );
  }
}
