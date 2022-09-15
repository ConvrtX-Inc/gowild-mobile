# gowild_api.api.AuthApi

## Load the API package
```dart
import 'package:gowild_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerForgotPassword**](AuthApi.md#authcontrollerforgotpassword) | **POST** /api/v1/auth/forgot/password | Request forgot password
[**authControllerGenerateAdmin**](AuthApi.md#authcontrollergenerateadmin) | **GET** /api/v1/auth/generate-admin | Generates default admin
[**authControllerLogin**](AuthApi.md#authcontrollerlogin) | **POST** /api/v1/auth/login | Login account
[**authControllerLogout**](AuthApi.md#authcontrollerlogout) | **GET** /api/v1/auth/logout | 
[**authControllerMe**](AuthApi.md#authcontrollerme) | **GET** /api/v1/auth/me | 
[**authControllerRefreshToken**](AuthApi.md#authcontrollerrefreshtoken) | **POST** /api/v1/auth/refresh-token | Refresh token using a previous RefreshToken
[**authControllerRegister**](AuthApi.md#authcontrollerregister) | **POST** /api/v1/auth/register | Register new account
[**authControllerResetAdminPassword**](AuthApi.md#authcontrollerresetadminpassword) | **POST** /api/v1/auth/reset-admin-password | Reset password for default admin
[**authControllerResetPassword**](AuthApi.md#authcontrollerresetpassword) | **POST** /api/v1/auth/reset/password | Reset user password
[**authFacebookControllerLogin**](AuthApi.md#authfacebookcontrollerlogin) | **POST** /api/v1/auth/facebook/login | Login using facebook
[**authGoogleControllerLogin**](AuthApi.md#authgooglecontrollerlogin) | **POST** /api/v1/auth/google/login | Login using google


# **authControllerForgotPassword**
> authControllerForgotPassword(authForgotPasswordDto)

Request forgot password

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthForgotPasswordDto authForgotPasswordDto = ; // AuthForgotPasswordDto | 

try {
    api.authControllerForgotPassword(authForgotPasswordDto);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerForgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authForgotPasswordDto** | [**AuthForgotPasswordDto**](AuthForgotPasswordDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerGenerateAdmin**
> UserEntity authControllerGenerateAdmin()

Generates default admin

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();

try {
    final response = api.authControllerGenerateAdmin();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerGenerateAdmin: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerLogin**
> TokenResponse authControllerLogin(authEmailLoginDto)

Login account

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthEmailLoginDto authEmailLoginDto = ; // AuthEmailLoginDto | 

try {
    final response = api.authControllerLogin(authEmailLoginDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authEmailLoginDto** | [**AuthEmailLoginDto**](AuthEmailLoginDto.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerLogout**
> authControllerLogout()



### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();

try {
    api.authControllerLogout();
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerLogout: $e\n');
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

# **authControllerMe**
> UserEntity authControllerMe()



### Example
```dart
import 'package:gowild_api/api.dart';
// TODO Configure HTTP basic authorization: bearer
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').username = 'YOUR_USERNAME'
//defaultApiClient.getAuthentication<HttpBasicAuth>('bearer').password = 'YOUR_PASSWORD';

final api = GowildApi().getAuthApi();

try {
    final response = api.authControllerMe();
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerMe: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerRefreshToken**
> TokenResponse authControllerRefreshToken(authRefreshTokenDto)

Refresh token using a previous RefreshToken

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthRefreshTokenDto authRefreshTokenDto = ; // AuthRefreshTokenDto | 

try {
    final response = api.authControllerRefreshToken(authRefreshTokenDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerRefreshToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authRefreshTokenDto** | [**AuthRefreshTokenDto**](AuthRefreshTokenDto.md)|  | 

### Return type

[**TokenResponse**](TokenResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerRegister**
> UserEntity authControllerRegister(authRegisterLoginDto)

Register new account

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthRegisterLoginDto authRegisterLoginDto = ; // AuthRegisterLoginDto | 

try {
    final response = api.authControllerRegister(authRegisterLoginDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerRegister: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authRegisterLoginDto** | [**AuthRegisterLoginDto**](AuthRegisterLoginDto.md)|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerResetAdminPassword**
> UserEntity authControllerResetAdminPassword(authResetPasswordAdminDto)

Reset password for default admin

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthResetPasswordAdminDto authResetPasswordAdminDto = ; // AuthResetPasswordAdminDto | 

try {
    final response = api.authControllerResetAdminPassword(authResetPasswordAdminDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerResetAdminPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authResetPasswordAdminDto** | [**AuthResetPasswordAdminDto**](AuthResetPasswordAdminDto.md)|  | 

### Return type

[**UserEntity**](UserEntity.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerResetPassword**
> authControllerResetPassword(authResetPasswordDto)

Reset user password

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthResetPasswordDto authResetPasswordDto = ; // AuthResetPasswordDto | 

try {
    api.authControllerResetPassword(authResetPasswordDto);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authControllerResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authResetPasswordDto** | [**AuthResetPasswordDto**](AuthResetPasswordDto.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authFacebookControllerLogin**
> UserAuthResponse authFacebookControllerLogin(authFacebookLoginDto)

Login using facebook

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthFacebookLoginDto authFacebookLoginDto = ; // AuthFacebookLoginDto | 

try {
    final response = api.authFacebookControllerLogin(authFacebookLoginDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authFacebookControllerLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authFacebookLoginDto** | [**AuthFacebookLoginDto**](AuthFacebookLoginDto.md)|  | 

### Return type

[**UserAuthResponse**](UserAuthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authGoogleControllerLogin**
> UserAuthResponse authGoogleControllerLogin(authGoogleLoginDto)

Login using google

### Example
```dart
import 'package:gowild_api/api.dart';

final api = GowildApi().getAuthApi();
final AuthGoogleLoginDto authGoogleLoginDto = ; // AuthGoogleLoginDto | 

try {
    final response = api.authGoogleControllerLogin(authGoogleLoginDto);
    print(response);
} catch on DioError (e) {
    print('Exception when calling AuthApi->authGoogleControllerLogin: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **authGoogleLoginDto** | [**AuthGoogleLoginDto**](AuthGoogleLoginDto.md)|  | 

### Return type

[**UserAuthResponse**](UserAuthResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

