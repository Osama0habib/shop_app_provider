import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/product_provider.dart';

class EditMyProductScreen extends StatefulWidget {
  const EditMyProductScreen({Key? key}) : super(key: key);

  static const routeName = "edit_product_screen";

  @override
  State<EditMyProductScreen> createState() => _EditMyProductScreenState();
}

class _EditMyProductScreenState extends State<EditMyProductScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  bool isImage = false;

  FocusNode priceFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(label: Text("Title")),
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: const InputDecoration(label: Text("Price")),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(label: Text("Description")),
                    textInputAction: TextInputAction.next,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: isImage == false
                              ? Center(
                                  child: Text("No Image"),
                                )
                              : Image.network(imageUrlController.text,)),
                      Expanded(
                          child: TextFormField(
                        controller: imageUrlController,
                        decoration:
                            const InputDecoration(label: Text("ImageUrl")),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          setState(() {
                            isImage = true;
                          });
                        },
                      )),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ProductModel product = ProductModel(
                            title: titleController.text,
                            price: double.parse(priceController.text),
                            description: descriptionController.text,
                            imageUrl: imageUrlController.text);
                        Provider.of<ProductProvider>(context,listen: false).addProduct(product.toMap());
                      }
                    },
                    child: Text("Save Product"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
