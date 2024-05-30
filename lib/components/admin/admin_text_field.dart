import 'package:flutter/material.dart';
import 'package:lob_app/common/colors.dart';

class AdminTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool hide;

  const AdminTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.hide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: TextField(
        obscureText: hide,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
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
      ),
    );
  }
}
