# gowild_api.api.VerifyApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**verifyControllerCheckMobileVerificationToken**](VerifyApi.md#verifycontrollercheckmobileverificationtoken) | **POST** /api/v1/verify/mobile/check | 
[**verifyControllerSendPhoneVerificationToken**](VerifyApi.md#verifycontrollersendphoneverificationtoken) | **POST** /api/v1/verify/mobile/send | 


# **verifyControllerCheckMobileVerificationToken**
> verifyControllerCheckMobileVerificationToken(checkVerificationTokenDto)



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getVerifyApi();
final CheckVerificationTokenDto checkVerificationTokenDto = ; // CheckVerificationTokenDto | 

try {
    api.verifyControllerCheckMobileVerificationToken(checkVerificationTokenDto);
} catch on DioError (e) {
    print('Exception when calling VerifyApi->verifyControllerCheckMobileVerificationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **checkVerificationTokenDto** | [**CheckVerificationTokenDto**](CheckVerificationTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **verifyControllerSendPhoneVerificationToken**
> verifyControllerSendPhoneVerificationToken(sendVerificationTokenDto)



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getVerifyApi();
final SendVerificationTokenDto sendVerificationTokenDto = ; // SendVerificationTokenDto | 

try {
    api.verifyControllerSendPhoneVerificationToken(sendVerificationTokenDto);
} catch on DioError (e) {
    print('Exception when calling VerifyApi->verifyControllerSendPhoneVerificationToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sendVerificationTokenDto** | [**SendVerificationTokenDto**](SendVerificationTokenDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

