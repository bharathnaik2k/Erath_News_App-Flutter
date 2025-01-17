import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_adress.dart';
import 'package:news_app/api/apikey.dart';
import 'package:news_app/screen_Widgets/homeScreen_Widget/homescreen.dart';
import 'package:news_app/screen_Widgets/homeScreen_Widget/sportsscreen.dart';
import 'package:news_app/screen_Widgets/homeScreen_Widget/techworldscreen.dart';
import 'package:news_app/screen_Widgets/homeScreen_Widget/trendingscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageWidget();
}

class _HomePageWidget extends State<HomePage> {
  var dataImage = [];

  Future<dynamic> getdata() async {
    dynamic url = "$baseURL$topSilderNewsURL$apiKey";
    dynamic uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      for (var image in decode["articles"]) {
        setState(() {
          dataImage.add(image);
        });
      }
    } else {
      log("${response.statusCode}");
    }
    return null;
  }

  List<Map<String, dynamic>?> mainLineData = [];

  Future<dynamic> getMainLineNewsdata() async {
    dynamic url = "$baseURL$mainLine$apiKey";
    dynamic uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      for (var image in decode["articles"]) {
        setState(() {
          mainLineData.add(image);
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

  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  int pageIndex = 0;
  onPageChanged() {
    setState(() {
      pageController.jumpToPage(pageIndex);
    });
  }

  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      drawer: Drawer(
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
            )),
      ),
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
                  dataImage: dataImage,
                  mainLineData: mainLineData,
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
