import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeparateString extends StatefulWidget {
  const SeparateString({Key? key}) : super(key: key);

  @override
  State<SeparateString> createState() => _SeparateStringState();
}

class _SeparateStringState extends State<SeparateString> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text Alignment Example')),
      body: Center(
        child: MyMixedTextWidget(),
      ),
    );
  }
}

class MyMixedTextWidget extends StatelessWidget {
  final String mixedText = 'Helloaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa, \n\nمرحبًا';

  @override
  Widget build(BuildContext context) {
    // final baseDirection = Bidi.detectRtlDirectionality(mixedText);
    final baseDirection = BidiFormatter.RTL().wrapWithUnicode(mixedText);

    // return Align(
    //   alignment: baseDirection == TextDirection.RTL ? Alignment.topRight : Alignment.topLeft,
    //   child: Text(
    //     baseDirection,
    //     textAlign: baseDirection == TextDirection.RTL ? TextAlign.right : TextAlign.left,
    //     style: TextStyle(fontSize: 18),
    //   ),
    // );
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: mixedText,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

// class MixedDirectionText extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String mixedText = 'Hello, مرحبًا';
//
//     Bidi bid = Bidi.detectRtlDirectionality(mixedText) as Bidi;
//     TextDirection textDirection = bid. ? TextDirection.rtl : TextDirection.ltr;
//
//     return Directionality(
//       textDirection: textDirection,
//       child: RichText(
//         text: TextSpan(
//           children: [
//             TextSpan(
//               text: mixedText,
//               style: TextStyle(color: Colors.black),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
