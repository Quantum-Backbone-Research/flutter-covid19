import 'package:flutter/material.dart';
import 'package:covid19/app_localizations.dart';
import 'package:covid19/services/covid.dart';
import 'package:intl/intl.dart';
import 'package:covid19/style.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    Covid covid = data['covid'];
    DateTime now = DateTime.now();
    String currentTime = DateFormat.jm().format(now);

    return Scaffold(
      backgroundColor: pressed ? Colors.white : Colors.black,
      appBar: AppBar(
          backgroundColor: pressed ? Colors.blue : Colors.blue[900],
          leading: Center(child: Text('$currentTime')),
          title: Text(
            AppLocalizations.of(context).translate(covid.country),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.lightbulb_outline),
                onPressed: () {
                  setState(() {
                    pressed = !pressed;
                  });
                }),
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/location');
                setState(() {
                  data = result;
                });
              },
            )
          ]),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: ListView.builder(
              itemCount: covid.cases.length,
              itemBuilder: (context, index) {
                return CaseCard(
                  item: covid.cases[index],
                  pressed: pressed,
                );
              })),
    );
  }
}

class CaseCard extends StatelessWidget {
  const CaseCard({Key key, @required this.item, this.pressed})
      : super(key: key);

  final Case item;
  final bool pressed;

  static final DateFormat DF = DateFormat('yyyy-MM-dd');
  static final DateFormat DF2 = DateFormat('EEE');

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          textTheme: TextTheme(
        body1: TextStyle(fontSize: 20),
      )),
      child: Card(
        color: pressed ? Colors.amber[50] : Colors.blueGrey[900],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    DF.format(item.date),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pressed ? TextColorDark : TextColorLight),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate(DF2.format(item.date)),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pressed ? TextColorDark : TextColorLight),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context).translate('New Confirmed'),
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  )),
                  Text(
                    '${item.newConfirmed}',
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context).translate('New Deaths'),
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  )),
                  Text('${item.newDeaths}',
                      style: TextStyle(
                          color: pressed ? TextColorDark : TextColorLight)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context).translate('Confirmed'),
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  )),
                  Text(
                    '${item.confirmed}',
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    AppLocalizations.of(context).translate('Deaths'),
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  )),
                  Text(
                    '${item.deaths}',
                    style: TextStyle(
                        color: pressed ? TextColorDark : TextColorLight),
                  ),
                ],
              ),
              item.mortalityRate > 0
                  ? Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)
                                  .translate('Mortality Rate'),
                              style: TextStyle(
                                  color:
                                      pressed ? TextColorDark : TextColorLight),
                            )),
                            Text(
                              '${(100 * item.mortalityRate).toStringAsFixed(2)}%',
                              style: TextStyle(
                                  color:
                                      pressed ? TextColorDark : TextColorLight),
                            ),
                          ],
                        ),
                      ],
                    )
                  : new Container(width: 0, height: 0)
            ],
          ),
        ),
      ),
    );
  }
}
