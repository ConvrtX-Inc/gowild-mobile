# gowild_api.api.FilesApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**filesControllerDownload**](FilesApi.md#filescontrollerdownload) | **GET** /api/v1/files/{path} | 
[**filesControllerUploadFile**](FilesApi.md#filescontrolleruploadfile) | **POST** /api/v1/files/upload | 


# **filesControllerDownload**
> filesControllerDownload(path)



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getFilesApi();
final String path = path_example; // String | 

try {
    api.filesControllerDownload(path);
} catch on DioError (e) {
    print('Exception when calling FilesApi->filesControllerDownload: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **path** | **String**|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **filesControllerUploadFile**
> FileEntity filesControllerUploadFile(file)



### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getFilesApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.filesControllerUploadFile(file);
    print(response);
} catch on DioError (e) {
    print('Exception when calling FilesApi->filesControllerUploadFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**FileEntity**](FileEntity.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

