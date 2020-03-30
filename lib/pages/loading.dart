import 'package:flutter/material.dart';
import 'package:covid19/services/covid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void updateData() async {
    Covid instance = Covid(country: 'China', name: 'china', name2: 'china');
    await instance.getData();
    Navigator.pushReplacementNamed(context, '/home',
        arguments: {'covid': instance});
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SpinKitSquareCircle(
        color: Colors.amber,
        size: 50.0,
      ),
    );
  }
}
