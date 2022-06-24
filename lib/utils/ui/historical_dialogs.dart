import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/image_constants.dart';
import 'package:gowild_mobile/widgets/grass_themed_button.dart';

class HistoricalDialogs {
    showPlainText(BuildContext context, String content) {
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext ctx, animation, _animation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    '${ImageAssetPath.imagePathPng}scroll.png',
                    height: MediaQuery.of(context).size.height * 0.60,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 125,
                    child: Container(
                      margin: EdgeInsets.only(top: 18),
                      width: 300,
                      child: Text(
                        content,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'TheForegenRoughOne'),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 95,
                    left: 55,
                    child: Text(
                      'Did you know?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, fontFamily: 'TheForegenRoughOne'),
                    ),
                  ),
                  Positioned(
                    bottom: 104,
                    child: SizedBox(
                      width: 242,
                      height: 49,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const GrassThemedButton(
                          title: 'Got It',
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

    showWithImage(BuildContext context, String imageUrl, String title) {
    showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext ctx, animation, _animation) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(
                    '${ImageAssetPath.imagePathPng}scroll.png',
                    height: MediaQuery.of(context).size.height * 0.60,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    right: 26,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 35,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    child: Container(
                      margin: const EdgeInsets.only(top: 18),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image:   DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageUrl))),
                      width: 300,
                      height: 220,
                      // child:  Image.network('https://www.roadaffair.com/wp-content/uploads/2017/12/taj-mahal-india-shutterstock_180918317-1024x683.jpg'),
                    ),
                  ),
                    Positioned(
                    bottom: 104,
                    child: Text(
                     title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, fontFamily: 'TheForegenRoughOne'),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
