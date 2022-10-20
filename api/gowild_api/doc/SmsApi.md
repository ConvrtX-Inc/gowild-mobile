# gowild_api.api.SmsApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**smsControllerSend**](SmsApi.md#smscontrollersend) | **POST** /api/v1/sms/send | 


# **smsControllerSend**
> smsControllerSend(smsDto)



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getSmsApi();
final SmsDto smsDto = ; // SmsDto | 

try {
    api.smsControllerSend(smsDto);
} catch on DioError (e) {
    print('Exception when calling SmsApi->smsControllerSend: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **smsDto** | [**SmsDto**](SmsDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

