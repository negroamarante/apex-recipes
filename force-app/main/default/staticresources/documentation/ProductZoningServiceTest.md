# ProductZoningServiceTest Class

`ISTEST`

## Fields
### `ZONED_PRODUCT_CODE`

#### Signature
```apex
private static final ZONED_PRODUCT_CODE
```

#### Type
String

---

### `UNZONED_PRODUCT_CODE`

#### Signature
```apex
private static final UNZONED_PRODUCT_CODE
```

#### Type
String

---

### `ZONED_PRODUCT_FAMILY`

#### Signature
```apex
private static final ZONED_PRODUCT_FAMILY
```

#### Type
String

---

### `UNZONED_PRODUCT_FAMILY`

#### Signature
```apex
private static final UNZONED_PRODUCT_FAMILY
```

#### Type
String

---

### `US_COUNTRY_CODE`

#### Signature
```apex
private static final US_COUNTRY_CODE
```

#### Type
String

---

### `ALT_COUNTRY_CODE`

#### Signature
```apex
private static final ALT_COUNTRY_CODE
```

#### Type
String

---

### `UNMAPPED_COUNTRY_CODE`

#### Signature
```apex
private static final UNMAPPED_COUNTRY_CODE
```

#### Type
String

## Methods
### `setupTestData()`

`TESTSETUP`

#### Signature
```apex
private static void setupTestData()
```

#### Return Type
**void**

---

### `setRestContext(countryCode, productCode)`

#### Signature
```apex
private static void setRestContext(String countryCode, String productCode)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| countryCode | String |  |
| productCode | String |  |

#### Return Type
**void**

---

### `getExpectedFlyZone(countryCode, productFamily)`

#### Signature
```apex
private static String getExpectedFlyZone(String countryCode, String productFamily)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| countryCode | String |  |
| productFamily | String |  |

#### Return Type
**String**

---

### `getProductZoning_whenValidProductAndCountry_returnsPermissibleFlyZone()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenValidProductAndCountry_returnsPermissibleFlyZone()
```

#### Return Type
**void**

---

### `getProductZoning_whenValidProductAndDifferentCountry_returnsMatchingFlyZone()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenValidProductAndDifferentCountry_returnsMatchingFlyZone()
```

#### Return Type
**void**

---

### `getProductZoning_whenCountryCodeHeaderMissing_defaultsToUsAndReturnsFlyZone()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenCountryCodeHeaderMissing_defaultsToUsAndReturnsFlyZone()
```

#### Return Type
**void**

---

### `getProductZoning_whenCountryCodeHeaderBlank_defaultsToUsAndReturnsFlyZone()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenCountryCodeHeaderBlank_defaultsToUsAndReturnsFlyZone()
```

#### Return Type
**void**

---

### `getProductZoning_whenCountryHasNoRegulationsForProductFamily_returnsLocalAuthoritiesMessage()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenCountryHasNoRegulationsForProductFamily_returnsLocalAuthoritiesMessage()
```

#### Return Type
**void**

---

### `getProductZoning_whenCountryHasNoMapping_returnsLocalAuthoritiesMessage()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenCountryHasNoMapping_returnsLocalAuthoritiesMessage()
```

#### Return Type
**void**

---

### `getProductZoning_whenProductCodeIsNull_returnsMissingProductCodeMessage()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenProductCodeIsNull_returnsMissingProductCodeMessage()
```

#### Return Type
**void**

---

### `getProductZoning_whenProductCodeIsBlank_returnsMissingProductCodeMessage()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenProductCodeIsBlank_returnsMissingProductCodeMessage()
```

#### Return Type
**void**

---

### `getProductZoning_whenProductCodeDoesNotExist_returnsMissingProductCodeMessage()`

`ISTEST`

#### Signature
```apex
private static void getProductZoning_whenProductCodeDoesNotExist_returnsMissingProductCodeMessage()
```

#### Return Type
**void**