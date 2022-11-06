import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/auth_provider.dart';
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
  ProductModel? productLast;

  FocusNode priceFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)?.settings.arguments != null) {
      productLast = ModalRoute
          .of(context)
          ?.settings
          .arguments as ProductModel;
    }
   if(productLast != null) {
     titleController.text = productLast!.title!;
     priceController.text = productLast!.price.toString();
     descriptionController.text = productLast!.description!;
     imageUrlController.text = productLast!.imageUrl!;
     isImage = true;
   }
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
                        ProductModel product =

                        ProductModel(
                            id: ModalRoute.of(context)?.settings.arguments != null ? productLast?.id : "",
                            title: titleController.text,
                            price: double.parse(priceController.text),
                            description: descriptionController.text,
                            imageUrl: imageUrlController.text.isEmpty ? "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg" :imageUrlController.text,
                            userId: Provider.of<AuthProvider>(context,listen: false).userId);

                       if(ModalRoute.of(context)?.settings.arguments != null) {
                         Provider.of<ProductProvider>(context, listen: false)
                             .updateProduct(product);
                       }else {
                         Provider.of<ProductProvider>(context, listen: false)
                             .addProduct(product);
                       }
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
