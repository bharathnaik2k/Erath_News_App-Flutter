import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screen_Widgets/homeScreen_Widget/letestnews_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final dynamic dataImage;
  final dynamic mainLineData;

  const HomeScreen({
    super.key,
    required this.dataImage,
    required this.mainLineData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 180,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: dataImage.length,
            itemBuilder: (context, index, realIndex) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LetestNewsDetails(
                        mainLineData: dataImage[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: dataImage.isEmpty
                            ? const NetworkImage(
                                "https://www.transparenttextures.com/patterns/debut-light.png")
                            : NetworkImage(
                                dataImage[index]!["urlToImage"],
                              ),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.transparent.withOpacity(0.9),
                            Colors.transparent.withOpacity(0.0),
                            Colors.black.withOpacity(0.1),
                          ],
                        )),
                    child: dataImage.isEmpty
                        ? const SizedBox()
                        : Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "🖊️ ${dataImage[index]!["author"]}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    dataImage[index]!["title"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 14.0,
            right: 14.0,
            left: 14.0,
            bottom: 6,
          ),
          child: dataImage.isEmpty
              ? const SizedBox()
              : const Text(
                  "Letest News",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromARGB(255, 182, 12, 0)),
                ),
        ),
        Expanded(
          child: ListView.builder(
            padding:
                const EdgeInsets.only(bottom: 14.0, right: 14.0, left: 14.0),
            itemCount: mainLineData!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LetestNewsDetails(
                        mainLineData: mainLineData[index],
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        // color: const Color.fromARGB(255, 247, 255, 219),
                      ),
                      height: 90,
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color:
                                    const Color.fromARGB(255, 209, 209, 209)),
                            child: mainLineData[index]["urlToImage"] == null
                                ? const Center(child: Text("No Image"))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      "${mainLineData?[index]["urlToImage"]}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mainLineData[index]["title"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Wirter : ",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 182, 12, 0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${mainLineData[index]["author"]}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
