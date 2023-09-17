import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:salat_time_and_slide/map_screen.dart';
import 'package:salat_time_and_slide/paint.dart';
import 'package:salat_time_and_slide/qibla_screen.dart';
import 'package:salat_time_and_slide/separate_string.dart';
import 'package:salat_time_and_slide/sun_animation.dart';
import 'package:salat_time_and_slide/timer_reverse.dart';
import 'package:salat_time_and_slide/views/screen_util_view.dart';

import 'custom_page_route.dart';
import 'google_map.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(370, 780),
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  int initIndex = 0;
  DateTime dt = DateTime.now();
  List d = [];
  CarouselController buttonCarouselController = CarouselController();

  List a = [
    DateTime.parse('2023-06-25 04:00:54.000'),
    DateTime.parse('2023-06-24 13:00:54.000'),
    DateTime.parse('2023-06-24 16:00:54.000'),
    DateTime.parse('2023-06-24 19:00:54.000'),
    DateTime.parse('2023-06-24 20:30:54.000'),
  ];

  int getCurrentOkato() {
    for (int i = 0; i < a.length; i++) {
      if (a[i].hour > DateTime.now().hour) {
        buttonCarouselController.jumpToPage(i);
        break;
      }
    }
    return -1;
  }
/*This function used for get shortest time!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/
  // int getInitialPage() {
  //   for (DateTime element in a) {
  //     dt = element.subtract(Duration(
  //       hours: DateTime.now().hour,
  //       minutes: DateTime.now().minute,
  //       seconds: DateTime.now().second,
  //     ));
  //
  //     d.add(dt.hour);
  //   }
  //   int smallestDateTime = d.reduce((value, element) => value < element ? value : element);
  //   print(smallestDateTime);
  //   return smallestDateTime;
  // }

  List imgList = [
    'https://t3.ftcdn.net/jpg/05/62/49/86/360_F_562498688_JLArrNerQZoo6KGjepmYeDJKhyimfeXB.jpg',
    'https://media.istockphoto.com/id/1341903785/vector/eid-mubarak-card-silhouette-dome-mosques-at-night-with-crescent-moon-dark-blue-sky-vector.jpg?s=612x612&w=0&k=20&c=gcNQAPC-713bxTIWv0kuayJ5QmvsNO4P4Lg4wdUKKnc=',
    'https://images.cdn1.stockunlimited.net/preview1300/mosque-background-design_1962091.jpg',
    'https://img.freepik.com/free-photo/dark-landscape-with-bird-flying_1122-682.jpg?1',
    'https://us.123rf.com/450wm/wingwings/wingwings2209/wingwings220900036/191942564-silhouette-mosques-dome-crescent-moon-on-dark-black-twillight-evening-background-symbols-new-year.jpg?ver=6'
  ];
  Map<String, dynamic> getWaqtDetails() {
    if (currentIndex == 0) {
      return {
        'waqtName': 'Fazr',
        'waqtTime': DateFormat.jm().format(a[0]),
        'waqtTimeLeft': a[0],
        'totalRakat': '4',
        'farz': '2',
        'sunnah': '2',
        'howToPray': '0',
      };
    } else if (currentIndex == 1) {
      return {
        'waqtName': 'Duhar',
        'waqtTime': DateFormat.jm().format(a[1]),
        'waqtTimeLeft': a[1],
        'totalRakat': '10',
        'farz': '4',
        'sunnah': '6 (4+2)',
        'howToPray': '0',
      };
    } else if (currentIndex == 2) {
      return {
        'waqtName': 'Asr',
        'waqtTime': DateFormat.jm().format(a[2]),
        'waqtTimeLeft': a[2],
        'totalRakat': '8',
        'farz': '4',
        'sunnah': '4',
        'howToPray': '0',
      };
    } else if (currentIndex == 3) {
      return {
        'waqtName': 'Magrib',
        'waqtTime': DateFormat.jm().format(a[3]),
        'waqtTimeLeft': a[3],
        'totalRakat': '5',
        'farz': '3',
        'sunnah': '2',
        'howToPray': '0',
      };
    } else {
      return {
        'waqtName': 'Isha',
        'waqtTime': DateFormat.jm().format(a[4]),
        'waqtTimeLeft': a[4],
        'totalRakat': '13',
        'farz': '4',
        'sunnah': '6 (4+2)',
        'bitar': '3',
        'howToPray': '0',
      };
    }
  }

/*---------------------------------------------------------------------MAP----------------------------------------------------------------------------*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        print(getCurrentOkato());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NearbyMosques())),
        child: Text(
          'Map',
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CarouselSlider(
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: false,
              initialPage: 0,
              aspectRatio: 2,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: imgList
                .map(
                  (item) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(
                          item,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getWaqtDetails()['waqtName'],
                                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                Text(
                                  getWaqtDetails()['waqtTime'],
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                const Spacer(),
                                TimerReverse(counter: getWaqtDetails()['waqtTimeLeft'])
                              ],
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Rakat : ${getWaqtDetails()['totalRakat']}',
                                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                ),
                                Text(
                                  'Farz : ${getWaqtDetails()['farz']}',
                                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                ),
                                Text(
                                  'Sunnah : ${getWaqtDetails()['sunnah']}',
                                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                ),
                                Visibility(
                                  visible: currentIndex == 4,
                                  child: Text(
                                    'Bitar : ${getWaqtDetails()['bitar']}',
                                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueGrey,
                                    fixedSize: Size(120, 30),
                                  ),
                                  onPressed: () {
                                    print(getWaqtDetails()['isPageDisplay1']);
                                  },
                                  child: Text('How to Pray', style: TextStyle(fontSize: 16.sp)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const ScreenUtilView(),
                direction: AxisDirection.left,
              ));
            },
            child: Text('Next', style: TextStyle(fontSize: 16.sp)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const Qibla(),
                direction: AxisDirection.left,
              ));
            },
            child: Text('Qibla', style: TextStyle(fontSize: 16.sp)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const GoogleMapMecca(),
                direction: AxisDirection.left,
              ));
            },
            child: Text('Google Map', style: TextStyle(fontSize: 16.sp)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const SunAnimation(),
                direction: AxisDirection.left,
              ));
            },
            child: Text('Sun Animation', style: TextStyle(fontSize: 16.sp)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(CustomPageRoute(
                child: const SeparateString(),
                direction: AxisDirection.left,
              ));
            },
            child: Text('String', style: TextStyle(fontSize: 16.sp)),
          ),
        ],
      )),
    );
  }
}
