import 'package:bot_network_logger/src/db/db.dart';
import 'package:flutter/material.dart';

class LogsScreen extends StatefulWidget {
  static String pageName = "logs_screen";
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final RequestsDatabase _database = RequestsDatabase();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
            child: StreamBuilder<List<Request>>(
                stream: _database.requestStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Request>? data = snapshot.data;
                    if (data != null) {
                      return Column(
                        children: [
                          ...List.generate(data.length, (index) {
                            return ListTile(
                              title: Text(data[index].url),
                              subtitle:
                                  Text(data[index].createdAt.toIso8601String()),
                            );
                          })
                        ],
                      );
                    }
                  }
                  return const SizedBox();
                })),
      ),
    );
  }
}
