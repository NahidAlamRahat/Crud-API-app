import 'package:crud_api_app/models/product_api.dart';
import 'package:crud_api_app/ui/screen/add_new_product_screen.dart';
import 'package:crud_api_app/ui/screen/product_list_screen.dart';
import 'package:crud_api_app/ui/screen/update_product_screen.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = const ProductListScreen();
        } else if (settings.name == AddNewProductScreen.name) {
          widget = const AddNewProductScreen();
        } else if (settings.name == UpdateProductScreen.name) {
          final ProductAPi productItem = settings.arguments as ProductAPi;
          widget = UpdateProductScreen(productAPi: productItem);
        }
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
