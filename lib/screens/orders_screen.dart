import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_flutter/providers/orders.dart' show Orders;
import 'package:shopapp_flutter/widgets/app_drawer.dart';
import 'package:shopapp_flutter/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(
            context,
            listen: false,
          ).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('You have no order'),
                );
              } else {
                return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (ctx, i) => OrderItem(
                            orderData.orders[i],
                          ),
                        ));
              }
            }
          }),
    );
  }
}
