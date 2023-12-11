import 'package:flutter/material.dart';

class ReusableWidget extends StatelessWidget {
  String title, value;
  ReusableWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
