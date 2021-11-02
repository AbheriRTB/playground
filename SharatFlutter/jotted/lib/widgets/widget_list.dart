import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:jotted/models/model_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomList extends StatelessWidget {
  Color primary = Color(0xff303242);
  Color secondary = Color(0xff394359);
  Color accentDark = Color(0xffE0C097);
  Color accent = Color(0xffB85C38);

  String? name = '', desc;
  Groups? grupData;
  int index = 1;
  final Function? onTap;
  bool? isRead = false;
  String? color;

  CustomList.listTypeOne({
    required this.onTap,
    this.grupData,
    this.isRead,
    this.name,
    this.color,
  }) {
    index = 1;
  }
  CustomList.listTypeTwo({
    required this.onTap,
    this.name,
    this.desc,
  }) {
    index = 2;
  }

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 1:
        return customList3(context);
      case 2:
        return customList4(context);
    }
    return Container();
  }

  Widget customList1() {
    String colorString = color!;
    String valueString =
        colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.white12,
          highlightColor: Colors.white12,
          onTap: () => onTap!(),
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                bottom: 20.0,
                left: 5.0,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Container(
                      color: otherColor.withOpacity(0.2),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14.0, vertical: 8.0),
                        child: Text(
                          name.toString().toUpperCase()[0],
                          style: TextStyle(
                            fontSize: 22.0,
                            color: otherColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8.0),
                    child: Text(
                      name.toString(),
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Colors.black87.withOpacity(0.6),
                        fontWeight:
                            isRead! ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customList3(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        color: Colors.grey[900]!.withOpacity(0.7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: Text(
                        '${grupData!.grupName!}',
                        style: TextStyle(
                          fontSize: 26.0,
                          fontFamily: 'Integral',
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: isRead! ? Colors.grey : Colors.grey[700],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.0,
                          top: 4.0,
                          bottom: 12.0,
                          right: 10.0,
                        ),
                        child: Text(
                          '${grupData!.lastMessage!['content']}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color:
                                isRead! ? Colors.grey[600] : Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: isRead! ? 0.5 : 0,
                  child: CircleAvatar(
                    backgroundColor: Color(0xff90D44B),
                    maxRadius: 4.0,
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
              ],
            ),
            Divider(
              color: Colors.black12,
              thickness: 3,
              height: 0,
            ),
          ],
        ),
      ),
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

  Widget customList4(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffE4F0D7).withOpacity(0),
          child: InkWell(
            onTap: () => onTap!(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Text(
                            name!,
                            style: TextStyle(
                              fontSize: 26.0,
                              fontFamily: GoogleFonts.lekton().fontFamily,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            top: 4.0,
                            bottom: 12.0,
                            right: 10.0,
                          ),
                          child: Text(
                            '$desc',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: GoogleFonts.lekton().fontFamily,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Divider(
          height: 0,
          endIndent: 6,
          indent: 6,
          thickness: 0.8,
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }
}
