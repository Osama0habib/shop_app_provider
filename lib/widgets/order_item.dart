import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app_course/providers/order_provider.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(widget.order.amount!.toStringAsFixed(2)),
          subtitle: Text(
              DateFormat("dd mmm yyyy hh:mm").format(widget.order.dateTime!)),
          trailing: IconButton(
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              icon: Icon(expanded == true
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_up_rounded)),
        ),
        if (expanded)
          Card(
            child: Container(
              height: widget.order.product!.length * 20,
              child: ListView.builder(
                itemCount: widget.order.product!.length,
                itemBuilder: (BuildContext context, int index) {
                return  Row(children: [
                    Text(widget.order.product![index].productModel.title!),
                    Spacer(),
                    Text("${widget.order.product![index].itemCount}X")
                  ],);
                },
              ),
            ),
          ),
      ],
    );
  }
}
