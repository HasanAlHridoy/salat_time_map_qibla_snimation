import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SunAnimation extends StatefulWidget {
  const SunAnimation({Key? key}) : super(key: key);

  @override
  State<SunAnimation> createState() => _SunAnimationState();
}

class _SunAnimationState extends State<SunAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  DateTime d1 = DateTime.parse('2023-08-03 18:39:10.000');
  DateTime d2 = DateTime.parse('2023-08-03 18:39:15.000');
  LottieComposition? _composition;
  Map<String, dynamic> getDailyHourAndMinutes() {
    String d = d2.difference(d1).toString();
    Map<String, int> m = {
      'hour': int.parse(d.split(':')[0]),
      'minute': int.parse(d.split(':')[1]),
      'seconds': int.parse(d.split(':')[2].toString().split('.')[0]),
    };

    return m;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust the duration as needed
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Lottie.asset(
              'assets/animations/sun.json',
              controller: _controller,
              fit: BoxFit.contain,
              repeat: true,
              onLoaded: (composition) {
                setState(() {
                  _composition = composition;
                  print('===================');
                  print(_composition);
                });
                // _controller.duration = Duration(
                //   hours: getDailyHourAndMinutes()['hour'],
                //   minutes: getDailyHourAndMinutes()['minute'],
                //   seconds: getDailyHourAndMinutes()['seconds'],
                // );
                _controller.duration = _composition?.duration;
                _controller.forward();
                _controller.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    _controller.reset();
                    _controller.forward();
                  }
                });
              },
            ),
            const Divider(
              height: 2,
              color: Colors.amber,
              thickness: 2,
            ),
            _composition != null
                ? AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: _Painter(_composition!, _animation.value),
                        size: const Size(400, 400),
                      );
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final LottieDrawable drawable;
  final double animationProgress;

  _Painter(LottieComposition composition, this.animationProgress) : drawable = LottieDrawable(composition);

  @override
  void paint(Canvas canvas, Size size) {
    var frameCount = 30;
    var columns = 1;
    for (var i = 0; i < frameCount; i++) {
      var destRect = Offset(i % columns * 50.0, i ~/ 30 * 80.0) & (size);
      drawable
        ..setProgress(animationProgress)
        ..draw(canvas, destRect);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
