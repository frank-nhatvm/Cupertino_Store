import 'package:cupertinostore/model/app_state_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'product_row_item.dart';

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Consumer<AppStateModel>(
        builder: (context, model, child) {
          final products = model.getProduct();
          return CustomScrollView(
            semanticChildCount: products.length,
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: Text('Cupertino Store'),
              ),
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (index < products.length) {
                          return ProductRowItem(index: index,
                            product: products[index],
                            lastItem: index == products.length - 1,);
                        }
                        return null;
                      }
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
