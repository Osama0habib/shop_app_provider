import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/product_provider.dart';
import 'grid_item.dart';

class ProductGridView extends StatefulWidget {
  const ProductGridView({Key? key,required this.isFavorite}) : super(key: key);

 final bool isFavorite ;

  @override
  State<ProductGridView> createState() => _ProductGridViewState();
}


class _ProductGridViewState extends State<ProductGridView> {
  late bool isInit;

  @override
  Widget build(BuildContext context) {
    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: true);
    List<ProductModel> product = widget.isFavorite == true? provider.getFavList : provider.product;
    return GridView.builder(addAutomaticKeepAlives: true,
      itemCount: product.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemBuilder: (BuildContext context, int index) {
        return ChangeNotifierProvider.value(
          value : product[index],
          child: const GridItem(),
        );
      },
    );
  }


  @override
  void initState() {
    isInit = true;
  }

  @override
  void didChangeDependencies() {
    if(isInit) {
      Provider.of<ProductProvider>(context, listen: false).getProduct().then((
          value) {
        isInit = false;
      });
    }
  }
}
