import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/people_also_like_model.dart';
import 'details_page.dart';
import '../../widgets/reuseable_text.dart';
import '../../models/tab_bar_model.dart';
import '../../widgets/painter.dart';
import '../../widgets/reuseabale_middle_app_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController;
  final EdgeInsetsGeometry padding =
      const EdgeInsets.symmetric(horizontal: 10.0);

  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFD2E5FD),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
            left: 10,
            right: 10,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user != null
                                  ? "Привет ${user?.email}"
                                  : "Добро пожаловать!",
                              style: TextStyle(
                                color: Colors.indigo[600],
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: size.width * 0.4,
                              child: Text(
                                user != null ? "Куда хотите?" : "Войти",
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: CircleAvatar(
                            radius: 45,
                            backgroundColor:
                                user != null ? Colors.indigo : Colors.amber,
                          ),
                        ),
                      ],
                    )),
                FadeInUp(
                  delay: const Duration(milliseconds: 600),
                  child: Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    width: size.width,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        labelPadding: EdgeInsets.only(
                            left: size.width * 0.05, right: size.width * 0.05),
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: const CircleTabBarIndicator(
                          color: Colors.indigo,
                          radius: 4,
                        ),
                        tabs: const [
                          Tab(text: "Популярные"),
                          Tab(text: "Вдохновение"),
                        ],
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    width: size.width,
                    height: size.height * 0.4,
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: [
                          TabViewChild(
                            list: places,
                          ),
                          TabViewChild(list: inspiration),
                        ]),
                  ),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  child: const MiddleAppText(text: "Многим нравится"),
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 1100),
                  child: Container(
                    margin: EdgeInsets.only(top: size.height * 0.01),
                    width: size.width,
                    height: size.height * 0.54,
                    child: ListView.builder(
                      itemCount: peopleAlsoLikeModel.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        PeopleAlsoLikeModel current =
                            peopleAlsoLikeModel[index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                personData: current,
                                tabData: null,
                                isCameFromPersonSection: true,
                              ),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            width: size.width,
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: current.year,
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    width: size.width * 0.28,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          current.image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.035,
                                      ),
                                      AppText(
                                        text: current.title,
                                        size: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.005,
                                      ),
                                      AppText(
                                        text: current.location,
                                        size: 14,
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabViewChild extends StatelessWidget {
  const TabViewChild({
    required this.list,
    Key? key,
  }) : super(key: key);

  final List<TabBarModel> list;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: list.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        TabBarModel current = list[index];
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                personData: null,
                tabData: current,
                isCameFromPersonSection: false,
              ),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Hero(
                tag: current.image,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage(current.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: size.height * 0.2,
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  width: size.width * 0.53,
                  height: size.height * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(153, 0, 0, 0),
                        Color.fromARGB(118, 29, 29, 29),
                        Color.fromARGB(54, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: size.width * 0.07,
                bottom: size.height * 0.045,
                child: AppText(
                  text: current.title,
                  size: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Positioned(
                left: size.width * 0.07,
                bottom: size.height * 0.025,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    AppText(
                      text: current.location,
                      size: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
