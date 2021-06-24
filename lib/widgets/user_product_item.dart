import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_flutter/providers/products.dart';
import 'package:shopapp_flutter/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        //handle sizing , content image untuk fit
        backgroundImage:
            NetworkImage(imageUrl), // NetworkImage -> ImageProvider
      ),
      trailing: Container(
        width: 100,
        child: (Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Theme.of(context).primaryColor),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                      content: Text(
                          'Cannot delete the product. Something went wrong!')));
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        )),
      ),
    );
  }
}
