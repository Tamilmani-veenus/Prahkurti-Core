
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../../login/animation_signinpage/signin_page.dart';
import 'Animations/FadeAnimation.dart';


void main() => runApp(
    const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomePage()
    )
);

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin{

  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0, end: 0.8
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _widthController.forward();
      }
    });

    _widthController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600)
    );

    _widthAnimation = Tween<double>(
        begin: 80.0,
        end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(
        begin: 0.0,
        end: 215.0
    ).animate(_positionController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300)
    );

    _scale2Animation = Tween<double>(
        begin: 1.0,
        end: 32.0
    ).animate(_scale2Controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: const SignInPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width*100/100;
    final double height = MediaQuery.of(context).size.height * 100/100;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height,
            width: width,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -50,
                  left: 0,
                  child: FadeAnimation(1, Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/one.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  )),
                ),
                Positioned(
                  top: -100,
                  left: 0,
                  child: FadeAnimation(1.3, Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/one.png'),
                            fit: BoxFit.cover
                        )
                    ),
                  )),
                ),
                Positioned(
                  top: -150,
                  left: 0,
                  child: FadeAnimation(1.6,
                      Container(
                        width: width,
                        height: height,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/one.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      )
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      FadeAnimation(1.3, const Text("Welcome to Prahkurti Constructions",
                        style: TextStyle(color: Colors.black, fontSize: 30),)),

                      FadeAnimation(1.3, const Text("\n We extend a warm welcome to our exceptional organization, which began its journey in 2011.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.indigo, height: 1.4, fontSize: 20),)),

                      FadeAnimation(1.3, const Text("\n Use our Mobile ERP app for on-time project management and updates, all backed by our team of highly-trained engineers.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.indigo, height: 1.4, fontSize: 20),)),

                      SizedBox(height: MediaQuery.of(context).size.height * 3/100),

                      FadeAnimation(1.3, const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Text("Welcome to our Mobile ERP app, your gateway to seamless business management on the go!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.indigo, height: 1.4, fontSize: 20),),
                          ),
                        ],
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height * 10/100),
                      FadeAnimation(1.6, AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController,
                                builder: (context, child) => Container(
                                  width: _widthAnimation.value,
                                  height: 80,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.indigo.withOpacity(.4)
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController.forward();
                                    },
                                    child: Stack(
                                        children: <Widget> [
                                          AnimatedBuilder(
                                            animation: _positionController,
                                            builder: (context, child) => Positioned(
                                              left: _positionAnimation.value,
                                              child: AnimatedBuilder(
                                                animation: _scale2Controller,
                                                builder: (context, child) => Transform.scale(
                                                    scale: _scale2Animation.value,
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: Colors.indigo
                                                      ),
                                                      child: hideIcon == false ? const Icon(Icons.arrow_forward, color: Colors.white,) : Container(),
                                                    )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      )),
                      SizedBox(height: MediaQuery.of(context).size.height * 15/100),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}