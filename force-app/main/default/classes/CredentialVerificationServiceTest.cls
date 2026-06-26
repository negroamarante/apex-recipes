@isTest
private with sharing class CredentialVerificationServiceTest {
  @isTest
  static void testNullParameters() {
    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(null, null);
    Test.stopTest();
    Assert.areEqual('No record found', respond, 'Not same respond');
  }

  @isTest
  static void testInvalidContact() {
    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(
      '',
      'contactCertificationName'
    );
    Test.stopTest();
    Assert.areEqual('No record found', respond, 'Not same respond');
  }

  @isTest
  static void testInvalidContactCertificationName() {
    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(
      'test123',
      ''
    );
    Test.stopTest();
    Assert.areEqual('No record found', respond, 'Not same respond');
  }

  @isTest
  static void testNoRecordFound() {
    Contact c = new Contact(LastName = 'test123');
    insert c;
    Contact c1 = new Contact(LastName = 'anotherTest');
    insert c1;
    Certification__c cert = new Certification__c(
      Name = 'Test Cert',
      isActive__c = true
    );
    insert cert;

    Contact_Certification__c contactCert = new Contact_Certification__c(
      Contact__c = c1.Id,
      Certification__c = cert.Id,
      Issue_Date__c = System.today()
    );
    insert contactCert;
    contactCert = [
      SELECT Id, Name
      FROM Contact_Certification__c
      WHERE Id = :contactCert.Id
    ];

    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(
      'test123',
      String.valueOf(contactCert.Name)
    );
    Test.stopTest();

    Assert.areEqual('No record found', respond, 'Not same respond');
  }

  @isTest
  static void testValidContactCertification() {
    Contact c = new Contact(LastName = 'test123');
    insert c;
    Certification__c cert = new Certification__c(
      Name = 'Test Cert',
      isActive__c = true
    );
    insert cert;

    Contact_Certification__c contactCert = new Contact_Certification__c(
      Contact__c = c.Id,
      Certification__c = cert.Id,
      Issue_Date__c = System.today(),
      isActive__c = true
    );
    insert contactCert;
    contactCert = [
      SELECT Id, Name
      FROM Contact_Certification__c
      WHERE Id = :contactCert.Id
    ];

    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(
      'test123',
      String.valueOf(contactCert.Name)
    );
    Test.stopTest();

    Assert.areEqual('Valid', respond, 'Not same respond');
  }

  @isTest
  static void testNeedRenewalContactCertification() {
    Contact c = new Contact(LastName = 'test123');
    insert c;
    Certification__c cert = new Certification__c(
      Name = 'Test Cert',
      isActive__c = true
    );
    insert cert;

    Contact_Certification__c contactCert = new Contact_Certification__c(
      Contact__c = c.Id,
      Certification__c = cert.Id,
      Issue_Date__c = System.today(),
      isActive__c = false
    );
    insert contactCert;
    contactCert = [
      SELECT Id, Name
      FROM Contact_Certification__c
      WHERE Id = :contactCert.Id
    ];

    Test.startTest();
    String respond = CredentialVerificationService.verifyCredential(
      'test123',
      String.valueOf(contactCert.Name)
    );
    Test.stopTest();

    Assert.areEqual('Needs Renewal', respond, 'Not same respond');
  }
}
