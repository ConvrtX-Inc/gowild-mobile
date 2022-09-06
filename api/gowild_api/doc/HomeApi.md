# gowild_api.api.HomeApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**homeControllerAppInfo**](HomeApi.md#homecontrollerappinfo) | **GET** /api/v1/dashboard | 


# **homeControllerAppInfo**
> homeControllerAppInfo()



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getHomeApi();

try {
    api.homeControllerAppInfo();
} catch on DioError (e) {
    print('Exception when calling HomeApi->homeControllerAppInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

