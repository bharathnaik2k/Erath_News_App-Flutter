import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SliderNewsDetails extends StatelessWidget {
  final dynamic dataImage;
  const SliderNewsDetails({super.key, required this.dataImage});

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = DateTime.parse(dataImage["publishedAt"]);
    String formattedDate =
        DateFormat('dd/MM/yyyy  hh:mm a').format(parsedDate.toLocal());
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
                dataImage["title"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 65, 118),
                ),
              ),
              const SizedBox(height: 12.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: dataImage["urlToImage"] == null
                    ? const Center(
                        child: Padding(
                        padding: EdgeInsets.all(90.0),
                        child: Text("No Image"),
                      ))
                    : Image.network(
                        dataImage?["urlToImage"],
                      ),
              ),
              const SizedBox(height: 12.0),
              Text(
                dataImage["description"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  Text(
                    formattedDate,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 138, 78, 0)),
                  ),
                  const Spacer(),
                  Text(
                    "🖋️ ${dataImage["author"]}",
                    style:
                        const TextStyle(color: Color.fromARGB(255, 138, 78, 0)),
                  )
                ],
              ),
              const SizedBox(height: 12.0),
              Text(dataImage["content"]),
            ],
          ),
        ),
      ),
    );
  }
}
