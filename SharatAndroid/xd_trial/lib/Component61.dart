import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Component61 extends StatelessWidget {
  Component61({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 16.0, 378.6, 368.5),
          size: Size(600.0, 490.0),
          pinLeft: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_c3rbj,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(242.6, 0.0, 357.4, 354.6),
          size: Size(600.0, 490.0),
          pinRight: true,
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_biyrf6,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(170.0, 185.0, 0.0, 0.0),
          size: Size(600.0, 490.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            '',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 20,
              color: const Color(0xffe2e2e2),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(249.8, 227.2, 310.2, 246.8),
          size: Size(600.0, 490.0),
          pinRight: true,
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_eclmpf,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(124.0, 76.0, 221.0, 114.0),
          size: Size(600.0, 490.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Meet',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 92,
              color: const Color(0xffffffff),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(318.0, 446.0, 182.0, 44.0),
          size: Size(600.0, 490.0),
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Container(
            decoration: BoxDecoration(),
          ),
        ),
      ],
    );
  }
}

const String _svg_c3rbj =
    '<svg viewBox="0.0 16.0 378.6 368.5" ><path transform="translate(0.0, 16.0)" d="M 183 0 C 284.068115234375 0 421.0216064453125 31.94954109191895 366 183 C 310.9783935546875 334.0504455566406 310.5455627441406 346.2001342773438 183 366 C 55.45443725585938 385.7998657226563 0 284.068115234375 0 183 C 0 81.93189239501953 81.93189239501953 0 183 0 Z" fill="#656565" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_biyrf6 =
    '<svg viewBox="242.6 0.0 357.4 354.6" ><path transform="translate(247.0, 0.0)" d="M 176.5 0 C 273.9782409667969 0 353 79.02175140380859 353 176.5 C 353 273.9782409667969 268.9285278320313 367.8208312988281 176.5 353 C 84.07147216796875 338.1791687011719 27.509033203125 306.2221374511719 0 176.5 C -27.509033203125 46.77785110473633 79.02175140380859 0 176.5 0 Z" fill="#ffc300" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eclmpf =
    '<svg viewBox="249.8 227.2 310.2 246.8" ><path transform="translate(322.0, 236.0)" d="M 119 0 C 228.72314453125 37.57075500488281 238 53.27811431884766 238 119 C 238 184.7218933105469 184.7218933105469 238 119 238 C 53.27811431884766 238 -72.22381591796875 184.7218933105469 -72.22381591796875 119 C -72.22381591796875 53.27811431884766 9.27685546875 -37.57075500488281 119 0 Z" fill="#e8e4e4" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
