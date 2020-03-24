import 'dart:collection';

import 'package:flutter/material.dart';
import './providers/great_places.dart';
import './Screens/splash_screen.dart';
import './providers/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './Screens/user_posts_screen.dart';
import './Screens/posts_overview_screen.dart';
import './Screens/post_details_screen.dart';
import './providers/posts.dart';
import './providers/auth.dart';
import 'package:provider/provider.dart';
import './Screens/edit_post_screen.dart';
import './FORM_INPUTS/location.dart';
import './Screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
            value: GreatPlaces(),
          ),
          ChangeNotifierProxyProvider<Auth, Posts>(
            update: (ctx, auth, previousProducts) => Posts(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Lost Of People',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                accentColor: Colors.blueAccent,
                fontFamily: 'lato',
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                })),
            home: auth.isAuth
                ? PersonOverViewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              PersonDetailsScreen.routeName: (ctx) => PersonDetailsScreen(),
              UserPersonScreen.routeName: (ctx) => UserPersonScreen(),
              EditPersonScreen.routeName: (ctx) => EditPersonScreen(),
            },
          ),
        ));
  }
}
