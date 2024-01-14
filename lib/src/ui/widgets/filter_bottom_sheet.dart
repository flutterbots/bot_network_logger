import 'package:bot_network_logger/src/db/db.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class FilterBottomSheet extends StatefulWidget {
  final RequestMethod? requestMethod;
  final RequestStatus? requestStatus;
  final Function(RequestMethod? requestMethod, RequestStatus? requestStatus)
      onChangeFilter;
  const FilterBottomSheet(
      {super.key,
      required this.onChangeFilter,
      this.requestMethod,
      this.requestStatus});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late FormGroup formGroup;
  @override
  void initState() {
    formGroup = FormGroup({
      'method': FormControl<RequestMethod>(),
      'status': FormControl<RequestStatus>(),
    });
    formGroup.control('method').value = (widget.requestMethod);
    formGroup.control('status').value = (widget.requestStatus);
    formGroup.control('method').valueChanges.listen((event) {
      widget.onChangeFilter(event, formGroup.control('status').value);
    });
    formGroup.control('status').valueChanges.listen((event) {
      widget.onChangeFilter(formGroup.control('method').value, event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: ReactiveForm(
        formGroup: formGroup,
        child: Column(
          children: [
            ReactiveDropdownField<RequestMethod>(
              formControlName: 'method',
              decoration: const InputDecoration(
                labelText: 'Request method',
              ),
              items: RequestMethod.values
                  .map((e) => DropdownMenuItem<RequestMethod>(
                      value: e, child: Text(e.name.toUpperCase())))
                  .toList(),
            ),
            const SizedBox(height: 10),
            ReactiveDropdownField<RequestStatus>(
                formControlName: 'status',
                decoration: const InputDecoration(
                  labelText: 'Request status',
                ),
                items: RequestStatus.values
                    .map((e) => DropdownMenuItem<RequestStatus>(
                        value: e, child: Text(e.name)))
                    .toList()),
          ],
        ),
      ),
    );
  }
}
