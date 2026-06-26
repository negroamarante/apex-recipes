@RestResource(urlMapping='/lost/*')
global with sharing class AssetService {
  @TestVisible
  private static final String NO_DEVICE_FOUND = 'No device found.';

  @HttpPost
  global static String reportLostDevice(String assetIdentifier) {
    if (String.isBlank(assetIdentifier)) {
      return NO_DEVICE_FOUND;
    }
    // Query for the asset
    Asset asset = [
      SELECT
        Id,
        Status,
        Name,
        (
          SELECT Id, Coverage__c
          FROM Insurances__r
          WHERE Coverage__c = 'Comprehensive' AND Active__c = TRUE
        ),
        (SELECT Id, Name FROM Claims__r WHERE Type__c = 'Loss')
      FROM Asset
      WHERE Asset_Identifier__c = :assetIdentifier
    ] ?? new Asset();

    if (asset.Id == null) {
      return NO_DEVICE_FOUND;
    }

    asset.Status = 'Lost';
    update asset;

    // Claim Already Filed: If there's already a claim of type Loss, the method should return the message [Claim number] already filed.
    if (!asset.Claims__r.isEmpty() && asset.Claims__r[0] != null) {
      return asset.Claims__r[0].Name + ' already filed.';
    }

    //No Coverage: If a device is not insured, the API should update the status to 'Lost' and return No coverage. Asset status adjusted to Lost.
    if (asset.Insurances__r.isEmpty()) {
      return 'No coverage. Asset status adjusted to Lost.';
    }

    Claim__c claim = new Claim__c(
      Asset__c = asset.Id,
      Insurance__c = asset.Insurances__r[0].Id,
      Type__c = 'Loss'
    );
    insert claim;

    claim = [SELECT Id, Name FROM Claim__c WHERE Id = :claim.Id LIMIT 1];
    return String.valueOf(claim.Name);
  }
}
