import 'package:http/http.dart' as http;
import 'dart:convert';
import 'covid.dart';

class Summary {
  List<Covid> getAllCovids() {
    return countries;
  }

  Future<void> updateSummary() async {
    http.Response totalRsp =
        await http.get('https://coronavirus-19-api.herokuapp.com/countries');
    List<dynamic> ccs = jsonDecode(totalRsp.body);

    for (Covid covid in countries) {
      _updateCurrentData(covid, ccs);
    }

    countries.forEach((e) {
      if (e.currentConfirmed == null) print(e.country);
    });

    countries.sort();
  }

  void _updateCurrentData(Covid covid, List<dynamic> summary) {
    for (dynamic data2 in summary) {
      Map data = data2 as Map;

      if (covid.name2 == data['country'].toLowerCase()) {
        covid.currentConfirmed = data['cases'];
        covid.currentDeaths = data['deaths'];
        return;
      }
    }
  }

  final List<Covid> countries = [
    Covid(country: 'China', name: 'china', name2: 'china', flag: 'CN'),
    Covid(country: 'Canada', name: 'canada', name2: 'canada', flag: 'CA'),
    Covid(country: 'United States', name: 'us', name2: 'usa', flag: 'US'),
    Covid(country: 'Italy', name: 'italy', name2: 'italy', flag: 'IT'),
    Covid(country: 'Spain', name: 'spain', name2: 'spain', flag: 'ES'),
    Covid(country: 'France', name: 'france', name2: 'france', flag: 'FR'),
    Covid(country: 'Germany', name: 'germany', name2: 'germany', flag: 'DE'),
    Covid(country: 'Portugal', name: 'portugal', name2: 'portugal', flag: 'PT'),
    Covid(
        country: 'United Kingdom',
        name: 'united-kingdom',
        name2: 'uk',
        flag: 'GB'),
    Covid(country: 'Ireland', name: 'ireland', name2: 'ireland', flag: 'IE'),
    Covid(country: 'Norway', name: 'norway', name2: 'norway', flag: 'NO'),
    Covid(country: 'Denmark', name: 'denmark', name2: 'denmark', flag: 'DK'),
    Covid(country: 'Sweden', name: 'sweden', name2: 'sweden', flag: 'SE'),
    Covid(country: 'Finland', name: 'finland', name2: 'finland', flag: 'FI'),
    Covid(country: 'Russia', name: 'russia', name2: 'russia', flag: 'RU'),
    Covid(country: 'Austria', name: 'austria', name2: 'austria', flag: 'AT'),
    Covid(
        country: 'Switzerland',
        name: 'switzerland',
        name2: 'switzerland',
        flag: 'CH'),
    Covid(country: 'Serbia', name: 'serbia', name2: 'serbia', flag: 'RS'),
    Covid(country: 'Greece', name: 'greece', name2: 'greece', flag: 'GR'),
    Covid(country: 'Japan', name: 'japan', name2: 'japan', flag: 'JP'),
    Covid(
        country: 'South Korea',
        name: 'korea-south',
        name2: 's. korea',
        flag: 'KR'),
    Covid(
        country: 'Singapore',
        name: 'singapore',
        name2: 'singapore',
        flag: 'SG'),
    Covid(country: 'India', name: 'india', name2: 'india', flag: 'IN'),
    Covid(country: 'Pakistan', name: 'pakistan', name2: 'pakistan', flag: 'PK'),
    Covid(country: 'Iran', name: 'iran', name2: 'iran', flag: 'IR'),
    Covid(country: 'Iraq', name: 'iraq', name2: 'iraq', flag: 'IQ'),
    Covid(country: 'Israel', name: 'israel', name2: 'israel', flag: 'IL'),
    Covid(country: 'Turkey', name: 'turkey', name2: 'turkey', flag: 'TR'),
    Covid(
        country: 'Saudi Arabia',
        name: 'saudi-arabia',
        name2: 'saudi arabia',
        flag: 'SA'),
    Covid(country: 'Egypt', name: 'egypt', name2: 'egypt', flag: 'EG'),
    Covid(country: 'Ethiopia', name: 'ethiopia', name2: 'ethiopia', flag: 'ET'),
    Covid(country: 'Kenya', name: 'kenya', name2: 'kenya', flag: 'KE'),
    Covid(
        country: 'South Africa',
        name: 'south-africa',
        name2: 'south africa',
        flag: 'ZA'),
    Covid(
        country: 'Australia',
        name: 'australia',
        name2: 'australia',
        flag: 'AU'),
    Covid(
        country: 'New Zealand',
        name: 'new-zealand',
        name2: 'new zealand',
        flag: 'NZ'),
    Covid(country: 'Mexico', name: 'mexico', name2: 'mexico', flag: 'MX'),
    Covid(country: 'Brazil', name: 'brazil', name2: 'brazil', flag: 'BR'),
    Covid(
        country: 'Argentina',
        name: 'argentina',
        name2: 'argentina',
        flag: 'AR'),
    Covid(country: 'Peru', name: 'peru', name2: 'peru', flag: 'PE'),
    Covid(country: 'Chile', name: 'chile', name2: 'chile', flag: 'CL'),
  ];
}
