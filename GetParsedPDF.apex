public with sharing class GetParsedPDF {

    public class ApplicationIdInput {
        @InvocableVariable(required=true)
        public String applicationId;
    }

    public class ParsedResumeOutput {
        @InvocableVariable
        public String parsedResumeData;
        @InvocableVariable
        public String errorMessage;
    }

    @InvocableMethod
    public static List<ParsedResumeOutput> fetchParsedResume(List<ApplicationIdInput> inputs) {
        List<ParsedResumeOutput> results = new List<ParsedResumeOutput>();

        for (ApplicationIdInput input : inputs) {
            ParsedResumeOutput result = new ParsedResumeOutput();
            results.add(result);

            if (String.isBlank(input.applicationId)) {
                result.errorMessage = 'ERROR: Application ID is missing';
                continue;
            }

            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://portainer.ccstiet.com/get-application-parsed-resume/' + EncodingUtil.urlEncode(input.applicationId, 'UTF-8'));
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');

            Http http = new Http();
            HttpResponse res;

            try {
                res = http.send(req);

                if (res.getStatusCode() == 200) {
                    String body = res.getBody();
                    Map<String, Object> resultMap = (Map<String, Object>) JSON.deserializeUntyped(body);

                    if (resultMap != null && resultMap.containsKey('parsedResume') && resultMap.get('parsedResume') instanceof String) {
                        result.parsedResumeData = (String) resultMap.get('parsedResume');
                    } else {
                        result.errorMessage = 'ERROR: parsedResume key missing or invalid format in response';
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
    public static String fetchParsedResumeAura(String applicationId) {
        if (String.isBlank(applicationId)) {
            return 'ERROR: Application ID is missing';
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://portainer.ccstiet.com/get-application-parsed-resume/' + EncodingUtil.urlEncode(applicationId, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/json');

        Http http = new Http();
        HttpResponse res;

        try {
            res = http.send(req);

            if (res.getStatusCode() == 200) {
                String body = res.getBody();
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(body);

                if (result != null && result.containsKey('parsedResume') && result.get('parsedResume') instanceof String) {
                    return (String) result.get('parsedResume');
                } else {
                    return 'ERROR: parsedResume key missing or invalid format in response';
                }
            } else {
                return 'ERROR: HTTP ' + res.getStatusCode() + ' - ' + res.getStatus();
            }

        } catch (Exception e) {
            return 'ERROR: ' + e.getMessage();
        }
    }
}
