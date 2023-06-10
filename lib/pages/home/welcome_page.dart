import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/welcome_model.dart';
import '../../widgets/reuseable_text.dart';
import '../wrapper/main_wrapper.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: welcomeComponents.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              WelcomeModel current = welcomeComponents[index];
              return Stack(
                children: [
                  Image.asset(
                    current.imageUrl,
                    fit: BoxFit.cover,
                    width: size.width,
                    height: size.height,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FadeInRight(
                              child: Align(
                                alignment: Alignment.center,
                                child: AppText(
                                  text: current.title,
                                  size: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            FadeInLeft(
                              child: Align(
                                alignment: Alignment.center,
                                child: AppText(
                                  text: current.subTitle,
                                  size: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            FadeInUp(
                              delay: const Duration(milliseconds: 400),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                ),
                                child: SizedBox(
                                  width: size.width * 0.8,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: AppText(
                                      text: current.description,
                                      size: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          FadeInUpBig(
                            duration: const Duration(milliseconds: 1100),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.08,
                                bottom: size.height * 0.04,
                              ),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: size.width * 0.5,
                                height: size.height * 0.055,
                                color: Colors.indigo,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MainWrapper(),
                                    ),
                                  );
                                },
                                child: const AppText(
                                  text: "Начать",
                                  size: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          FadeInUp(
                            delay: const Duration(milliseconds: 800),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (indexDots) => GestureDetector(
                                  onTap: () {
                                    pageController.animateToPage(
                                      indexDots,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.linear,
                                    );
                                  },
                                  child: AnimatedContainer(
                                    margin: EdgeInsets.only(
                                      right: size.width * 0.01,
                                      bottom: size.height * 0.008,
                                    ),
                                    width: index == indexDots ? 55 : 10,
                                    height: 10,
                                    duration: const Duration(milliseconds: 200),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: index == indexDots
                                          ? Colors.indigo
                                          : const Color.fromARGB(
                                              255,
                                              193,
                                              170,
                                              255,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
