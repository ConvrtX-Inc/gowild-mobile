import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/api_services.dart';
import 'package:gowild_mobile/services/dio_client.dart';
import 'package:gowild_mobile/services/geolocation_service.dart';
import 'package:gowild_mobile/services/secure_storage.dart';
import 'package:gowild_mobile/views/profile/profile_screen.dart';
import 'package:gowild_mobile/widgets/search_textfield.dart';
import '../helper/authentication_helper.dart';
import '../root.dart';
import '../widgets/expandable_listview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> nameList = ['ROUTES'];
  late Future<UserModel> users;

  UserModel currentUser = UserModel();
  @override
  void initState() {
    users = DioClient().getUser();
    // TODO: implement initState
    super.initState();

    GeoLocationServices().requestPermissions();

    getUserProfile();

  }

  Future<void> getUserProfile() async {
    final String? userId =
    await SecureStorage.readValue(key: SecureStorage.userIdKey);
    final dynamic response = await ApiServices().request(
        '${ApiPathConstants.usersUrl}$userId', RequestType.GET,
        needAccessToken: true);

    print(response);
    if (response is Map<String, dynamic>) {
      if (!response.containsKey('statusCode')) {
        setState(() {
          currentUser = UserModel.fromJson(response);
        });
      }
    }

  }

  // final dragController = DragController();
  buildRowNameAndAvatar(String username) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            username,
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.white, // border color
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2), // border width
              child: GestureDetector(
              /*  onDoubleTap: () {
                  // var helper =
                  //     Provider.of<AuthenticationHelper>(context, listen: false);

                  // print(helper.);

                  AuthenticationHelper().onSignOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Root()),
                      (route) => false);
                },*/
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                },
                child: Container(
                  decoration:   BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                    image: currentUser.profileImg!.isNotEmpty ?  DecorationImage(
                      image: NetworkImage(
                          currentUser.profileImg!),
                      fit: BoxFit.cover,
                    ) : DecorationImage(image: AssetImage('${ImageAssetPath.imagePathPng}${ImageAssetName.profilePlaceHolder}')),
                  ),
                  child: Container(), // inner content
                ),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_bcg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
       body: Stack(children: [
         Positioned(
             top: 0,
             bottom: 0,
             left: 0,
             right: 0,
             child: ListView(
               physics: const NeverScrollableScrollPhysics(),
               children: [
                 Padding(
                   padding: const EdgeInsets.only(
                       top: 20, left: 20, right: 20),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: const [
                           Text(
                             'GOOD AFTERNOON,',
                             style: TextStyle(
                                 color: Colors.white, fontSize: 22),
                           ),
                         ],
                       ),
                       buildRowNameAndAvatar(
                           currentUser.fullName ?? ''),
                       const SizedBox(
                         height: 20,
                       ),
                       // buildSearchTextField(),
                       const SizedBox(
                         height: 20,
                       ),
                       ListView.builder(
                         physics: const NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                         itemBuilder: (BuildContext context, int index) {
                           return ExpandableListView(
                               title: nameList[index]);
                         },
                         itemCount: nameList.length,
                       ),
                     ],
                   ),
                 ),
               ],
             )),
       ])
       /* body: FutureBuilder<UserModel>(
          future: users,
          builder: (context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.hasData) {
              return Stack(children: [
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'GOOD AFTERNOON,',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ),
                              buildRowNameAndAvatar(
                                  snapshot.data!.fullName ?? ''),
                              const SizedBox(
                                height: 20,
                              ),
                              // buildSearchTextField(),
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ExpandableListView(
                                      title: nameList[index]);
                                },
                                itemCount: nameList.length,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ]);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),*/
      ),
    );
  }
}
