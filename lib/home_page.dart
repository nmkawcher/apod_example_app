import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _fetchApodData();
  }

   Map<String,dynamic>? _apodData;

  void _fetchApodData()async{

    String url = "https://api.nasa.gov/planetary/apod?api_key=CPlNKZgwzqfvKZQxkR2ArDpN1ZWAGyjrgXqrThXW";

   final response =  await http.get(Uri.parse(url));
   print("${response.body.toString()}");

   if(response.statusCode == 200){

    setState(() {
      _apodData = json.decode(response.body);
    });
   } else{
     print("exception: ${response.body}");
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NASA APOD"),),
      body: _apodData != null ? Column(
        children: [
          Text(_apodData!["title"],),
          SizedBox(height: 10),
          Image.network(
            _apodData!["url"] ?? "",
            height: 300,
          ),
          SizedBox(height: 10),
          Padding(padding: EdgeInsets.all(10),
            child:   Text(_apodData!["explanation"] ?? "No Explanation Found")
          )
        ],
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}

