import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LetestNewsDetails extends StatelessWidget {
  final dynamic mainLineData;
  const LetestNewsDetails({super.key, required this.mainLineData});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(mainLineData["publishedAt"]);
    String formattedDate =
        DateFormat('dd/MM/yyyy - hh:mm a').format(parsedDate.toLocal());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 74, 94, 0),
        title: const Text(
          "Top News",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text(
                mainLineData["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 65, 118),
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 195, 195),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: mainLineData["urlToImage"] == null
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(90.0),
                        child: Text("No Image"),
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          mainLineData?["urlToImage"],
                        ),
                      ),
              ),
              const SizedBox(height: 12.0),
              Text(
                mainLineData["description"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 123, 8, 0),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  const Text(
                    "Date & Time : ",
                    style: TextStyle(color: Color.fromARGB(255, 182, 12, 0)),
                  ),
                  Text(
                    formattedDate,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wirter : ",
                    style: TextStyle(color: Color.fromARGB(255, 182, 12, 0)),
                  ),
                  Expanded(
                    child: Text(
                      "${mainLineData["author"]}",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text("      ${mainLineData["content"]}"),
            ],
          ),
        ),
      ),
    );
  }
}
