import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/database.dart';
import 'package:gowild_mobile/services/firebase_storage.dart';
import 'package:gowild_mobile/utils/camera_services.dart';
import 'package:gowild_mobile/views/profile/widgets/profile_header.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';
import 'package:gowild_mobile/widgets/outlined_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? firstNameController;
  String? lastNameController;
  String? userNameController;
  String? emailController;
  final FocusNode firstNameFocus = FocusNode();
  final FocusNode lastNameFocus = FocusNode();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  String? imageBase64;

  bool isLoading = false;

  void editProfile() async {
    if (firstNameController!.isEmpty || firstNameController!.length < 2) {
      firstNameFocus.requestFocus();
      return;
    }
    if (lastNameController!.isEmpty || lastNameController!.length < 2) {
      lastNameFocus.requestFocus();
      return;
    }
    if (userNameController!.isEmpty) {
      userNameFocus.requestFocus();
      return;
    }
    if (emailController!.isEmpty ||
        EmailValidator.validate(emailController!) == false) {
      emailFocus.requestFocus();
      return;
    }
    setState(() {
      isLoading = true;
    });
    final Map<String, dynamic> details = {
      'full_name': '$firstNameController $lastNameController',
      'username': emailController,
      'email': emailController == widget.user.email ? null : emailController,
      'profile_photo': imageBase64,
    };
    await Database.editProfile(details);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  List<String> parseName = [];

  @override
  void initState() {
    super.initState();
    parseName = widget.user.fullName!.split(" ");
    firstNameController = parseName[0];
    lastNameController = parseName[1];
    userNameController = '';
    emailController = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    List<String> parseName = widget.user.fullName!.split(" ");
    return Scaffold(
      appBar: CustomAppBar(
        titleText: 'EDIT PROFILE',
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(children: [
            ProfileHeader(
              forChangingPhoto: true,
              imageAsset:
                  imageBase64 != null ? imageBase64 : widget.user.profileImg,
              changePhotoButtonTap: () async {
                final Map<String, dynamic>? file =
                    await CameraServices.pickPicture();
                print(file);
                final String? downloadUrl = await FBStorage.uploadPicture(
                  file!['file'],
                  file['file_name'],
                );
                print(downloadUrl);
                setState(() {});
              },
            ),
            SizedBox(
              height: 65,
            ),
            OutlinedTextField(
              title: 'First name',
              initialValue: parseName[0],
              focus: firstNameFocus,
              onChanged: (String? val) {
                firstNameController = val;
              },
            ),
            OutlinedTextField(
              title: 'Last name',
              initialValue: parseName[1],
              focus: lastNameFocus,
              onChanged: (String? val) {
                lastNameController = val;
              },
            ),
            OutlinedTextField(
              title: 'Username',
              // initialValue: widget.user.,
              // controller: userNameController,
              focus: userNameFocus,
              onChanged: (String? val) {
                userNameController = val;
              },
            ),
            OutlinedTextField(
              title: 'Email',
              initialValue: widget.user.email,
              // controller: emailController,
              focus: emailFocus,
              onChanged: (String? val) {
                emailController = val;
              },
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: GrassThemedButton(
          title: 'Save',
          onTap: editProfile,
          loading: isLoading,
        ),
      ),
    );
  }
}
