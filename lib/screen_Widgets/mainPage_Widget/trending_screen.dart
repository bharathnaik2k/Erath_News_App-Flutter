import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_adress.dart';
import 'package:news_app/api/apikey.dart';
import 'package:news_app/screen_Widgets/mainPage_Widget/news_Details_Widget/news_details_screen.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  List<Map<String, dynamic>?> trendingNewsData = [];

  Future<dynamic> getNewsData() async {
    dynamic url = "$baseURL$trendingEndPoint$apiKey";
    dynamic uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      log("${response.statusCode}");
      for (var image in decode["articles"]) {
        setState(() {
          trendingNewsData.add(image);
        });
      }
    } else {
      log("${response.statusCode}");
    }
    return null;
  }

  @override
  void initState() {
    getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return trendingNewsData.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding:
                const EdgeInsets.only(bottom: 14.0, right: 14.0, left: 14.0),
            itemCount: trendingNewsData.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewsDetailsScreen(
                        getData: trendingNewsData[index],
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
                      ),
                      height: 90,
                      child: Row(
                        children: [
                          Container(
                            height: 90,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color.fromARGB(255, 209, 209, 209),
                            ),
                            child: trendingNewsData[index]?["urlToImage"] ==
                                    null
                                ? const Center(child: Text("No Image"))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      trendingNewsData[index]?["urlToImage"],
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
                                trendingNewsData[index]?["title"] == null
                                    ? const Text("No title")
                                    : Text(
                                        trendingNewsData[index]?["title"],
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
                                      child: trendingNewsData[index]
                                                  ?["author"] ==
                                              null
                                          ? const Text("No Name")
                                          : Text(
                                              trendingNewsData[index]
                                                  ?["author"],
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
          );
  }
}
