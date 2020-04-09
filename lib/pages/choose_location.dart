import 'package:covid19/services/summary.dart';
import 'package:flutter/material.dart';
import 'package:covid19/app_localizations.dart';
import 'package:covid19/services/covid.dart';
import 'package:covid19/main.dart';

class ChooseLocation extends StatefulWidget {
  final Summary summary;

  const ChooseLocation(this.summary);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  @override
  Widget build(BuildContext context) {
    List<Covid> countries = widget.summary.getAllCovids();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: Text(
            AppLocalizations.of(context).translate('Choose A Country/Region')),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          return CountryCard(covid: countries[index]);
        },
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final Covid covid;

  CountryCard({this.covid});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async {
          await covid.getData();
          Navigator.pushNamed(context, DetailRoute,
              arguments: {'covid': covid});
        },
        title: Text(AppLocalizations.of(context).translate(covid.country)),
        trailing: Image(
          image: AssetImage('assets/images/${covid.flag}.png'),
        ),
      ),
    );
  }
}
