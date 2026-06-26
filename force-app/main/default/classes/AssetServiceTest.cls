@isTest
private with sharing class AssetServiceTest {
  private static void setRestContext(String assetIdentifier) {
    RestRequest request = new RestRequest();
    request.requestUri = '/services/apexrest/lost/';
    request.httpMethod = 'POST';

    Map<String, Object> bodyMap = new Map<String, Object>{
      'assetIdentifier' => assetIdentifier
    };
    String jsonPayload = JSON.serialize(bodyMap);
    request.requestBody = Blob.valueOf(jsonPayload);

    RestContext.request = request;
    RestContext.response = new RestResponse();
  }

  @isTest
  static void givenEmptyAssetIdentifier_whenReportLost_returnsNoDeviceFound() {
    setRestContext('');

    Test.startTest();
    String result = AssetService.reportLostDevice('');
    Test.stopTest();

    Assert.areEqual('No device found.', result, 'There is a device found.');
  }

  @isTest
  static void givenInvalidAssetIdentifier_whenReportLost_returnsNoDeviceFound() {
    setRestContext('invalidAssetIdentifier');

    Test.startTest();
    String result = AssetService.reportLostDevice('invalidAssetIdentifier');
    Test.stopTest();
    Assert.areEqual('No device found.', result, 'There is a device found.');
  }

  @isTest
  static void givenAssetWithFiledClaim_whenReportLost_returnsClaimAlreadyFiled() {
    Account a = new Account(Name = 'Test');
    insert a;
    Asset ast = new Asset(
      AccountId = a.Id,
      Name = 'Test Asset',
      Status = 'Installed',
      Asset_Identifier__c = 'qwer1234'
    );
    insert ast;

    Claim__c c = new Claim__c(Asset__c = ast.Id, Type__c = 'Loss');
    insert c;

    setRestContext('qwer1234');

    Test.startTest();
    String result = AssetService.reportLostDevice('qwer1234');
    Test.stopTest();

    c = [SELECT Id, Name FROM Claim__c WHERE Id = :c.Id LIMIT 1];
    String expectedMessage = c.Name + ' already filed.';
    Assert.areEqual(expectedMessage, result, 'There is no Claim');
  }

  @isTest
  static void givenAssetWithNoInsurance_whenReportLost_returnsNoCoverage() {
    Account a = new Account(Name = 'Test');
    insert a;
    Asset ast = new Asset(
      AccountId = a.Id,
      Name = 'Test Asset',
      Status = 'Installed',
      Asset_Identifier__c = 'qwer1234'
    );
    insert ast;

    Insurance__c ins = new Insurance__c(
      Asset__c = ast.Id,
      Active__c = true,
      Coverage__c = 'Comprehensive'
    );
    //insert ins;

    setRestContext('qwer1234');

    Test.startTest();
    String result = AssetService.reportLostDevice('qwer1234');
    Test.stopTest();

    String expectedMessage = 'No coverage. Asset status adjusted to Lost.';
    Assert.areEqual(expectedMessage, result, 'There is an Insurance');
  }

  @isTest
  static void givenValidAssetWithInsuranceAndNoClaim_whenReportLost_returnsClaimsName() {
    Account a = new Account(Name = 'Test');
    insert a;
    Asset ast = new Asset(
      AccountId = a.Id,
      Name = 'Test Asset',
      Status = 'Installed',
      Asset_Identifier__c = 'qwer1234'
    );
    insert ast;

    Insurance__c ins = new Insurance__c(
      Asset__c = ast.Id,
      Active__c = true,
      Coverage__c = 'Comprehensive'
    );
    insert ins;

    setRestContext('qwer1234');

    Test.startTest();
    String result = AssetService.reportLostDevice('qwer1234');
    Test.stopTest();

    Claim__c c = [
      SELECT Id, Name, Type__c, Insurance__c
      FROM Claim__c
      WHERE Asset__c = :ast.Id
      LIMIT 1
    ];
    Assert.areEqual(
      String.valueOf(c.Name),
      result,
      'There is no Claim created'
    );
    Assert.areEqual('Loss', c.Type__c, 'Type is not Loss');
    Assert.areEqual(ins.Id, c.Insurance__c, 'Insurance related is wrong');
  }
}
