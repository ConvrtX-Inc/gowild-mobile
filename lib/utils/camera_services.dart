import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

// ignore: avoid_classes_with_only_static_members
/// Camera service
class CameraServices {
  static final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery or from camera
  /// set an optional source parameter
  static Future<Map<String, dynamic>?> pickPicture(
      {ImageSource source = ImageSource.gallery}) async {
    late String imageName;
    late File file;

    final XFile? pickedImage =
        await _picker.pickImage(source: source, imageQuality: 70);

    if (pickedImage != null) {
      List<int>? imageBytes;
      file = File(pickedImage.path);
      imageName = basename(file.path);
      return {'file_name': imageName, 'file': file.path};
    }
    return null;
  }

  static Future<List<String>> pickMultiPicture(
      {ImageSource source = ImageSource.gallery}) async {
    final List<String> imageBase64List = <String>[];

    final List<XFile>? pickedImages = await _picker.pickMultiImage(
        maxWidth: 500, maxHeight: 500, imageQuality: 70);

    if (pickedImages != null || pickedImages!.isNotEmpty) {
      for (final XFile file in pickedImages) {
        List<int>? imageBytes;
        imageBytes = File(file.path).readAsBytesSync();
        imageBase64List.add(base64Encode(imageBytes));
      }
    }
    return imageBase64List;
  }
}
