import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_flutter/providers/auth.dart';
import 'package:shopapp_flutter/providers/cart.dart';
import 'package:shopapp_flutter/providers/orders.dart';
import 'package:shopapp_flutter/screens/cart_screen.dart';
import 'package:shopapp_flutter/screens/edit_product_screen.dart';
import 'package:shopapp_flutter/screens/product_detail_screen.dart';
import 'package:shopapp_flutter/screens/products_overview_screen.dart';
import 'package:shopapp_flutter/screens/orders_screen.dart';
import 'package:shopapp_flutter/providers/products.dart';
import 'package:shopapp_flutter/screens/splash_screen.dart';
import 'package:shopapp_flutter/screens/user_products_screen.dart';
import 'package:shopapp_flutter/screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.token,
                auth.userId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          // ignore: missing_required_param
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders),
                
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shop App',
              theme: ThemeData(
                primarySwatch: Colors.amber,
                accentColor: Colors.grey[350],
                fontFamily: 'Lato',
              ),
              home: auth.isAuth
                  ? ProductsOverviewScreen()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) =>
                          authResultSnapshot.connectionState ==
                                  ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen()),
              routes: {
                ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
                CartScreen.routeName: (ctx) => CartScreen(),
                OrdersScreen.routeName: (ctx) => OrdersScreen(),
                UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
                EditProductScreen.routeName: (ctx) => EditProductScreen(),
              }),
        ));
  }
}
