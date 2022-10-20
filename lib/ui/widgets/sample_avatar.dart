import 'package:flutter/material.dart';

class SampleAvatar extends StatelessWidget {
  const SampleAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        child: ClipOval(
          child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhvCzJ9np9hh1OAXRbgWdm1eIBpd89W7K3dw&usqp=CAU'),
        ),
      ),
    );
  }
}
