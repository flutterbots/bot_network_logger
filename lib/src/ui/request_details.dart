import 'dart:convert';

import 'package:bot_network_logger/src/db/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_json_view/flutter_json_view.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RequestDetails extends StatefulWidget {
  final Request request;
  const RequestDetails({super.key, required this.request});

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  late FormGroup formGroup;
  static const kUrlKey = "url";
  static const kQueryParamsKey = "queryParams";
  static const kHeadersKey = "headers";
  static const kBodyKey = "body";
  static const kExtraKey = "extra";
  static const kResponseKey = "response";
  static const kErrorKey = "error";
  @override
  void initState() {
    formGroup = FormGroup({
      kUrlKey: FormControl<bool>(value: true),
      kQueryParamsKey: FormControl<bool>(value: true),
      kHeadersKey: FormControl<bool>(value: true),
      kBodyKey: FormControl<bool>(value: true),
      kExtraKey: FormControl<bool>(value: true),
      kResponseKey: FormControl<bool>(value: true),
      kErrorKey: FormControl<bool>(value: true),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: formGroup,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close)),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      copyTheRequest();
                    },
                    tooltip: "Copy the selected params",
                    icon: const Icon(Icons.copy))
              ],
            ),
            //checks box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                runSpacing: 1,
                spacing: 1,
                children: [
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text("URL"),
                    ReactiveCheckbox(formControlName: kUrlKey)
                  ]),
                  if (widget.request.queryParams != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Query Params"),
                      ReactiveCheckbox(formControlName: kQueryParamsKey)
                    ]),
                  if (widget.request.headers != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Headers"),
                      ReactiveCheckbox(formControlName: kHeadersKey)
                    ]),
                  if (widget.request.body != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Body"),
                      ReactiveCheckbox(formControlName: kBodyKey)
                    ]),
                  if (widget.request.extra != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Extra"),
                      ReactiveCheckbox(formControlName: kExtraKey)
                    ]),
                  if (widget.request.response != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Response"),
                      ReactiveCheckbox(formControlName: kResponseKey)
                    ]),
                  if (widget.request.error != null)
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      const Text("Error"),
                      ReactiveCheckbox(formControlName: kErrorKey)
                    ]),
                ],
              ),
            ),
            //Method , status , code
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                children: [
                  Chip(
                      side: BorderSide.none,
                      label: Text(widget.request.method.name.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.black)),
                      backgroundColor: Colors.grey.shade300),
                  const SizedBox(width: 5),
                  Chip(
                      side: BorderSide.none,
                      backgroundColor: widget.request.status.getStatusColor,
                      label: Text(widget.request.status.name.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: Colors.white))),
                  if (widget.request.statusCode != null) ...[
                    const SizedBox(width: 5),
                    Chip(
                        side: BorderSide.none,
                        backgroundColor: widget.request.status.getStatusColor,
                        label: Text(
                            widget.request.statusCode?.toString() ?? "??",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Colors.white))),
                  ],
                ],
              ),
            ),
            //values
            Expanded(child: SingleChildScrollView(child:
                ReactiveFormConsumer(builder: (context, formGroup, child) {
              return Column(children: [
                if (formGroup.control(kUrlKey).value)
                  ListTile(
                    title: const Text("URL"),
                    subtitle: Text(widget.request.url),
                  ),
                if (widget.request.queryParams != null &&
                    (formGroup.control(kQueryParamsKey).value))
                  ListTile(
                    title: const Text("Query Params"),
                    subtitle: jsonView(widget.request.queryParams!, context),
                  ),
                if (widget.request.headers != null &&
                    (formGroup.control(kHeadersKey).value))
                  ListTile(
                    title: const Text("Headers"),
                    subtitle: jsonView(widget.request.headers!, context),
                  ),
                if (widget.request.body != null &&
                    (formGroup.control(kBodyKey).value))
                  ListTile(
                    title: const Text("Body"),
                    subtitle: jsonView(widget.request.body!, context),
                  ),
                if (widget.request.extra != null &&
                    (formGroup.control(kExtraKey).value))
                  ListTile(
                      title: const Text("Extra"),
                      subtitle: jsonView(widget.request.extra!, context)),
                if (widget.request.response != null &&
                    (formGroup.control(kResponseKey).value))
                  ListTile(
                    title: const Text("Response"),
                    subtitle: jsonView(widget.request.response!, context),
                  ),
                if (widget.request.error != null &&
                    (formGroup.control(kErrorKey).value))
                  ListTile(
                      title: const Text("Error"),
                      subtitle: Text(widget.request.error!))
              ]);
            }))),
          ],
        ),
      ),
    );
  }

  Widget jsonView(String jsonString, BuildContext context) {
    return JsonView.string(jsonString,
        theme: JsonViewTheme(
          defaultTextStyle: const TextStyle(fontSize: 16),
          closeIcon: const Icon(Icons.arrow_drop_up, size: 18),
          openIcon: const Icon(Icons.arrow_drop_down, size: 18),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          keyStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600),
          viewType: JsonViewType.base,
        ));
  }

  void copyTheRequest() async {
    JsonEncoder encoder = const JsonEncoder.withIndent("     ");
    bool showUrl = formGroup.control(kUrlKey).value as bool;
    bool showQueryParams = formGroup.control(kQueryParamsKey).value as bool;
    bool showHeaders = formGroup.control(kHeadersKey).value as bool;
    bool showResponse = formGroup.control(kResponseKey).value as bool;
    bool showError = formGroup.control(kErrorKey).value as bool;
    bool showBody = formGroup.control(kBodyKey).value as bool;
    bool showExtra = formGroup.control(kExtraKey).value as bool;
    String request = "";
    request += "Method: ${widget.request.method.name.toUpperCase()} \n";
    if (widget.request.statusCode != null) {
      request += "StatusCode: ${widget.request.statusCode} \n";
    }
    if (showUrl) request += "URL: ${widget.request.url} \n";
    if (showQueryParams && widget.request.queryParams != null) {
      request +=
          "Query Params: ${encoder.convert(jsonDecode(widget.request.queryParams!))} \n";
    }
    if (showHeaders && widget.request.headers != null) {
      request +=
          "Headers: ${encoder.convert(jsonDecode(widget.request.headers!))} \n";
    }
    if (showBody && widget.request.body != null) {
      request +=
          "Body: ${encoder.convert(jsonDecode(widget.request.body!))} \n";
    }
    if (showExtra && widget.request.extra != null) {
      request +=
          "Extra: ${encoder.convert(jsonDecode(widget.request.extra!))} \n";
    }
    if (showResponse && widget.request.response != null) {
      request +=
          "Response: ${encoder.convert(jsonDecode(widget.request.response!))} \n";
    }
    if (showError && widget.request.error != null) {
      request += "Error: ${widget.request.error!} \n";
    }
    await Clipboard.setData(ClipboardData(text: request));
  }
}
