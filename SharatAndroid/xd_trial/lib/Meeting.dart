import 'package:flutter/material.dart';
import 'Component61.dart';
import 'Component71.dart';
import 'About.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meeting extends StatelessWidget {
  Meeting({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-101.0, -50.0),
            child: SizedBox(
              width: 600.0,
              height: 490.0,
              child: Component61(),
            ),
          ),
          Transform.translate(
            offset: Offset(318.0, 778.0),
            child: SizedBox(
              width: 60.0,
              height: 60.0,
              child: Component71(),
            ),
          ),
          Transform.translate(
            offset: Offset(375.0, 8.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.PushRight,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => About(),
                ),
              ],
              child: Container(
                width: 29.0,
                height: 29.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(378.0, 10.0),
            child:
                // Adobe XD layer: 'biotech-24px' (group)
                PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.PushRight,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => About(),
                ),
              ],
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: Stack(
                  children: <Widget>[
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                      size: Size(24.0, 24.0),
                      pinLeft: true,
                      pinRight: true,
                      pinTop: true,
                      pinBottom: true,
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                            size: Size(24.0, 24.0),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: Container(
                              decoration: BoxDecoration(),
                            ),
                          ),
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 24.0, 24.0),
                            size: Size(24.0, 24.0),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: Container(
                              decoration: BoxDecoration(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Pinned.fromSize(
                      bounds: Rect.fromLTWH(5.0, 2.3, 14.0, 18.7),
                      size: Size(24.0, 24.0),
                      pinTop: true,
                      pinBottom: true,
                      fixedWidth: true,
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 14.0, 18.7),
                            size: Size(14.0, 18.7),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: Stack(
                              children: <Widget>[
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(0.0, 5.1, 14.0, 13.6),
                                  size: Size(14.0, 18.7),
                                  pinLeft: true,
                                  pinRight: true,
                                  pinTop: true,
                                  pinBottom: true,
                                  child: SvgPicture.string(
                                    _svg_8dgbbk,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(5.3, 0.0, 5.9, 9.5),
                                  size: Size(14.0, 18.7),
                                  pinTop: true,
                                  fixedWidth: true,
                                  fixedHeight: true,
                                  child: SvgPicture.string(
                                    _svg_eotpi9,
                                    allowDrawingOutsideViewBox: true,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Pinned.fromSize(
                                  bounds: Rect.fromLTWH(4.0, 4.2, 3.0, 3.0),
                                  size: Size(14.0, 18.7),
                                  fixedWidth: true,
                                  fixedHeight: true,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.elliptical(9999.0, 9999.0)),
                                      color: const Color(0xffffc000),
                                    ),
                                  ),
                                ),
                              ],
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
        ],
      ),
    );
  }
}

const String _svg_8dgbbk =
    '<svg viewBox="5.0 7.4 14.0 13.6" ><path  d="M 7 19 C 5.900000095367432 19 5 19.89999961853027 5 21 L 19 21 C 19 19.89999961853027 18.10000038146973 19 17 19 L 13 19 L 13 17 L 16 17 C 17.10000038146973 17 18 16.10000038146973 18 15 L 10 15 C 8.340000152587891 15 7 13.65999984741211 7 12 C 7 10.90999984741211 7.590000152587891 9.960000038146973 8.460000038146973 9.440000534057617 C 8.170000076293945 9.029999732971191 8 8.539999961853027 8 8 C 8 7.789999961853027 8.039999961853027 7.579999923706055 8.090000152587891 7.380000114440918 C 6.28000020980835 8.130000114440918 5 9.920000076293945 5 12 C 5 14.76000022888184 7.239999771118164 17 10 17 L 10 19 L 7 19 Z" fill="#ffc000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_eotpi9 =
    '<svg viewBox="10.3 2.3 5.9 9.5" ><path  d="M 10.5600004196167 5.510000228881836 C 11.90999984741211 5.539999961853027 13 6.639999866485596 13 8 C 13 8.75 12.67000007629395 9.409999847412109 12.14999961853027 9.869999885559082 L 12.39999961853027 10.55000019073486 C 12.58999919891357 11.06999969482422 13.15999984741211 11.34000015258789 13.67999935150146 11.15000057220459 C 13.86999893188477 11.67000007629395 14.4399995803833 11.94000053405762 14.95999908447266 11.75000095367432 C 15.47999954223633 11.56000137329102 15.74999904632568 10.99000072479248 15.55999946594238 10.47000122070313 C 16.07999992370605 10.28000164031982 16.35000038146973 9.710000991821289 16.15999984741211 9.190001487731934 L 14.10000038146973 3.539999961853027 C 13.91000080108643 3.019999980926514 13.34000015258789 2.75 12.82000064849854 2.940000057220459 C 12.63000106811523 2.420000076293945 12.0600004196167 2.150000095367432 11.54000091552734 2.340000152587891 C 11.02000045776367 2.53000020980835 10.75000095367432 3.100000143051147 10.94000053405762 3.620000123977661 C 10.42000007629395 3.81000018119812 10.15000057220459 4.380000114440918 10.34000015258789 4.900000095367432 L 10.5600004196167 5.510000228881836 Z" fill="#ffc000" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
