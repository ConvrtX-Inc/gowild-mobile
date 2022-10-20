# gowild_api.api.TreasureChestApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createOneBaseTreasureChestControllerTreasureChest**](TreasureChestApi.md#createonebasetreasurechestcontrollertreasurechest) | **POST** /api/v1/treasure-chest | Create one TreasureChest
[**deleteOneBaseTreasureChestControllerTreasureChest**](TreasureChestApi.md#deleteonebasetreasurechestcontrollertreasurechest) | **DELETE** /api/v1/treasure-chest/{id} | Delete one TreasureChest
[**getManyBaseTreasureChestControllerTreasureChest**](TreasureChestApi.md#getmanybasetreasurechestcontrollertreasurechest) | **GET** /api/v1/treasure-chest | Retrieve many TreasureChest
[**getOneBaseTreasureChestControllerTreasureChest**](TreasureChestApi.md#getonebasetreasurechestcontrollertreasurechest) | **GET** /api/v1/treasure-chest/{id} | Retrieve one TreasureChest
[**updateOneBaseTreasureChestControllerTreasureChest**](TreasureChestApi.md#updateonebasetreasurechestcontrollertreasurechest) | **PATCH** /api/v1/treasure-chest/{id} | Update one TreasureChest


# **createOneBaseTreasureChestControllerTreasureChest**
> TreasureChest createOneBaseTreasureChestControllerTreasureChest(treasureChest)

Create one TreasureChest

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getTreasureChestApi();
final TreasureChest treasureChest = ; // TreasureChest | 

try {
    final response = api.createOneBaseTreasureChestControllerTreasureChest(treasureChest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TreasureChestApi->createOneBaseTreasureChestControllerTreasureChest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **treasureChest** | [**TreasureChest**](TreasureChest.md)|  | 

### Return type

[**TreasureChest**](TreasureChest.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteOneBaseTreasureChestControllerTreasureChest**
> deleteOneBaseTreasureChestControllerTreasureChest(id)

Delete one TreasureChest

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getTreasureChestApi();
final String id = id_example; // String | 

try {
    api.deleteOneBaseTreasureChestControllerTreasureChest(id);
} catch on DioError (e) {
    print('Exception when calling TreasureChestApi->deleteOneBaseTreasureChestControllerTreasureChest: $e\n');
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

# **getManyBaseTreasureChestControllerTreasureChest**
> GetManyTreasureChestResponseDto getManyBaseTreasureChestControllerTreasureChest(fields, s, filter, or, sort, join, limit, offset, page, cache)

Retrieve many TreasureChest

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getTreasureChestApi();
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
    final response = api.getManyBaseTreasureChestControllerTreasureChest(fields, s, filter, or, sort, join, limit, offset, page, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TreasureChestApi->getManyBaseTreasureChestControllerTreasureChest: $e\n');
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

[**GetManyTreasureChestResponseDto**](GetManyTreasureChestResponseDto.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOneBaseTreasureChestControllerTreasureChest**
> TreasureChest getOneBaseTreasureChestControllerTreasureChest(id, fields, join, cache)

Retrieve one TreasureChest

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getTreasureChestApi();
final String id = id_example; // String | 
final BuiltList<String> fields = ; // BuiltList<String> | Selects resource fields. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#select\" target=\"_blank\">Docs</a>
final BuiltList<String> join = ; // BuiltList<String> | Adds relational resources. <a href=\"https://github.com/nestjsx/crud/wiki/Requests#join\" target=\"_blank\">Docs</a>
final int cache = 56; // int | Reset cache (if was enabled). <a href=\"https://github.com/nestjsx/crud/wiki/Requests#cache\" target=\"_blank\">Docs</a>

try {
    final response = api.getOneBaseTreasureChestControllerTreasureChest(id, fields, join, cache);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TreasureChestApi->getOneBaseTreasureChestControllerTreasureChest: $e\n');
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

[**TreasureChest**](TreasureChest.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateOneBaseTreasureChestControllerTreasureChest**
> TreasureChest updateOneBaseTreasureChestControllerTreasureChest(id, treasureChest)

Update one TreasureChest

### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getTreasureChestApi();
final String id = id_example; // String | 
final TreasureChest treasureChest = ; // TreasureChest | 

try {
    final response = api.updateOneBaseTreasureChestControllerTreasureChest(id, treasureChest);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TreasureChestApi->updateOneBaseTreasureChestControllerTreasureChest: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **treasureChest** | [**TreasureChest**](TreasureChest.md)|  | 

### Return type

[**TreasureChest**](TreasureChest.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

