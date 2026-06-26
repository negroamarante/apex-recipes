@isTest
private with sharing class ProductZoningServiceTest {
  private static final String ZONED_PRODUCT_CODE = 'PZ-001';
  private static final String UNZONED_PRODUCT_CODE = 'PZ-002';
  private static final String ZONED_PRODUCT_FAMILY = 'Fixed-Wing';
  private static final String UNZONED_PRODUCT_FAMILY = 'HALE';
  private static final String US_COUNTRY_CODE = 'US';
  private static final String ALT_COUNTRY_CODE = 'AU';
  private static final String UNMAPPED_COUNTRY_CODE = 'CA';

  @TestSetup
  static void setupTestData() {
    insert new List<Product2>{
      new Product2(
        Name = 'Zoned Product',
        ProductCode = ZONED_PRODUCT_CODE,
        IsActive = true,
        Family = ZONED_PRODUCT_FAMILY
      ),
      new Product2(
        Name = 'Unzoned Product',
        ProductCode = UNZONED_PRODUCT_CODE,
        IsActive = true,
        Family = UNZONED_PRODUCT_FAMILY
      )
    };
  }

  private static void setRestContext(String countryCode, String productCode) {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/ProductZoning/';
    request.httpMethod = 'GET';

    if (productCode != null) {
      request.params.put('ProductCode', productCode);
    }

    if (countryCode != null) {
      request.addHeader('CountryCode', countryCode);
    }

    RestContext.request = request;
    RestContext.response = new RestResponse();
  }

  private static String getExpectedFlyZone(
    String countryCode,
    String productFamily
  ) {
    List<Product_Geo_Mapping__mdt> mappings = [
      SELECT Permissible_Fly_Zone__c
      FROM Product_Geo_Mapping__mdt
      WHERE
        Country_Code__c = :countryCode
        AND Product_Family__c = :productFamily
      LIMIT 1
    ];
    System.Assert.isFalse(
      mappings.isEmpty(),
      'Expected Product_Geo_Mapping__mdt for ' +
        countryCode +
        ' and ' +
        productFamily
    );
    return mappings[0].Permissible_Fly_Zone__c;
  }

  // Outcome 1: Permissible Fly Zones

  @isTest
  static void getProductZoning_whenValidProductAndCountry_returnsPermissibleFlyZone() {
    setRestContext(US_COUNTRY_CODE, ZONED_PRODUCT_CODE);
    String expectedZone = getExpectedFlyZone(
      US_COUNTRY_CODE,
      ZONED_PRODUCT_FAMILY
    );

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      expectedZone,
      result,
      'Expected Permissible_Fly_Zone__c for a valid US product mapping'
    );
  }

  @isTest
  static void getProductZoning_whenValidProductAndDifferentCountry_returnsMatchingFlyZone() {
    setRestContext(ALT_COUNTRY_CODE, ZONED_PRODUCT_CODE);
    String expectedZone = getExpectedFlyZone(
      ALT_COUNTRY_CODE,
      ZONED_PRODUCT_FAMILY
    );

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      expectedZone,
      result,
      'Expected Permissible_Fly_Zone__c for the requested country'
    );
  }

  @isTest
  static void getProductZoning_whenCountryCodeHeaderMissing_defaultsToUsAndReturnsFlyZone() {
    setRestContext(null, ZONED_PRODUCT_CODE);
    String expectedZone = getExpectedFlyZone(
      US_COUNTRY_CODE,
      ZONED_PRODUCT_FAMILY
    );

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      expectedZone,
      result,
      'Expected US fly zone when CountryCode header is missing'
    );
  }

  @isTest
  static void getProductZoning_whenCountryCodeHeaderBlank_defaultsToUsAndReturnsFlyZone() {
    setRestContext('', ZONED_PRODUCT_CODE);
    String expectedZone = getExpectedFlyZone(
      US_COUNTRY_CODE,
      ZONED_PRODUCT_FAMILY
    );

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      expectedZone,
      result,
      'Expected US fly zone when CountryCode header is blank'
    );
  }

  // Outcome 2: Confirm with local authorities

  @isTest
  static void getProductZoning_whenCountryHasNoRegulationsForProductFamily_returnsLocalAuthoritiesMessage() {
    setRestContext(ALT_COUNTRY_CODE, UNZONED_PRODUCT_CODE);

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      ProductZoningService.CONFIRM_WITH_LOCAL_AUTHORITIES_MESSAGE,
      result,
      'Expected local authorities message when no regulations exist for the product family'
    );
  }

  @isTest
  static void getProductZoning_whenCountryHasNoMapping_returnsLocalAuthoritiesMessage() {
    setRestContext(UNMAPPED_COUNTRY_CODE, ZONED_PRODUCT_CODE);

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      ProductZoningService.CONFIRM_WITH_LOCAL_AUTHORITIES_MESSAGE,
      result,
      'Expected local authorities message when the country has no defined regulations'
    );
  }

  // Outcome 3: Invalid or missing ProductCode

  @isTest
  static void getProductZoning_whenProductCodeIsNull_returnsMissingProductCodeMessage() {
    setRestContext(US_COUNTRY_CODE, null);

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      ProductZoningService.MISSING_PRODUCT_CODE_MESSAGE,
      result,
      'Expected missing product code message when ProductCode is null'
    );
  }

  @isTest
  static void getProductZoning_whenProductCodeIsBlank_returnsMissingProductCodeMessage() {
    setRestContext(US_COUNTRY_CODE, '   ');

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      ProductZoningService.MISSING_PRODUCT_CODE_MESSAGE,
      result,
      'Expected missing product code message when ProductCode is blank'
    );
  }

  @isTest
  static void getProductZoning_whenProductCodeDoesNotExist_returnsMissingProductCodeMessage() {
    setRestContext(US_COUNTRY_CODE, 'INVALID-CODE');

    Test.startTest();
    String result = ProductZoningService.getProductZoning();
    Test.stopTest();

    System.Assert.areEqual(
      ProductZoningService.MISSING_PRODUCT_CODE_MESSAGE,
      result,
      'Expected missing product code message when ProductCode does not exist'
    );
  }
}
