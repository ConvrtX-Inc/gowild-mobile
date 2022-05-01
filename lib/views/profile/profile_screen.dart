import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/secure_storage.dart';
import 'package:gowild_mobile/views/profile/widgets/profile_header.dart';
import 'package:gowild_mobile/widgets/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserModel> userProfile;

  @override
  void initState() {
    super.initState();
    userProfile = getUserProfile();
  }

  Future<UserModel> getUserProfile() async {
    final String? userId =
        await SecureStorage.readValue(key: SecureStorage.userIdKey);
    final dynamic response = await ApiServices().request(
        '${ApiPathConstants.usersUrl}$userId', RequestType.GET,
        needAccessToken: true);
    UserModel user = UserModel();
    print(response);
    if (response is Map<String, dynamic>) {
      if (!response.containsKey('statusCode')) {
        user = UserModel.fromJson(response);
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: 'PROFILE'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: FutureBuilder<UserModel>(
            future: userProfile,
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.hasData) {
                final UserModel user = snapshot.data!;
                return Column(
                  children: <Widget>[
                    ProfileHeader(imageAsset: user.profileImg),
                    SizedBox(
                      height: 65,
                    ),
                    Text(
                      '${user.fullName}, 23',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About Me',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                );
              }
              return Container();
            }),
      ),
    );
  }
}
