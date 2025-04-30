public with sharing class GetApplicationAndJob {

    public class ApplicationIdInput {
        @InvocableVariable(required=true)
        public String applicationId;
    }

    public class ApplicationAndJobOutput {
        @InvocableVariable
        public String applicationData;
        @InvocableVariable
        public String jobTitle;  
        @InvocableVariable
        public String jobDescription;
        @InvocableVariable
        public String jobLocation;
        @InvocableVariable
        public String jobDeadline;
        @InvocableVariable
        public String errorMessage;
    }

    @InvocableMethod
    public static List<ApplicationAndJobOutput> fetchApplicationAndJob(List<ApplicationIdInput> inputs) {
        List<ApplicationAndJobOutput> results = new List<ApplicationAndJobOutput>();

        for (ApplicationIdInput input : inputs) {
            ApplicationAndJobOutput result = new ApplicationAndJobOutput();
            results.add(result);

            if (String.isBlank(input.applicationId)) {
                result.errorMessage = 'ERROR: Application ID is missing';
                continue;
            }

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://portainer.ccstiet.com/application-job/' + EncodingUtil.urlEncode(input.applicationId, 'UTF-8'));
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');

            Http http = new Http();
            HttpResponse res;

            try {
                res = http.send(req);

                if (res.getStatusCode() == 200) {
                    String body = res.getBody();
                    Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(body);

                    if (resultMap != null && resultMap.containsKey('application') && resultMap.get('application') instanceof String &&
                        resultMap.containsKey('job') && resultMap.get('job') instanceof Map<String, Object>) {  

                        result.applicationData = (String) resultMap.get('application');
                        Map<String, Object> jobMap = (Map<String, Object>) resultMap.get('job'); 

                        // Safely extract job details, handling nulls
                        result.jobTitle = (String) jobMap.get('title');
                        result.jobDescription = (String) jobMap.get('description');
                        result.jobLocation = (String) jobMap.get('location');
                        result.jobDeadline = (String) jobMap.get('deadline');


                    } else {
                        result.errorMessage = 'ERROR: application or job key missing or invalid format in response';
                    }
                } else {
                    result.errorMessage = 'ERROR: HTTP ' + res.getStatusCode() + ' - ' + res.getStatus();
                }

            } catch (Exception e) {
                result.errorMessage = 'ERROR: ' + e.getMessage();
            }
        }
        return results;
    }

    @AuraEnabled
    public static ApplicationAndJobOutput fetchApplicationAndJobAura(String applicationId) {
        ApplicationAndJobOutput result = new ApplicationAndJobOutput();

        if (String.isBlank(applicationId)) {
            result.errorMessage = 'ERROR: Application ID is missing';
            return result;
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://portainer.ccstiet.com/application-job/' + EncodingUtil.urlEncode(applicationId, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);

            if (res.getStatusCode() == 200) {
                String body = res.getBody();
                Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(body);

            if (resultMap != null && resultMap.containsKey('application') && resultMap.get('application') instanceof String &&
                        resultMap.containsKey('job') && resultMap.get('job') instanceof Map<String, Object>) {  

                        result.applicationData = (String) resultMap.get('application');
                        Map<String, Object> jobMap = (Map<String, Object>) resultMap.get('job'); 

                        // Safely extract job details, handling nulls
                        result.jobTitle = (String) jobMap.get('title');
                        result.jobDescription = (String) jobMap.get('description');
                        result.jobLocation = (String) jobMap.get('location');
                        result.jobDeadline = (String) jobMap.get('deadline');


                    } else {
                        result.errorMessage = 'ERROR: application or job key missing or invalid format in response';
                    }
                } else {
                    result.errorMessage = 'ERROR: HTTP ' + res.getStatusCode() + ' - ' + res.getStatus();
                }

            } catch (Exception e) {
                result.errorMessage = 'ERROR: ' + e.getMessage();
            }
        return result;
    }
}
