import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rive/rive.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';

class DhikrPage extends StatefulWidget {
  const DhikrPage({Key? key}) : super(key: key);

  @override
  State<DhikrPage> createState() => _DhikrPageState();
}

class _DhikrPageState extends State<DhikrPage> {
  late ValueNotifier<int> counter;
  late RiveAnimationController beads;
  int total = 0;
  final _player = AudioPlayer();
  @override
  void initState() {
    counter = ValueNotifier(0);
    beads = OneShotAnimation('beadsFinal', autoplay: false);
    beads.isActiveChanged.addListener(() {
      if (beads.isActive) {
        counter.value++;
        _player.setAsset('assets/image/tasbeeh.mp3');
        if (counter.value == 100) {
          counter.value = 0;
          total++;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WidgetAppBar(
        title: 'Dhikr',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image/dhikr_background.png'),
              fit: BoxFit.fill),
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: counter,
          builder: (context, value, child) {
            return Column(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/dhikr_head.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 15),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 40,
                                )),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  counter.value = 0;
                                },
                                child: const Image(
                                  height: 40,
                                  image: AssetImage('assets/image/reset.png'),
                                )),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                      ),
                      RichText(
                          text: TextSpan(
                              text: value.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                      color: AppColor.whiteTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 100),
                              children: [
                            TextSpan(
                              text: '/',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColor.whiteTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 40),
                            ),
                            TextSpan(
                              text: '99',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColor.whiteTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 40),
                            ),
                          ])),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 20,
                        width: 110,
                        child: Row(
                          children: [
                            Text('Total:',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                            Expanded(
                              child: Text(total.toString(),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomPaint(
                    painter: Thread(),
                    child: GestureDetector(
                        onTap: () async{

                          await _player.play();
                          beads.isActive = true;
                        },
                        child: RiveAnimation.asset(
                          'assets/image/new_file.riv',
                          alignment: Alignment.centerLeft,
                          controllers: [beads],
                          stateMachines: ['Trigger 1'],
                          placeHolder: Text('faran'),
                        )),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Thread extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double height = size.height;
    double width = size.width;
    Paint _paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    //
    // Path path = Path();
    // path.moveTo(0, height / 1.7);
    // path.lineTo(width / 2, height / 2.2);
    // // path.quadraticBezierTo(x1, y1, width, height/2.2);
    // canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
    throw UnimplementedError();
  }
}
