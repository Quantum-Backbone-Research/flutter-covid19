import 'package:covid19/services/covid.dart';
import 'package:covid19/services/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:covid19/app_localizations.dart';
import 'package:covid19/pages/initial_loading.dart';
import 'package:covid19/pages/loading.dart';
import 'package:covid19/pages/choose_location.dart';
import 'package:covid19/pages/country_detail.dart';

const InitialRoute = '/';
const LoadingRoute = '/loading';
const ChooseLocationRoute = '/list';
const DetailRoute = '/detail';

void main() {
  var localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    supportedLocales: [Locale('en', 'US'), Locale('zh', 'CN')],
    localizationsDelegates: localizationsDelegates,
    localeResolutionCallback: localeCB,
    onGenerateRoute: _routes(),
    initialRoute: '/',
  ));
}

Locale localeCB(locale, supportedLocales) {
  for (var supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode &&
        supportedLocale.countryCode == locale.countryCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

RouteFactory _routes() {
  return (settings) {
    final Map<String, dynamic> arguments = settings.arguments;
    Widget screen;
    switch (settings.name) {
      case InitialRoute:
        screen = InitialLoading();
        break;
      case LoadingRoute:
        Covid covid = arguments['covid'];
        screen = Loading(covid);
        break;
      case ChooseLocationRoute:
        Summary summary = arguments['summary'];
        screen = ChooseLocation(summary);
        break;
      case DetailRoute:
        Covid covid = arguments['covid'];
        screen = CountryDetail(covid);
        break;
      default:
        return null;
    }
    return MaterialPageRoute(builder: (BuildContext context) => screen);
  };
}
