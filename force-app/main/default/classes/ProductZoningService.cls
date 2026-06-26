@RestResource(urlMapping='/ProductZoning/*')
global with sharing class ProductZoningService {
  @TestVisible
  private static final String DEFAULT_COUNTRY_CODE = 'US';
  @TestVisible
  private static final String MISSING_PRODUCT_CODE_MESSAGE = 'ProductCode is missing or doesn\'t exist';
  @TestVisible
  private static final String CONFIRM_WITH_LOCAL_AUTHORITIES_MESSAGE = 'Confirm with the local authorities';

  @HttpGet
  global static String getProductZoning() {
    RestRequest request = RestContext.request;

    String countryCode = request.headers.get('CountryCode');
    if (countryCode == null || String.isBlank(countryCode)) {
      countryCode = DEFAULT_COUNTRY_CODE;
    }

    String productCode = request.params.get('ProductCode');
    if (String.isBlank(productCode)) {
      return MISSING_PRODUCT_CODE_MESSAGE;
    }

    List<Product2> products = [
      SELECT Id, Family
      FROM Product2
      WHERE ProductCode = :productCode
      LIMIT 1
    ];
    if (products.isEmpty()) {
      return MISSING_PRODUCT_CODE_MESSAGE;
    }
    Product2 product = products[0];

    List<Product_Geo_Mapping__mdt> productZonings = [
      SELECT Permissible_Fly_Zone__c
      FROM Product_Geo_Mapping__mdt
      WHERE
        Country_Code__c = :countryCode
        AND Product_Family__c = :product.Family
      LIMIT 1
    ];

    if (productZonings.isEmpty()) {
      return CONFIRM_WITH_LOCAL_AUTHORITIES_MESSAGE;
    }

    return productZonings[0].Permissible_Fly_Zone__c;
  }
}
