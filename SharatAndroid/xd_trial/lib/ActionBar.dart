import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionBar extends StatelessWidget {
  ActionBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromSize(
          bounds: Rect.fromLTWH(0.0, 113.0, 843.1, 403.7),
          size: Size(843.1, 571.0),
          pinLeft: true,
          pinRight: true,
          pinBottom: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_qdata1,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(227.1, 287.0, 290.6, 284.0),
          size: Size(843.1, 571.0),
          pinBottom: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_pn4wf6,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(214.1, 0.0, 413.5, 401.0),
          size: Size(843.1, 571.0),
          pinTop: true,
          fixedWidth: true,
          fixedHeight: true,
          child: SvgPicture.string(
            _svg_eq97oo,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromSize(
          bounds: Rect.fromLTWH(361.1, 201.0, 166.0, 114.0),
          size: Size(843.1, 571.0),
          fixedWidth: true,
          fixedHeight: true,
          child: Text(
            'Add',
            style: TextStyle(
              fontFamily: 'JetBrains Mono',
              fontSize: 92,
              color: const Color(0xffffffff),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

const String _svg_qdata1 =
    '<svg viewBox="0.0 113.0 843.1 403.7" ><path transform="translate(442.08, 113.0)" d="M 200.5 0 C 311.2330932617188 0 401 89.76691436767578 401 200.5 C 401 311.2330932617188 360.2409057617188 422.70947265625 200.5 401 C 40.75909423828125 379.29052734375 -297.34326171875 143.8035278320313 -137.8479461669922 165.5733032226563 C -79.79183197021484 173.4974975585938 -458.6504516601563 199.1147766113281 -441.5177612304688 164.739013671875 C -411.7481689453125 105.0080261230469 130.0736389160156 0 200.5 0 Z" fill="#595959" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pn4wf6 =
    '<svg viewBox="227.1 287.0 290.6 284.0" ><path transform="translate(227.08, 287.0)" d="M 142 0 C 220.4244384765625 0 316.9644775390625 59.28633117675781 284 142 C 251.0355377197266 224.7136688232422 220.4244384765625 284 142 284 C 63.57556915283203 284 0 220.4244384765625 0 142 C 0 63.57556915283203 63.57556915283203 0 142 0 Z" fill="#e8e4e4" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eq97oo =
    '<svg viewBox="214.1 0.0 413.5 401.0" ><path transform="translate(214.08, 0.0)" d="M 200.5 0 C 311.2330932617188 0 457.2666320800781 63.22264862060547 401 200.5 C 344.7333679199219 337.77734375 311.2330932617188 401 200.5 401 C 89.76691436767578 401 0 311.2330932617188 0 200.5 C 0 89.76691436767578 89.76691436767578 0 200.5 0 Z" fill="#ffc300" fill-opacity="0.92" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
