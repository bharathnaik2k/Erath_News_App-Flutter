import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_adress.dart';
import 'package:news_app/api/apikey.dart';
import 'package:news_app/screen_Widgets/mainPage_Widget/home_screen.dart';
import 'package:news_app/screen_Widgets/mainPage_Widget/sports_screen.dart';
import 'package:news_app/screen_Widgets/mainPage_Widget/techworld_screen.dart';
import 'package:news_app/screen_Widgets/mainPage_Widget/trending_screen.dart';

class MainPageWidget extends StatefulWidget {
  const MainPageWidget({super.key});

  @override
  State<MainPageWidget> createState() => _MainPageWidgetWidget();
}

class _MainPageWidgetWidget extends State<MainPageWidget> {
  List<Map<String, dynamic>?> topSliderData = [];
  List<Map<String, dynamic>?> letestNewsData = [];
  PageController pageController = PageController();
  int pageIndex = 0;

  void onPageChanged() {
    setState(() {
      pageController.jumpToPage(pageIndex);
    });
  }

  Future<dynamic> getdata() async {
    dynamic url = "$baseURL$topSliderEndPoint$apiKey";
    dynamic uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      for (var image in decode["articles"]) {
        setState(() {
          topSliderData.add(image);
        });
      }
    } else {
      log("${response.statusCode}");
    }
    return null;
  }

  Future<dynamic> getMainLineNewsdata() async {
    dynamic url = "$baseURL$letestNewsEndPoint$apiKey";
    dynamic uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      for (var image in decode["articles"]) {
        setState(() {
          letestNewsData.add(image);
        });
      }
    } else {
      log("${response.statusCode}");
    }
    return null;
  }

  @override
  void initState() {
    getdata();
    getMainLineNewsdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: drawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              right: 14,
              left: 14,
              bottom: 7,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                newsSection(() {
                  setState(() {
                    pageIndex = 0;
                    pageController.jumpToPage(pageIndex);
                  });
                },
                    Text(
                      "Home",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pageIndex == 0
                            ? const Color.fromARGB(255, 182, 12, 0)
                            : Colors.black,
                      ),
                    ),
                    pageIndex == 0
                        ? const Color.fromARGB(255, 182, 12, 0)
                        : Colors.transparent),
                newsSection(() {
                  setState(() {
                    pageIndex = 1;
                    pageController.jumpToPage(pageIndex);
                  });
                },
                    Text(
                      "Trending",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pageIndex == 1
                            ? const Color.fromARGB(255, 182, 12, 0)
                            : Colors.black,
                      ),
                    ),
                    pageIndex == 1
                        ? const Color.fromARGB(255, 182, 12, 0)
                        : Colors.transparent),
                newsSection(() {
                  pageIndex = 2;
                  pageController.jumpToPage(pageIndex);
                  setState(() {});
                },
                    Text(
                      "Sports",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pageIndex == 2
                            ? const Color.fromARGB(255, 182, 12, 0)
                            : Colors.black,
                      ),
                    ),
                    pageIndex == 2
                        ? const Color.fromARGB(255, 182, 12, 0)
                        : Colors.transparent),
                newsSection(() {
                  pageIndex = 3;
                  pageController.jumpToPage(pageIndex);
                  setState(() {});
                },
                    Text(
                      "Tech World",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: pageIndex == 3
                            ? const Color.fromARGB(255, 182, 12, 0)
                            : Colors.black,
                      ),
                    ),
                    pageIndex == 3
                        ? const Color.fromARGB(255, 182, 12, 0)
                        : Colors.transparent),
              ],
            ),
          ),
          const Divider(
            endIndent: 10,
            indent: 10,
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  pageIndex = value;
                });
              },
              children: [
                HomeScreen(
                  topSliderData: topSliderData,
                  letestNewsData: letestNewsData,
                ),
                const TrendingScreen(),
                const SportsScreen(),
                const TechWorldScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  InkWell newsSection(VoidCallback ontap, Widget text, Color color) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: ontap,
      child: Column(
        children: [
          text,
          const SizedBox(height: 7),
          Container(
            height: 3,
            width: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color,
            ),
          )
        ],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 74, 94, 0),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/erathPic.png",
            ),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.newspaper,
              size: 80,
              color: Colors.white,
            ),
            Text(
              "Erath News",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 18),
            Text(
              "# WorldWide Letest News in Your Fingertip",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromARGB(255, 74, 94, 0),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Builder(
            builder: (context) {
              return InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: const Icon(
                  CupertinoIcons.line_horizontal_3,
                  color: Colors.white,
                ),
              );
            },
          ),
          const Spacer(),
          const Icon(
            Icons.newspaper,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          const Text(
            "Erath News",
            style: TextStyle(color: Colors.white),
          ),
          const Spacer(),
          const Icon(
            CupertinoIcons.search,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
