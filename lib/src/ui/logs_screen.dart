import 'package:bot_network_logger/src/db/db.dart';
import 'package:bot_network_logger/src/ui/request_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'widgets/filter_bottom_sheet.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final RequestsDatabase _database = RequestsDatabase();

  RequestMethod? requestMethod;
  RequestStatus? requestStatus;
  late FormGroup formGroup;
  @override
  void initState() {
    formGroup = FormGroup({
      'keyword': FormControl<String>(),
    });
    formGroup.control('keyword').valueChanges.listen((event) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Scaffold(
          appBar: AppBar(
            title: ReactiveTextField(
              formControlName: 'keyword',
              decoration: const InputDecoration(hintText: "Search here"),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return FilterBottomSheet(
                              requestMethod: requestMethod,
                              requestStatus: requestStatus,
                              onChangeFilter: (requestMethod, requestStatus) {
                                setState(() {
                                  this.requestMethod = requestMethod;
                                  this.requestStatus = requestStatus;
                                });
                              });
                        });
                  },
                  icon: const Icon(Icons.filter_list_alt))
            ],
          ),
          body: Center(
              child: StreamBuilder<List<Request>>(
                  stream: _database.requestStream(
                      method: requestMethod,
                      status: requestStatus,
                      keyword: formGroup.control('keyword').value),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.connectionState == ConnectionState.active) {
                      List<Request>? data = snapshot.data;
                      if (data != null && data.isNotEmpty) {
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:
                                          RequestDetails(request: data[index]),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                    backgroundColor:
                                        data[index].status.getStatusColor,
                                    child: Text(
                                        data[index].method.name.toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white))),
                                title: Text(data[index].url),
                                subtitle: Text(DateFormat(
                                        "${DateFormat.ABBR_MONTH_DAY}- H:m:s")
                                    .format(data[index].createdAt)));
                          },
                        );
                      } else {
                        return const Center(
                          child: Text("Empty date"),
                        );
                      }
                    }
                    return const SizedBox();
                  }))),
    );
  }
}
