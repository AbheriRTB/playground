import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Component81 extends StatelessWidget {
  Component81({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(223.4, 0.0, 352.6, 357.8),
          size: Size(576.0, 415.9),
          pinRight: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: SvgPicture.string(
            _svg_e1mow6,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(207.5, 252.0, 216.3, 163.9),
          size: Size(576.0, 415.9),
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_uleyxk,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 24.0, 364.8, 368.7),
          size: Size(576.0, 415.9),
          pinLeft: true,
          pinTop: true,
          pinBottom: true,
          fixedWidth: true,
          child: SvgPicture.string(
            _svg_g3rxfr,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(80.0, 99.0, 276.0, 114.0),
          size: Size(576.0, 415.9),
          pinLeft: true,
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'About',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 92,
              color: const Color(0x8c494949),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

const String _svg_e1mow6 =
    '<svg viewBox="223.4 0.0 352.6 357.8" ><path transform="translate(247.0, 0.0)" d="M 164.5 0 C 255.350830078125 0 329 73.64916229248047 329 164.5 C 329 255.350830078125 287.893798828125 357.8489074707031 197.04296875 357.8489074707031 C 106.1921310424805 357.8489074707031 -23.578857421875 233.8837585449219 -23.578857421875 143.0329284667969 C -23.578857421875 52.18208312988281 73.64916229248047 0 164.5 0 Z" fill="#ffc300" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_uleyxk =
    '<svg viewBox="207.5 252.0 216.3 163.9" ><path transform="translate(223.0, 252.0)" d="M 78.5 0 C 121.8543548583984 0 200.722412109375 17.49930191040039 200.722412109375 60.85365295410156 C 200.722412109375 104.2080078125 183.30517578125 163.9072875976563 102.0233154296875 163.9072875976563 C 20.741455078125 163.9072875976563 -15.5450439453125 92.59634399414063 -15.5450439453125 49.24198913574219 C -15.5450439453125 5.887638092041016 35.14564895629883 0 78.5 0 Z" fill="#656565" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_g3rxfr =
    '<svg viewBox="0.0 24.0 364.8 368.7" ><path transform="translate(0.0, 24.0)" d="M 157.5 0 C 244.4848327636719 0 374.372802734375 56.62017059326172 364.212646484375 143.7077178955078 C 354.052490234375 230.7952728271484 216.0611267089844 368.6839599609375 129.0762939453125 368.6839599609375 C 42.09145355224609 368.6839599609375 0 244.4848327636719 0 157.5 C 0 70.51515960693359 70.51515960693359 0 157.5 0 Z" fill="#e8e4e4" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
