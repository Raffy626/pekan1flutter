import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyApiPage extends StatefulWidget {
  @override
  _MyApiPageState createState() => _MyApiPageState();
}

class _MyApiPageState extends State<MyApiPage> {
  List<dynamic> users = [];
  bool isLoading = true;
  void getApiData() async {
    try {
      var response = await Dio().get(
        'https://jsonplaceholder.typicode.com/users',
      );
      setState(() {
        users = response.data;
        isLoading = false;
      });
    } catch (e) {
      print("Error nih: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index]['name']),
                  subtitle: Text(users[index]['email']),
                );
              },
            ),
    );
  }
}
