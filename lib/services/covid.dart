import 'package:http/http.dart' as http;
import 'dart:convert';

class Covid {
  String country;
  String name2;
  String name;
  String flag;
  List<Case> cases = [];

  Covid({this.country, this.name, this.name2, this.flag});

  Future<void> getData() async {
    try {
      http.Response confirmedRsp = await http.get(
          'https://api.covid19api.com/total/country/$name/status/confirmed');
      http.Response deathsRsp = await http
          .get('https://api.covid19api.com/total/country/$name/status/deaths');

      http.Response latestRsp = await http
          .get('https://coronavirus-19-api.herokuapp.com/countries/$name2');

      List confirmedList = jsonDecode(confirmedRsp.body);
      List deathsList = jsonDecode(deathsRsp.body);
      Map latestCase = jsonDecode(latestRsp.body);

      _updateCases(confirmedList, deathsList, latestCase);
    } catch (e) {
      print('Code Error $e');
      cases = [];
    }
  }

  void _updateCases(List confirmed, List deaths, Map latestCase) {
    int length = confirmed.length;
    int length2 = deaths.length;

    cases.add(Case(
        date: DateTime.now(),
        confirmed: latestCase['cases'],
        deaths: latestCase['deaths']));

    if (length != length2) {
      print('Confirmed ($length) does NOT equal Deaths ($length2)!');
    }
    for (int i = 0; i < length; i++) {
      if (!(confirmed[i]['Date'] == deaths[i]['Date'])) {
        print('ConfirmedDate does not equal DeathsDate!');
      }
      DateTime date = DateTime.parse(confirmed[i]['Date']);
      cases.add(Case(
          date: date,
          confirmed: confirmed[i]['Cases'],
          deaths: deaths[i]['Cases']));

      cases.sort();
    }

    for (int i = 0; i < cases.length - 1; i++) {
      Case current = cases[i];
      Case previous = cases[i + 1];

      current.newConfirmed = current.confirmed - previous.confirmed;
      current.newDeaths = current.deaths - previous.deaths;
    }
  }
}

class Case implements Comparable {
  DateTime date;
  int confirmed;
  int deaths;
  double mortalityRate;
  int newConfirmed;
  int newDeaths;

  Case({this.confirmed, this.deaths, this.date}) {
    mortalityRate = deaths > 0 ? 1.0 * deaths / confirmed : 0;
  }

  @override
  int compareTo(other) {
    Case other2 = other as Case;
    return other2.date.compareTo(date);
  }
}
