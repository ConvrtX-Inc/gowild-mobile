# gowild_api.api.RouteCluesApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseRouteCluesControllerRouteClue**](RouteCluesApi.md#createonebaseroutecluescontrollerrouteclue) | **POST** /api/v1/route-clues | Create one RouteClue
[**deleteOneBaseRouteCluesControllerRouteClue**](RouteCluesApi.md#deleteonebaseroutecluescontrollerrouteclue) | **DELETE** /api/v1/route-clues/{id} | Delete one RouteClue
[**getManyBaseRouteCluesControllerRouteClue**](RouteCluesApi.md#getmanybaseroutecluescontrollerrouteclue) | **GET** /api/v1/route-clues | Retrieve many RouteClue
[**getOneBaseRouteCluesControllerRouteClue**](RouteCluesApi.md#getonebaseroutecluescontrollerrouteclue) | **GET** /api/v1/route-clues/{id} | Retrieve one RouteClue
[**routeCluesControllerGetAllClues**](RouteCluesApi.md#routecluescontrollergetallclues) | **GET** /api/v1/route-clues/all-clues/{route_id} | Get all clues
[**updateOneBaseRouteCluesControllerRouteClue**](RouteCluesApi.md#updateonebaseroutecluescontrollerrouteclue) | **PATCH** /api/v1/route-clues/{id} | Update one RouteClue


# **createOneBaseRouteCluesControllerRouteClue**
> RouteClue createOneBaseRouteCluesControllerRouteClue(routeClue)

Create one RouteClue

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
final RouteClue routeClue = ; // RouteClue | 

try {
    final response = api.createOneBaseRouteCluesControllerRouteClue(routeClue);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->createOneBaseRouteCluesControllerRouteClue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **routeClue** | [**RouteClue**](RouteClue.md)|  | 

### Return type

[**RouteClue**](RouteClue.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseRouteCluesControllerRouteClue**
> deleteOneBaseRouteCluesControllerRouteClue(id)

Delete one RouteClue

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseRouteCluesControllerRouteClue(id);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->deleteOneBaseRouteCluesControllerRouteClue: $e\n');
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

# **getManyBaseRouteCluesControllerRouteClue**
> GetManyRouteClueResponseDto getManyBaseRouteCluesControllerRouteClue(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many RouteClue

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
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
    final response = api.getManyBaseRouteCluesControllerRouteClue(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->getManyBaseRouteCluesControllerRouteClue: $e\n');
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

[**GetManyRouteClueResponseDto**](GetManyRouteClueResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseRouteCluesControllerRouteClue**
> RouteClue getOneBaseRouteCluesControllerRouteClue(id, fields, join, cache)

Retrieve one RouteClue

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseRouteCluesControllerRouteClue(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->getOneBaseRouteCluesControllerRouteClue: $e\n');
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

[**RouteClue**](RouteClue.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **routeCluesControllerGetAllClues**
> routeCluesControllerGetAllClues(routeId)

Get all clues

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
final String routeId = routeId_example; // String | 

try {
    api.routeCluesControllerGetAllClues(routeId);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->routeCluesControllerGetAllClues: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **routeId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseRouteCluesControllerRouteClue**
> RouteClue updateOneBaseRouteCluesControllerRouteClue(id, routeClue)

Update one RouteClue

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteCluesApi();
final String id = id_example; // String | 
final RouteClue routeClue = ; // RouteClue | 

try {
    final response = api.updateOneBaseRouteCluesControllerRouteClue(id, routeClue);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteCluesApi->updateOneBaseRouteCluesControllerRouteClue: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **routeClue** | [**RouteClue**](RouteClue.md)|  | 

### Return type

[**RouteClue**](RouteClue.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

