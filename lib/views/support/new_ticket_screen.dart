import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/services/database.dart';
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

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();

  Map<String, dynamic>? imageFileMap;

  Future<void> addTicket() async {
    if (_subjectController.text.isEmpty) {
      _subjectFocus.requestFocus();
      return;
    }

    if (_messageController.text.isEmpty) {
      _messageFocus.requestFocus();
      return;
    }

    final Map<String, dynamic> ticketDetails = {
      'subject': _subjectController.text,
      'message': _messageController.text,
      'file': imageFileMap!['file'],
      'file_name': imageFileMap!['file_name'],
      'status': 0
    };
    await Database.addTicket(ticketDetails, context);
  }

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
              const Text(
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
                controller: _subjectController,
                focusNode: _subjectFocus,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Write subject here...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
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
                controller: _messageController,
                focusNode: _messageFocus,
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
                        imageFileMap = await CameraServices.pickPicture();
                        if (imageFileMap != null) {
                          setState(() {});
                        }
                      },
                      child: SvgPicture.asset(cameraIcon))),
              SizedBox(
                height: 10,
              ),
              const Align(
                child: Text(
                  'Attach image or proof',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              if (imageFileMap != null)
                Center(
                  child: SizedBox(
                      height: 400,
                      child: Image.file(
                        File(imageFileMap!['file']),
                        fit: BoxFit.fill,
                      )),
                ),
              // CachedNetworkImage(imageUrl: imageUrl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: GrassThemedButton(
          title: 'Send Message',
          onTap: () => addTicket(),
        ),
      ),
    );
  }
}
