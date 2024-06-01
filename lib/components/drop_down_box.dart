import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';

class MyDropdown extends StatefulWidget {
  final List<String> items;
  final String hintText;
  final ValueNotifier<String?> controller;

  const MyDropdown({
    super.key,
    required this.items,
    required this.hintText,
    required this.controller,
  });

  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: ValueListenableBuilder<String?>(
        valueListenable: widget.controller,
        builder: (context, value, child) {
          return DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              hintText: widget.hintText,
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: LOBColors.secondary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            onChanged: (newValue) {
              widget.controller.value = newValue;
            },
            items: widget.items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
