import 'dart:convert';

import 'package:crud_api_app/models/product_api.dart';
import 'package:crud_api_app/ui/widget/show_snackber_message.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  //named navigator
  static String name = '/add-new-item';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController productCodeController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  TextEditingController unitPriceController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController totalPriceController = TextEditingController();

  TextEditingController idTEController = TextEditingController();


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductAPi productAPi = ProductAPi();

  bool _addProductInProgressber = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageController.text=productAPi.image!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: buildProductForm(),
        ),
      ),
    );
  }

  Widget buildProductForm() {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the product name';
                  }
                  return null;
                },
                controller: productNameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Product Code';
                  }
                  return null;
                },
                controller: productCodeController,
                decoration: const InputDecoration(
                  labelText: 'Product Code',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Unit Price';
                  }
                  return null;
                },
                controller: unitPriceController,
                decoration: const InputDecoration(
                  labelText: 'Unit Price',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Quantity';
                  }
                  return null;
                },
                controller: quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Total Price';
                  }
                  return null;
                },
                controller: totalPriceController,
                decoration: const InputDecoration(
                  labelText: 'Total Price',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the product ID';
                  }
                  return null;
                },
                controller: idTEController,
                decoration: const InputDecoration(
                  labelText: 'Product ID',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,

                validator: (String? value) {
                  if (value?.trim().isEmpty ?? true) {
                    return 'Enter the Image URL';
                  }
                  return null;
                },
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image URL',
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Visibility(
                visible: _addProductInProgressber == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        productPost();
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )
          ],
        ));
  }

  Future<void> productPost() async {
    setState(() {});
    _addProductInProgressber = true;
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> requestBody = {
      "ProductName": productNameController.text.trim(),
      "ProductCode": productCodeController.text.trim(),
      "Img": imageController.text.trim(),
      "UnitPrice": unitPriceController.text.trim(),
      "Qty": quantityController.text.trim(),
      "TotalPrice": totalPriceController.text.trim(),
      // "_id": idTEController.text.trim(),
    };


    Response response = await post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    _addProductInProgressber = false;
    setState(() {});

    print(response.statusCode);

    if (response.statusCode == 200) {
      clearAllController();
      Mymessage('added', context);
    } else {
      Mymessage('added field', context);
    }
  }

  void clearAllController() {
    productNameController.clear();
    productCodeController.clear();
    quantityController.clear();
    imageController.clear();
    totalPriceController.clear();
    unitPriceController.clear();
    idTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    productCodeController.dispose();
    quantityController.dispose();
    imageController.dispose();
    totalPriceController.dispose();
    unitPriceController.dispose();
    idTEController.dispose();
  }
}
