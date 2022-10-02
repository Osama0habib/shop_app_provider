import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text("title"),
          subtitle: Text("date"),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;

                });
              },
              icon: Icon(expanded == true? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded)),),

        if(expanded)
        Card(child: Container(),),
      ],
    );
  }
}
