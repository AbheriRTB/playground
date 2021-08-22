import 'package:flutter/material.dart';
import 'package:kaksha/models/model_explain.dart';
import 'package:kaksha/models/model_topics.dart';

class CustomList extends StatelessWidget {
  Color background = Color.fromRGBO(253, 246, 227, 1);
  Color background2 = Color.fromRGBO(233, 229, 205, 1);
  Color accent = Color.fromRGBO(218, 117, 68, 1);

  String name = '';
  int index = 1;
  final Function? onTap;
  Explain? list;
  Topics? topics;

  CustomList.listTypeOne({@required this.onTap, this.list}) {
    index = 1;
  }
  CustomList.listTypeThree({@required this.onTap, this.topics}) {
    index = 3;
  }
  CustomList.listTypeTwo(this.name, {@required this.onTap}) {
    index = 2;
  }

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        return customList1();
      case 2:
        return customList2();
      case 3:
        return customList3();
    }
    return Container();
  }

  Widget customList1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onTap!(),
          child: Container(
            color: list!.isSelected! ? background2 : Colors.transparent,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 5.0,
              ),
              child: Text(
                list!.engName!,
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }

  Widget customList3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onTap!(),
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5.0,
                left: 5.0,
              ),
              child: Text(
                topics!.name.toString(),
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
              ),
            ),
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }

  Widget customList2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => onTap!(),
          child: Text(
            name,
            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          indent: 8,
          endIndent: 8,
        ),
      ],
    );
  }
}
