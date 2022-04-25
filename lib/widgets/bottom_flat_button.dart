import 'package:flutter/material.dart';

class BottomFlatButton extends StatelessWidget {
  const BottomFlatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () {},
          child: Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment(0.7, -0.5),
                end: Alignment(0.6, 0.5),
                colors: [
                  Color(0xFFFA7C47),
                  Color(0xFFE4572E),
                ],
              ),
            ),
            child: const Icon(Icons.photo_camera, size: 20),
          ),
        ),
      ),
    );
  }
}
