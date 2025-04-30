public with sharing class SendQuestions {

    public class QuestionsMessage {
        @InvocableVariable(required=true)
        public String message;
    }

    public class ResponseOutput {
        @InvocableVariable
        public String result;
    }

    private static String slackWebhookUrl = 'https://hooks.slack.com/services/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'; //  Make this configurable!

    

    @InvocableMethod
    public static List<ResponseOutput> sendSingleSlackMessageAgent(List<QuestionsMessage> messages) {
        List<ResponseOutput> results = new List<ResponseOutput>();
        ResponseOutput result = new ResponseOutput();

        if (messages == null || messages.isEmpty()) {
            result.result = 'ERROR: No message provided.';
            results.add(result);
            return results;
        }

        String message = messages[0].message; // Get the message from the first (and expected only) element.
        message+='\n\nhttps://slack.com/shortcuts/Ft08Q3KPV2Q6/2178d83885568bdf0d86dca805d501dc';

        result.result = sendSingleSlackMessage(message);
        results.add(result);
        return results;
    }

    @AuraEnabled
    public static String sendSingleSlackMessageAura(String message) {
        return sendSingleSlackMessage(message);
    }

    private static String sendSingleSlackMessage(String message) {
        Map<String, Object> slackPayload = new Map<String, Object>{
            'text' => message
        };
        HttpRequest req = new HttpRequest();
        req.setEndpoint(slackWebhookUrl);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(JSON.serialize(slackPayload));

        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            if (res.getStatusCode() == 200) {
                return 'Slack message sent successfully.';
            } else {
                return 'Slack message failed. Status code: ' + res.getStatusCode() + ' Body: ' + res.getBody();
            }
        } catch (Exception e) {
            return 'ERROR: Exception occurred: ' + e.getMessage();
        }
    }
}