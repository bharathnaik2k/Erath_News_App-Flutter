import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? getData;
  const NewsDetailsScreen({super.key, required this.getData});

  @override
  Widget build(BuildContext context) {
    //it's convert Zone Time To Local Time
    DateTime parsedDate = DateTime.parse(getData!["publishedAt"]);
    String formattedDate =
        DateFormat('dd/MM/yyyy - hh:mm a').format(parsedDate.toLocal());

    //scaffold
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 74, 94, 0),
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              getData!["title"] == null
                  ? const Text("No Title")
                  : Text(
                      getData!["title"],
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
                child: getData!["urlToImage"] == null
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(60.0),
                        child: Text("No Image"),
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          getData!["urlToImage"],
                        ),
                      ),
              ),
              const SizedBox(height: 12.0),
              getData!["description"] == null
                  ? const Text("No Description")
                  : Text(
                      getData!["description"],
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
                    child: getData!["author"] == null
                        ? const Text("No Name")
                        : Text(
                            getData!["author"],
                          ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              getData!["content"] == null
                  ? const Text("No Content")
                  : Text("      ${getData!["content"]}"),
            ],
          ),
        ),
      ),
    );
  }
}
