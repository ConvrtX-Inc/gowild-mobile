# gowild_api.api.RouteHistoricalEventApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**](RouteHistoricalEventApi.md#createonebaseroutehistoricaleventscontrollerroutehistoricalevent) | **POST** /api/v1/route-historical-events | Create one RouteHistoricalEvent
[**deleteOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**](RouteHistoricalEventApi.md#deleteonebaseroutehistoricaleventscontrollerroutehistoricalevent) | **DELETE** /api/v1/route-historical-events/{id} | Delete one RouteHistoricalEvent
[**getManyBaseRouteHistoricalEventsControllerRouteHistoricalEvent**](RouteHistoricalEventApi.md#getmanybaseroutehistoricaleventscontrollerroutehistoricalevent) | **GET** /api/v1/route-historical-events | Retrieve many RouteHistoricalEvent
[**getOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**](RouteHistoricalEventApi.md#getonebaseroutehistoricaleventscontrollerroutehistoricalevent) | **GET** /api/v1/route-historical-events/{id} | Retrieve one RouteHistoricalEvent
[**routeHistoricalEventsControllerUpdateMedias**](RouteHistoricalEventApi.md#routehistoricaleventscontrollerupdatemedias) | **POST** /api/v1/route-historical-events/{id}/medias | 
[**routeHistoricalEventsControllerUpdatePicture**](RouteHistoricalEventApi.md#routehistoricaleventscontrollerupdatepicture) | **POST** /api/v1/route-historical-events/{id}/update-picture | 
[**updateOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**](RouteHistoricalEventApi.md#updateonebaseroutehistoricaleventscontrollerroutehistoricalevent) | **PATCH** /api/v1/route-historical-events/{id} | Update one RouteHistoricalEvent


# **createOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**
> RouteHistoricalEvent createOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(routeHistoricalEvent)

Create one RouteHistoricalEvent

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final RouteHistoricalEvent routeHistoricalEvent = ; // RouteHistoricalEvent | 

try {
    final response = api.createOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(routeHistoricalEvent);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->createOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **routeHistoricalEvent** | [**RouteHistoricalEvent**](RouteHistoricalEvent.md)|  | 

### Return type

[**RouteHistoricalEvent**](RouteHistoricalEvent.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**
> deleteOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id)

Delete one RouteHistoricalEvent

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->deleteOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent: $e\n');
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

# **getManyBaseRouteHistoricalEventsControllerRouteHistoricalEvent**
> GetManyRouteHistoricalEventResponseDto getManyBaseRouteHistoricalEventsControllerRouteHistoricalEvent(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many RouteHistoricalEvent

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
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
    final response = api.getManyBaseRouteHistoricalEventsControllerRouteHistoricalEvent(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->getManyBaseRouteHistoricalEventsControllerRouteHistoricalEvent: $e\n');
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

[**GetManyRouteHistoricalEventResponseDto**](GetManyRouteHistoricalEventResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**
> RouteHistoricalEvent getOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id, fields, join, cache)

Retrieve one RouteHistoricalEvent

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->getOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent: $e\n');
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

[**RouteHistoricalEvent**](RouteHistoricalEvent.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **routeHistoricalEventsControllerUpdateMedias**
> RouteHistoricalEvent routeHistoricalEventsControllerUpdateMedias(id, imageUpdateDto)



### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final String id = id_example; // String | 
final BuiltList<ImageUpdateDto> imageUpdateDto = ; // BuiltList<ImageUpdateDto> | 

try {
    final response = api.routeHistoricalEventsControllerUpdateMedias(id, imageUpdateDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->routeHistoricalEventsControllerUpdateMedias: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **imageUpdateDto** | [**BuiltList&lt;ImageUpdateDto&gt;**](ImageUpdateDto.md)|  | 

### Return type

[**RouteHistoricalEvent**](RouteHistoricalEvent.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **routeHistoricalEventsControllerUpdatePicture**
> RouteHistoricalEvent routeHistoricalEventsControllerUpdatePicture(id, imageUpdateDto)



### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final String id = id_example; // String | 
final ImageUpdateDto imageUpdateDto = ; // ImageUpdateDto | 

try {
    final response = api.routeHistoricalEventsControllerUpdatePicture(id, imageUpdateDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->routeHistoricalEventsControllerUpdatePicture: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **imageUpdateDto** | [**ImageUpdateDto**](ImageUpdateDto.md)|  | 

### Return type

[**RouteHistoricalEvent**](RouteHistoricalEvent.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent**
> RouteHistoricalEvent updateOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id, routeHistoricalEvent)

Update one RouteHistoricalEvent

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getRouteHistoricalEventApi();
final String id = id_example; // String | 
final RouteHistoricalEvent routeHistoricalEvent = ; // RouteHistoricalEvent | 

try {
    final response = api.updateOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent(id, routeHistoricalEvent);
    print(response);
} catch on DioError (e) {
    print('Exception when calling RouteHistoricalEventApi->updateOneBaseRouteHistoricalEventsControllerRouteHistoricalEvent: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **routeHistoricalEvent** | [**RouteHistoricalEvent**](RouteHistoricalEvent.md)|  | 

### Return type

[**RouteHistoricalEvent**](RouteHistoricalEvent.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

