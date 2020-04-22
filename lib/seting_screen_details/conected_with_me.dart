import 'package:flutter/material.dart';
import '../widgets/bottom.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  var facebook = "https://www.facebook.com/akhattab595";

  var youtube =
      "https://www.youtube.com/channel/UCFjmzpkzphmZe6-Kl2r1c8w?view_as=subscriber";
  void openfacebook() async {
    await launch(facebook);
  }

  void openyoutube() async {
    await launch(youtube);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      color: Color(0xff00BFA5),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Plane(),
              AnimatedTranslate(),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        height: 50.0,
                        width: 95.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: openfacebook,
                            child: Row(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      'FaceBook',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Montserrat'),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Container(
                        height: 50.0,
                        width: 80.0,
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          shadowColor: Colors.blueAccent,
                          color: Colors.blue,
                          elevation: 7.0,
                          child: GestureDetector(
                            onTap: openyoutube,
                            child: Row(
                              children: <Widget>[
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Text(
                                      'Youtube',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Montserrat'),
                                      textDirection: TextDirection.rtl,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 24.0,
              ),
              AnimatedHeritage(),
            ],
          ),
        ],
      ),
    );
  }
}

class AnimatedHeritage extends StatefulWidget {
  @override
  _AnimatedHeritageState createState() => _AnimatedHeritageState();
}

class _AnimatedHeritageState extends State<AnimatedHeritage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  bool show = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: 3.14 * 0.20, end: -3.14 * 0.20).animate(curve);
    controller.addStatusListener((_) async {
      if (controller.status == AnimationStatus.completed) {
        setState(() {
          show = !show;
        });
        if (controller != null) {
          controller.reset();
          controller.forward();
        }
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 100.0,
          color: show ? Colors.red : Colors.yellow,
          margin: EdgeInsets.only(bottom: 4.0),
        ),
        Image.asset(
          'assets/images/lucknow_heritage.png',
          height: 120.0,
        ),
      ],
    );
  }
}

class AnimatedTranslate extends StatefulWidget {
  @override
  _AnimatedTranslateState createState() => _AnimatedTranslateState();
}

class _AnimatedTranslateState extends State<AnimatedTranslate>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool show = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation = Tween(begin: 0.0, end: -30.0).animate(curve);
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (controller != null) controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        if (controller != null) controller.forward();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/lucknow.png',
          height: 180.0,
        ),
        Transform.translate(
          offset: Offset(0.0, animation.value - 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Material(
                shape: CircleBorder(),
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/assets.jpg'),
                    radius: 30.0,
                  ),
                ),
              ),
              Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Plane extends StatefulWidget {
  @override
  _PlaneState createState() => _PlaneState();
}

class _PlaneState extends State<Plane> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  bool show = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    controller = AnimationController(
        duration: Duration(milliseconds: 10000), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: Curves.linear);
    animation =
        Tween(begin: 0.0, end: -(MediaQuery.of(context).size.width + 500.0))
            .animate(curve);

    controller.addListener(() {
      setState(() {});
    });
    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(Duration(milliseconds: 600));
        if (controller != null) {
          controller.reset();
          controller.forward();
        }
      } else if (status == AnimationStatus.dismissed) {
        if (controller != null) controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.translate(
          offset: Offset(
              MediaQuery.of(context).size.width + animation.value + 100.0,
              -28.0),
          child: Image.asset('assets/images/pp.png'),
        ),
      ],
    );
  }
}
