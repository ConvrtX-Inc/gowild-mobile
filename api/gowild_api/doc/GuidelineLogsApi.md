# gowild_api.api.GuidelineLogsApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseGuidelineLogsControllerGuidelineLog**](GuidelineLogsApi.md#createonebaseguidelinelogscontrollerguidelinelog) | **POST** /api/v1/guideline-logs | Create one GuidelineLog
[**deleteOneBaseGuidelineLogsControllerGuidelineLog**](GuidelineLogsApi.md#deleteonebaseguidelinelogscontrollerguidelinelog) | **DELETE** /api/v1/guideline-logs/{id} | Delete one GuidelineLog
[**getManyBaseGuidelineLogsControllerGuidelineLog**](GuidelineLogsApi.md#getmanybaseguidelinelogscontrollerguidelinelog) | **GET** /api/v1/guideline-logs | Retrieve many GuidelineLog
[**getOneBaseGuidelineLogsControllerGuidelineLog**](GuidelineLogsApi.md#getonebaseguidelinelogscontrollerguidelinelog) | **GET** /api/v1/guideline-logs/{id} | Retrieve one GuidelineLog
[**updateOneBaseGuidelineLogsControllerGuidelineLog**](GuidelineLogsApi.md#updateonebaseguidelinelogscontrollerguidelinelog) | **PATCH** /api/v1/guideline-logs/{id} | Update one GuidelineLog


# **createOneBaseGuidelineLogsControllerGuidelineLog**
> GuidelineLog createOneBaseGuidelineLogsControllerGuidelineLog(guidelineLog)

Create one GuidelineLog

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getGuidelineLogsApi();
final GuidelineLog guidelineLog = ; // GuidelineLog | 

try {
    final response = api.createOneBaseGuidelineLogsControllerGuidelineLog(guidelineLog);
    print(response);
} catch on DioError (e) {
    print('Exception when calling GuidelineLogsApi->createOneBaseGuidelineLogsControllerGuidelineLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **guidelineLog** | [**GuidelineLog**](GuidelineLog.md)|  | 

### Return type

[**GuidelineLog**](GuidelineLog.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseGuidelineLogsControllerGuidelineLog**
> deleteOneBaseGuidelineLogsControllerGuidelineLog(id)

Delete one GuidelineLog

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getGuidelineLogsApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseGuidelineLogsControllerGuidelineLog(id);
} catch on DioError (e) {
    print('Exception when calling GuidelineLogsApi->deleteOneBaseGuidelineLogsControllerGuidelineLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getManyBaseGuidelineLogsControllerGuidelineLog**
> GetManyGuidelineLogResponseDto getManyBaseGuidelineLogsControllerGuidelineLog(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many GuidelineLog

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getGuidelineLogsApi();
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final String s = s_example; // String | Adds search condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#search\" target=\"_blank\">Docs</a>
final BuiltList<String> filter = ; // BuiltList<String> | Adds filter condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#filter\" target=\"_blank\">Docs</a>
final BuiltList<String> or = ; // BuiltList<String> | Adds OR condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#or\" target=\"_blank\">Docs</a>
final BuiltList<String> sort = ; // BuiltList<String> | Adds sort by field. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#sort\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int limit = 56; // int | Limit amount of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#limit\" target=\"_blank\">Docs</a>
final int offset = 56; // int | Offset amount of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#offset\" target=\"_blank\">Docs</a>
final int page = 56; // int | Page portion of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#page\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getManyBaseGuidelineLogsControllerGuidelineLog(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling GuidelineLogsApi->getManyBaseGuidelineLogsControllerGuidelineLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fields** | [**BuiltList&lt;String&gt;**](String.md)| Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a> | [optional] 
 **s** | **String**| Adds search condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#search\" target=\"_blank\">Docs</a> | [optional] 
 **filter** | [**BuiltList&lt;String&gt;**](String.md)| Adds filter condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#filter\" target=\"_blank\">Docs</a> | [optional] 
 **or** | [**BuiltList&lt;String&gt;**](String.md)| Adds OR condition. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#or\" target=\"_blank\">Docs</a> | [optional] 
 **sort** | [**BuiltList&lt;String&gt;**](String.md)| Adds sort by field. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#sort\" target=\"_blank\">Docs</a> | [optional] 
 **join** | [**BuiltList&lt;String&gt;**](String.md)| Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a> | [optional] 
 **limit** | **int**| Limit amount of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#limit\" target=\"_blank\">Docs</a> | [optional] 
 **offset** | **int**| Offset amount of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#offset\" target=\"_blank\">Docs</a> | [optional] 
 **page** | **int**| Page portion of resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#page\" target=\"_blank\">Docs</a> | [optional] 
 **cache** | **int**| Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a> | [optional] 

### Return type

[**GetManyGuidelineLogResponseDto**](GetManyGuidelineLogResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseGuidelineLogsControllerGuidelineLog**
> GuidelineLog getOneBaseGuidelineLogsControllerGuidelineLog(id, fields, join, cache)

Retrieve one GuidelineLog

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getGuidelineLogsApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseGuidelineLogsControllerGuidelineLog(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling GuidelineLogsApi->getOneBaseGuidelineLogsControllerGuidelineLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **fields** | [**BuiltList&lt;String&gt;**](String.md)| Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a> | [optional] 
 **join** | [**BuiltList&lt;String&gt;**](String.md)| Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a> | [optional] 
 **cache** | **int**| Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a> | [optional] 

### Return type

[**GuidelineLog**](GuidelineLog.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseGuidelineLogsControllerGuidelineLog**
> GuidelineLog updateOneBaseGuidelineLogsControllerGuidelineLog(id, guidelineLog)

Update one GuidelineLog

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getGuidelineLogsApi();
final String id = id_example; // String | 
final GuidelineLog guidelineLog = ; // GuidelineLog | 

try {
    final response = api.updateOneBaseGuidelineLogsControllerGuidelineLog(id, guidelineLog);
    print(response);
} catch on DioError (e) {
    print('Exception when calling GuidelineLogsApi->updateOneBaseGuidelineLogsControllerGuidelineLog: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **guidelineLog** | [**GuidelineLog**](GuidelineLog.md)|  | 

### Return type

[**GuidelineLog**](GuidelineLog.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

