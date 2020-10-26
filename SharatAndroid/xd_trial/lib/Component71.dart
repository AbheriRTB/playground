import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Add.dart';
import 'package:adobe_xd/page_link.dart';

class Component71 extends StatelessWidget {
  Component71({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 60.0, 60.0),
          size: Size(60.0, 60.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: PageLink(
            links: [
              PageLinkInfo(
                transition: LinkTransition.PushRight,
                ease: Curves.easeOut,
                duration: 0.3,
                pageBuilder: () => Add(),
              ),
            ],
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                color: const Color(0xffffc300),
              ),
            ),
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(21.0, 11.0, 18.0, 37.0),
          size: Size(60.0, 60.0),
          fixedWidth: true,
          fixedHeight: true,
          child: PageLink(
            links: [
              PageLinkInfo(
                transition: LinkTransition.PushRight,
                ease: Curves.easeOut,
                duration: 0.3,
                pageBuilder: () => Add(),
              ),
            ],
            child: Text(
              '+',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 30,
                color: const Color(0xfff2f2f2),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
