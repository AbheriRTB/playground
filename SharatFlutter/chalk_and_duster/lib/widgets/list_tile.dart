import 'package:chalk_and_duster/main.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  String? name = '', desc;
  int index = 1;
  final Function? onTap;

  CustomList.listTypeOne({
    required this.onTap,
    this.name,
  }) {
    index = 1;
  }
  CustomList.listTypeTwo({required this.onTap, this.name, this.desc}) {
    index = 2;
  }

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        return customList1();
      case 2:
        return customList2();
    }
    return Container();
  }

  Widget customList1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: secondary.withOpacity(0.2),
          highlightColor: secondary.withOpacity(0.2),
          onTap: () => onTap!(),
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 5.0,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: accent,
                    child: Text(
                      '${name.toString()[0]}',
                      style: TextStyle(
                        color: accentDark,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString(),
                          style: TextStyle(fontSize: 22.0, color: accentDark),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Latest Message',
                            style: TextStyle(fontSize: 14.0, color: accentDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
          color: secondary,
        ),
      ],
    );
  }

  Widget customList2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: secondary.withOpacity(0.2),
          highlightColor: secondary.withOpacity(0.2),
          onTap: () => onTap!(),
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 5.0,
              ),
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        maxRadius: 20.0,
                        backgroundColor: secondary,
                        child: Text(
                          '${name.toString()[0]}',
                          style: TextStyle(
                            color: accentDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.toString(),
                          style: TextStyle(fontSize: 22.0, color: accentDark),
                        ),
                        SizedBox(
                          height: 3.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            '$desc',
                            style: TextStyle(fontSize: 14.0, color: accentDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          indent: 8,
          endIndent: 8,
          color: secondary,
        ),
      ],
    );
  }
}
