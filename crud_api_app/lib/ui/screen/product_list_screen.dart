import 'dart:convert';

import 'package:crud_api_app/models/product_api.dart';
import 'package:crud_api_app/ui/screen/add_new_product_screen.dart';
import 'package:crud_api_app/ui/widget/product_item.dart';
import 'package:crud_api_app/ui/widget/show_snackber_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {
  List<ProductAPi> productList = [];

  bool _getProductListInProgres = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetResponce();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product list'),
        actions: [
          IconButton(
              onPressed: () {
                // _getProductListInProgres==true;
                GetResponce();
                // _getProductListInProgres==false;

                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          GetResponce();
        },
        child: Visibility(
          visible: _getProductListInProgres == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductItem(
                productItem: productList[index],
                deleteList: () {
                  DeleteItem(productList[index].id.toString(),
                      index); // Corrected here
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddNewProductScreen.name);
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> GetResponce() async {
    _getProductListInProgres = true;
    productList.clear();
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    response.body;

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      for (Map<String, dynamic> i in decodedData['data']) {
        ProductAPi productAPi = ProductAPi(
          id: i['_id'],
          productName: i['ProductName'],
          productCode: i['ProductCode'],
          image: i['Img'],
          unitPrice: i['UnitPrice'],
          totalPrice: i['TotalPrice'],
          quantity: i['Qty'],
          createdDate: i['CreatedDate'],
        );
        productList.add(productAPi);
      }
      _getProductListInProgres = false;
      setState(() {});
    }
    setState(() {});
  }

  Future<void> DeleteItem(String id, int index) async {
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/$id');
    Response response = await get(uri);

    if (response.statusCode == 200) {
      productList.removeAt(index); // Remove the item from the list
      Mymessage('delete success', context);
    } else {
      Mymessage('delete filed', context);
    }

    setState(() {}); // Ensure UI updates
  }
}
