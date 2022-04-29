import 'package:flutter/material.dart';

class OutlinedTextField extends StatelessWidget {
  const OutlinedTextField(
      {required this.title, Key? key, this.controller, this.hintText})
      : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 16, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          // obscureText: obscureText,
          controller: controller,
          cursorColor: const Color(0xff6B6968),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6B6968), width: 2.0),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xff6B6968), width: 2.0)),
            contentPadding: // Text Field height
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            hintText: hintText,
            hintStyle: const TextStyle(
                // height: 3,
                color: Color(0xff6B6968),
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
