import 'package:bot_network_logger/bot_network_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _posts = [];
  late final Dio dio;

  @override
  void initState() {
    super.initState();
    dio = Dio();
    dio.interceptors.add(BotNetworkLogInterceptor());
    fetchData();
  }

  Future<void> fetchData() async {
    Response response =
        await dio.get("https://jsonplaceholder.typicode.com/posts");
    setState(() {
      _posts = response.data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_posts[index]['title']),
              subtitle: Text(_posts[index]['body']),
            );
          },
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Example',
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (context, child) {
        return BotNetworkLogOverlay(
          child: child!,
        );
      },
    );
  }
}
