# AssetServiceTest Class

`ISTEST`

## Methods
### `setRestContext(assetIdentifier)`

#### Signature
```apex
private static void setRestContext(String assetIdentifier)
```

#### Parameters
| Name | Type | Description |
|------|------|-------------|
| assetIdentifier | String |  |

#### Return Type
**void**

---

### `givenEmptyAssetIdentifier_whenReportLost_returnsNoDeviceFound()`

`ISTEST`

#### Signature
```apex
private static void givenEmptyAssetIdentifier_whenReportLost_returnsNoDeviceFound()
```

#### Return Type
**void**

---

### `givenInvalidAssetIdentifier_whenReportLost_returnsNoDeviceFound()`

`ISTEST`

#### Signature
```apex
private static void givenInvalidAssetIdentifier_whenReportLost_returnsNoDeviceFound()
```

#### Return Type
**void**

---

### `givenAssetWithFiledClaim_whenReportLost_returnsClaimAlreadyFiled()`

`ISTEST`

#### Signature
```apex
private static void givenAssetWithFiledClaim_whenReportLost_returnsClaimAlreadyFiled()
```

#### Return Type
**void**

---

### `givenAssetWithNoInsurance_whenReportLost_returnsNoCoverage()`

`ISTEST`

#### Signature
```apex
private static void givenAssetWithNoInsurance_whenReportLost_returnsNoCoverage()
```

#### Return Type
**void**

---

### `givenValidAssetWithInsuranceAndNoClaim_whenReportLost_returnsClaimsName()`

`ISTEST`

#### Signature
```apex
private static void givenValidAssetWithInsuranceAndNoClaim_whenReportLost_returnsClaimsName()
```

#### Return Type
**void**