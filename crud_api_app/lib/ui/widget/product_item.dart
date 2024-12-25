import 'package:crud_api_app/ui/screen/product_list_screen.dart';
import 'package:flutter/material.dart';

import '../../models/product_api.dart';
import '../screen/update_product_screen.dart';

class ProductItem extends StatelessWidget {
  final ProductAPi productItem;
  final VoidCallback deleteList;

  const ProductItem({
    super.key,
    required this.productItem,
    required this.deleteList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 20,
        shadowColor: Color.fromRGBO(0, 0, 0, 1.0),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [

              // Image Rounded Corner
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: SizedBox(
                  width: 120,
                  height: double.infinity,
                  child: Image.network(
                    "${productItem.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),

              /// Product Information
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${productItem.productName}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('id: ${productItem.id}'),
                      Text('code: ${productItem.productCode}'),
                      Text('price: ${productItem.unitPrice}'),
                      Text('Date: ${productItem.createdDate}'),
                    ],
                  ),
                ),
              ),

              /// edit and delete Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, UpdateProductScreen.name,
                          arguments: productItem);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: deleteList,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
