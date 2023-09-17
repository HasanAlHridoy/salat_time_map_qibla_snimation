import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_compass/utils/src/compass_ui.dart';

class Qibla extends StatefulWidget {
  const Qibla({Key? key}) : super(key: key);

  @override
  State<Qibla> createState() => _QiblaState();
}

class _QiblaState extends State<Qibla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SmoothCompass(
        rotationSpeed: 200,
        isQiblahCompass: true,
        compassBuilder: (context, snapshot, child) {
          return AnimatedRotation(
            duration: const Duration(milliseconds: 800),
            turns: snapshot?.data?.turns ?? 0,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Image.asset(
                    "assets/images/img.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 500),
                    turns: (snapshot?.data?.qiblahOffset ?? 0) / 360,
                    child: Image.asset(
                      "assets/images/needle.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
          // SmoothCompass(
          //   compassBuilder: (context, snapshot, child) {
          //     return SizedBox(
          //       width: 200,
          //       height: 200,
          //       child: Stack(
          //         children: [
          //           Positioned(
          //             top: 0,
          //             left: 0,
          //             right: 0,
          //             bottom: 0,
          //             // child: Image.asset("assets/images/qibla_back.png"),
          //             child: Container(
          //               color: Colors.red,
          //             ),
          //           ),
          //           Positioned(
          //             top: 0,
          //             left: 0,
          //             right: 0,
          //             bottom: 0,
          //             // child: Image.asset("assets/images/needle.png"),
          //             child: Container(
          //               color: Colors.green,
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          ),
    );
  }
}
