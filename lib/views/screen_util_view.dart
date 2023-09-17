import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../custom_page_route.dart';

class ScreenUtilView extends StatefulWidget {
  const ScreenUtilView({Key? key}) : super(key: key);

  @override
  State<ScreenUtilView> createState() => _ScreenUtilViewState();
}

class _ScreenUtilViewState extends State<ScreenUtilView> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.green,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Text('dklpklklplplplopolplpata', style: TextStyle(fontSize: 100.sp))),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop((CustomPageRoute(
                      child: const ScreenUtilView(),
                      direction: AxisDirection.right,
                    )));
                  },
                  child: Text('Back'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
