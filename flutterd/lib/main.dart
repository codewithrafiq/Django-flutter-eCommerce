import 'package:flutter/material.dart';
import 'package:flutterd/screens/home_Screens.dart';
import 'package:flutterd/screens/product_details_screens.dart';
import 'package:flutterd/state/product_state.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (ctx) => ProductState())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreens(),
        routes: {
          HomeScreens.routeName: (ctx) => HomeScreens(),
          ProductDetailsScreens.routeName: (ctx) => ProductDetailsScreens(),
        },
      ),
    );
  }
}
