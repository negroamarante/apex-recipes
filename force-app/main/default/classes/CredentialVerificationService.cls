global with sharing class CredentialVerificationService {
  webService static String verifyCredential(
    String contactLastName,
    String contactCertificationName
  ) {
    if (
      String.isBlank(contactLastName) ||
      String.isBlank(contactCertificationName)
    ) {
      return 'No record found';
    }

    Contact_Certification__c cc = [
      SELECT Id, Name, isActive__c
      FROM Contact_Certification__c
      WHERE
        Name = :contactCertificationName
        AND Contact__r.LastName = :contactLastName
    ] ?? new Contact_Certification__c();
    if (cc.Id == null) {
      return 'No record found';
    }
    return cc.isActive__c ? 'Valid' : 'Needs Renewal';
  }
}
