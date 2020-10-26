import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';

import 'package:adobe_xd/page_link.dart';

import 'Meeting.dart';

class CancleBtn extends StatelessWidget {
  CancleBtn({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 0.0, 72.0, 24.0),
          size: Size(72.0, 24.0),
          pinLeft: true,
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          child: PageLink(
            links: [
              PageLinkInfo(
                transition: LinkTransition.PushLeft,
                ease: Curves.easeOut,
                duration: 0.3,
                pageBuilder: () => Meeting(),
              ),
            ],
            child: Text(
              'Cancle',
              style: TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 20,
                color: const Color(0xff919191),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }
}
