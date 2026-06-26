# ProductZoningServiceTest

`ISTEST`
## Fields

### `private ALT_COUNTRY_CODE` → `String`


### `private UNMAPPED_COUNTRY_CODE` → `String`


### `private UNZONED_PRODUCT_CODE` → `String`


### `private UNZONED_PRODUCT_FAMILY` → `String`


### `private US_COUNTRY_CODE` → `String`


### `private ZONED_PRODUCT_CODE` → `String`


### `private ZONED_PRODUCT_FAMILY` → `String`


---
## Methods
### `private static void setupTestData()`

`TESTSETUP`
### `private static void setRestContext(String countryCode, String productCode)`
### `private static String getExpectedFlyZone(String countryCode, String productFamily)`
### `private static void getProductZoning_whenValidProductAndCountry_returnsPermissibleFlyZone()`

`ISTEST`
### `private static void getProductZoning_whenValidProductAndDifferentCountry_returnsMatchingFlyZone()`

`ISTEST`
### `private static void getProductZoning_whenCountryCodeHeaderMissing_defaultsToUsAndReturnsFlyZone()`

`ISTEST`
### `private static void getProductZoning_whenCountryCodeHeaderBlank_defaultsToUsAndReturnsFlyZone()`

`ISTEST`
### `private static void getProductZoning_whenCountryHasNoRegulationsForProductFamily_returnsLocalAuthoritiesMessage()`

`ISTEST`
### `private static void getProductZoning_whenCountryHasNoMapping_returnsLocalAuthoritiesMessage()`

`ISTEST`
### `private static void getProductZoning_whenProductCodeIsNull_returnsMissingProductCodeMessage()`

`ISTEST`
### `private static void getProductZoning_whenProductCodeIsBlank_returnsMissingProductCodeMessage()`

`ISTEST`
### `private static void getProductZoning_whenProductCodeDoesNotExist_returnsMissingProductCodeMessage()`

`ISTEST`
---
