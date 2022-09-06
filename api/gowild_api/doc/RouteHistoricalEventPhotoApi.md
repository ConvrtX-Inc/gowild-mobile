# gowild_api.api.RouteHistoricalEventPhotoApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**](RouteHistoricalEventPhotoApi.md#createonebaseroutehistoricaleventphotocontrollerroutehistoricaleventphoto) | **POST** /api/v1/route-historical-event-photo | Create one RouteHistoricalEventPhoto
[**deleteOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**](RouteHistoricalEventPhotoApi.md#deleteonebaseroutehistoricaleventphotocontrollerroutehistoricaleventphoto) | **DELETE** /api/v1/route-historical-event-photo/{id} | Delete one RouteHistoricalEventPhoto
[**getManyBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**](RouteHistoricalEventPhotoApi.md#getmanybaseroutehistoricaleventphotocontrollerroutehistoricaleventphoto) | **GET** /api/v1/route-historical-event-photo | Retrieve many RouteHistoricalEventPhoto
[**getOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**](RouteHistoricalEventPhotoApi.md#getonebaseroutehistoricaleventphotocontrollerroutehistoricaleventphoto) | **GET** /api/v1/route-historical-event-photo/{id} | Retrieve one RouteHistoricalEventPhoto
[**updateOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**](RouteHistoricalEventPhotoApi.md#updateonebaseroutehistoricaleventphotocontrollerroutehistoricaleventphoto) | **PATCH** /api/v1/route-historical-event-photo/{id} | Update one RouteHistoricalEventPhoto


# **createOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**
> RouteHistoricalEventPhoto createOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(routeHistoricalEventPhoto)

Create one RouteHistoricalEventPhoto

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventPhotoApi();
final RouteHistoricalEventPhoto routeHistoricalEventPhoto = ; // RouteHistoricalEventPhoto | 

try {
    final response = api.createOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(routeHistoricalEventPhoto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventPhotoApi->createOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **routeHistoricalEventPhoto** | [**RouteHistoricalEventPhoto**](RouteHistoricalEventPhoto.md)|  | 

### Return type

[**RouteHistoricalEventPhoto**](RouteHistoricalEventPhoto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**
> deleteOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id)

Delete one RouteHistoricalEventPhoto

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventPhotoApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventPhotoApi->deleteOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto: $e\n');
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

# **getManyBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**
> GetManyRouteHistoricalEventPhotoResponseDto getManyBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many RouteHistoricalEventPhoto

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventPhotoApi();
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
    final response = api.getManyBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventPhotoApi->getManyBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto: $e\n');
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

[**GetManyRouteHistoricalEventPhotoResponseDto**](GetManyRouteHistoricalEventPhotoResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**
> RouteHistoricalEventPhoto getOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id, fields, join, cache)

Retrieve one RouteHistoricalEventPhoto

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventPhotoApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventPhotoApi->getOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto: $e\n');
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

[**RouteHistoricalEventPhoto**](RouteHistoricalEventPhoto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto**
> RouteHistoricalEventPhoto updateOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id, routeHistoricalEventPhoto)

Update one RouteHistoricalEventPhoto

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventPhotoApi();
final String id = id_example; // String | 
final RouteHistoricalEventPhoto routeHistoricalEventPhoto = ; // RouteHistoricalEventPhoto | 

try {
    final response = api.updateOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto(id, routeHistoricalEventPhoto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventPhotoApi->updateOneBaseRouteHistoricalEventPhotoControllerRouteHistoricalEventPhoto: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **routeHistoricalEventPhoto** | [**RouteHistoricalEventPhoto**](RouteHistoricalEventPhoto.md)|  | 

### Return type

[**RouteHistoricalEventPhoto**](RouteHistoricalEventPhoto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

