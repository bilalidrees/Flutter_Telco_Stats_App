import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zong_islamic_web_app/local_notification.dart';
import 'package:zong_islamic_web_app/route_generator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:zong_islamic_web_app/src/geo_location/geo_location.dart';
import 'package:zong_islamic_web_app/src/resource/repository/location_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_theme.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_utility.dart';
import 'package:zong_islamic_web_app/src/shared_prefs/stored_auth_status.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/namaz_provider/namaz_provider.dart';

import 'app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [



        ChangeNotifierProvider<AppUtility>(create: (context)=>AppUtility()),


        // ChangeNotifierProvider<CalenderProvider>(
        //     create: (context) => CalenderProvider()),

        FutureProvider<SharedPreferences?>(
            lazy: false,
            create: (context) => SharedPreferences.getInstance(),
            initialData: null),
        ProxyProvider<SharedPreferences?,NamazData>(
          update: (context,prefs,namaz)=>NamazData(prefs),
        ),
        Provider<LocationRepository>(create: (context) => LocationRepository()),
        ChangeNotifierProxyProvider<LocationRepository, GeoLocationProvider>(
            lazy: false,
            create: (context) =>
                GeoLocationProvider(context.read<LocationRepository>()),
            update: (context, geoAccess, geoPro) =>
                GeoLocationProvider(geoAccess)),
        ChangeNotifierProxyProvider<SharedPreferences?, StoredAuthStatus>(
          create: (context) =>
              StoredAuthStatus(context.read<SharedPreferences?>()),
          update: (context, pref, auth) => StoredAuthStatus(pref),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.zongTheme,
        debugShowCheckedModeBanner: false,
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: const [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        locale: const Locale.fromSubtags(countryCode: 'US', languageCode: 'en'),
        initialRoute: RouteString.initial,
        //home: LocalNotification(),
        onGenerateRoute: RouteGenerator.generateRoute,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ur', 'PK'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        navigatorObservers: [
          RouteObservers.routeObserver,
        ],
      ),
    );
  }
}

class CalenderProvider {
}

class RouteObservers {
  static RouteObserver<void> routeObserver = RouteObserver<PageRoute>();
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  const RouteAwareWidget(this.name, {required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    print(widget.name);
    super.didChangeDependencies();
    RouteObservers.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    RouteObservers.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {}

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {}

  @override
  Widget build(BuildContext context) => widget.child;
}
