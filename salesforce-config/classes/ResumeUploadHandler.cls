public class ResumeUploadHandler {
    @InvocableMethod
    public static List<String> sendResumeToAPI(List<ResumeInput> inputs) {
        ResumeInput input = inputs[0];

        // Download PDF from the given URL
        HttpRequest getReq = new HttpRequest();
        getReq.setEndpoint(input.resumeUrl);
        getReq.setMethod('GET');
        getReq.setHeader('Content-Type', 'application/pdf');

        Http http = new Http();
        HttpResponse getRes = http.send(getReq);

        if (getRes.getStatusCode() != 200) {
            throw new CalloutException('Failed to fetch PDF. Status: ' + getRes.getStatus());
        }

        Blob resumeBlob = getRes.getBodyAsBlob();

        // Encode resume in base64
        String base64Resume = EncodingUtil.base64Encode(resumeBlob);

        // Prepare HTTP POST request to send to your API
        HttpRequest postReq = new HttpRequest();
        postReq.setEndpoint('https://portainer.ccstiet.com/upload-resume');
        postReq.setMethod('POST');
        postReq.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>{
            'data' => base64Resume,
            'name' => input.name,
            'email' => input.email,
            'job_id' => 1, // still hardcoded
            'address' => input.address,
            'phone' => input.phone
        };

        postReq.setBody(JSON.serialize(payload));
        HttpResponse postRes = http.send(postReq);

        System.debug(postRes.getBody());

        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(postRes.getBody());
        String applicationId = (String) result.get('application_id');
        String thankyoumessage = 'Thankyou For Applying to Team Brocode. You\'ll recive a message with some questions which you have to answer in order to proceed to next round. Your Application Reference ID is '+ applicationId;
     
        Map<String, Object> slackpayload = new Map<String, Object>{
            'text' => thankyoumessage
        };
        HttpRequest postReq2 = new HttpRequest();
        postReq2.setEndpoint('https://hooks.slack.com/services/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');
        postReq2.setMethod('POST');
        postReq2.setHeader('Content-Type', 'application/json');
        postReq2.setBody(JSON.serialize(slackpayload));
        HttpResponse postRes2 = http.send(postReq2);
        
        return new List<String>{ applicationId };
    }

    public class ResumeInput {
        @InvocableVariable public String name;
        @InvocableVariable public String email;
        @InvocableVariable public String address;
        @InvocableVariable public String phone;
        @InvocableVariable public String resumeUrl; // Now takes a URL instead of Blob
    }
}