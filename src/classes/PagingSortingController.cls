global class PagingSortingController {
    @AuraEnabled global static Account[] getAccounts() {
        return [SELECT Name, Industry, AnnualRevenue FROM Account LIMIT 1000];
    }
}