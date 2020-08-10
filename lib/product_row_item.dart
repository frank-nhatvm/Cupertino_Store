import 'package:cupertinostore/model/app_state_model.dart';
import 'package:cupertinostore/model/product.dart';
import 'package:cupertinostore/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProductRowItem extends StatelessWidget {
  final Product product;
  final int index;
  final bool lastItem;

  const ProductRowItem({this.product, this.index, this.lastItem});

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(left: 16, top: 8, right: 8, bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              product.assetName,
              package: product.assetPackage,
              fit: BoxFit.cover,
              width: 76,
              height: 76,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: Styles.productRowItemName,),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text('\$${product.price}', style: Styles.productRowTotal,)
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: (){
              final model = Provider.of<AppStateModel>(context,listen: false);
              model.addProductToCart(product.id);
            },
            child: const Icon(CupertinoIcons.plus_circled, semanticLabel: 'Add',),
          ),
        ],
      ),
    );
    if (lastItem) {
      return row;
    }

    return Column(
      children: [
        row,
        Padding(
          padding: const EdgeInsets.only(left: 100,right: 16),
          child: Container(height: 1,color: Styles.productRowDivider,),
        ),

      ],
    );
  }
}
