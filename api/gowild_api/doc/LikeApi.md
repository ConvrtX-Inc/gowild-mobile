# gowild_api.api.LikeApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseLikeControllerLike**](LikeApi.md#createonebaselikecontrollerlike) | **POST** /api/v1/like | Create one Like
[**deleteOneBaseLikeControllerLike**](LikeApi.md#deleteonebaselikecontrollerlike) | **DELETE** /api/v1/like/{id} | Delete one Like
[**getManyBaseLikeControllerLike**](LikeApi.md#getmanybaselikecontrollerlike) | **GET** /api/v1/like | Retrieve many Like
[**getOneBaseLikeControllerLike**](LikeApi.md#getonebaselikecontrollerlike) | **GET** /api/v1/like/{id} | Retrieve one Like
[**updateOneBaseLikeControllerLike**](LikeApi.md#updateonebaselikecontrollerlike) | **PATCH** /api/v1/like/{id} | Update one Like


# **createOneBaseLikeControllerLike**
> Like createOneBaseLikeControllerLike(like)

Create one Like

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getLikeApi();
final Like like = ; // Like | 

try {
    final response = api.createOneBaseLikeControllerLike(like);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LikeApi->createOneBaseLikeControllerLike: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **like** | [**Like**](Like.md)|  | 

### Return type

[**Like**](Like.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseLikeControllerLike**
> deleteOneBaseLikeControllerLike(id)

Delete one Like

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getLikeApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseLikeControllerLike(id);
} catch on DioError (e) {
    print('Exception when calling LikeApi->deleteOneBaseLikeControllerLike: $e\n');
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

# **getManyBaseLikeControllerLike**
> GetManyLikeResponseDto getManyBaseLikeControllerLike(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many Like

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getLikeApi();
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
    final response = api.getManyBaseLikeControllerLike(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LikeApi->getManyBaseLikeControllerLike: $e\n');
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

[**GetManyLikeResponseDto**](GetManyLikeResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseLikeControllerLike**
> Like getOneBaseLikeControllerLike(id, fields, join, cache)

Retrieve one Like

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getLikeApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseLikeControllerLike(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LikeApi->getOneBaseLikeControllerLike: $e\n');
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

[**Like**](Like.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseLikeControllerLike**
> Like updateOneBaseLikeControllerLike(id, like)

Update one Like

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getLikeApi();
final String id = id_example; // String | 
final Like like = ; // Like | 

try {
    final response = api.updateOneBaseLikeControllerLike(id, like);
    print(response);
} catch on DioError (e) {
    print('Exception when calling LikeApi->updateOneBaseLikeControllerLike: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **like** | [**Like**](Like.md)|  | 

### Return type

[**Like**](Like.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

