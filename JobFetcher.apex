/**
* @File Name : JobFetcher.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : April 30, 2025
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | April 30, 2025 |   | Initial Version
**/
public with sharing class JobFetcher {
    @AuraEnabled(cacheable=true)
    public static String getJobs() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://portainer.ccstiet.com/get-job-descriptions');
        req.setMethod('GET');
        req.setTimeout(5000);
        HttpResponse res = http.send(req);
        return res.getBody();
    }
}