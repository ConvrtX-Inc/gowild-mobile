import 'package:test/test.dart';
import 'package:gowild_api/gowild_api.dart';


/// tests for FilesApi
void main() {
  final instance = GowildApi().getFilesApi();

  group(FilesApi, () {
    //Future filesControllerDownload(String path) async
    test('test filesControllerDownload', () async {
      // TODO
    });

    //Future filesControllerUploadFile({ MultipartFile file }) async
    test('test filesControllerUploadFile', () async {
      // TODO
    });

  });
}
