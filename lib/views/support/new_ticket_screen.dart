import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/utils/camera_services.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({Key? key}) : super(key: key);

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  final String cameraIcon =
      '${ImageAssetPath.imagePathSvg}${ImageAssetName.camera}';

  List<String> imageBase64List = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'SUPPORT',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subject',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Write subject here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Your message',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                minLines: 8,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: 'What would you like to tell us?',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
              SizedBox(
                height: 80,
              ),
              Align(
                  child: GestureDetector(
                      onTap: () async {
                        imageBase64List =
                            await CameraServices.pickMultiPicture();
                        setState(() {});
                      },
                      child: SvgPicture.asset(cameraIcon))),
              SizedBox(
                height: 10,
              ),
              const Align(
                child: Text(
                  'Attach images or proof',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: ListView.builder(
                    itemCount: imageBase64List.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final String imageBase64 = imageBase64List[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.memory(
                            base64Decode(
                              imageBase64,
                            ),
                            height: 130,
                            width: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: GrassThemedButton(title: 'Send Message'),
      ),
    );
  }
}
