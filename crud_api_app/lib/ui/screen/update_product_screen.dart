import 'dart:convert';

import 'package:crud_api_app/models/product_api.dart';
import 'package:crud_api_app/ui/screen/product_list_screen.dart';
import 'package:crud_api_app/ui/widget/show_snackber_message.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({super.key, required this.productAPi});
  //named navigator
  static String name = '/update-item';
  late ProductAPi productAPi;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController productCodeController = TextEditingController();

  TextEditingController imageController = TextEditingController();

  TextEditingController unitPriceController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  TextEditingController totalPriceController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productNameController.text = widget.productAPi.productName!;

    productCodeController.text = widget.productAPi.productCode!;

    imageController.text = widget.productAPi.image!;

    unitPriceController.text = widget.productAPi.unitPrice!;

    quantityController.text = widget.productAPi.quantity!;

    totalPriceController.text = widget.productAPi.totalPrice!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Item'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: buildProductForm(),
          ),
        ));
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
            child: ElevatedButton(
              onPressed: () {
                if(formKey.currentState!.validate()){
                  updateItem();
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void>updateItem() async{
    setState(() {});
    Uri uri =Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.productAPi.id}');
    Map<String, dynamic> requestBody = {
      "ProductName": productNameController.text.trim(),
      "ProductCode": productCodeController.text.trim(),
      "Img": imageController.text.trim(),
      "UnitPrice": unitPriceController.text.trim(),
      "Qty": quantityController.text.trim(),
      "TotalPrice": totalPriceController.text.trim(),
    };

    Response response = await post(
      uri,
      headers: {'Content-type': 'application/json'},
      body:  jsonEncode(requestBody)
    );

    print(response.statusCode);

    if(response.statusCode == 200){
      Mymessage("Updated", context);
    }
    else{
      Mymessage('Updated failed', context);
    }

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
  }
}
