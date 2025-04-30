public with sharing class SubmitReviewAndNotifySlack {

    private static final String SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/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'; // Replace with your actual Slack webhook URL

    public class ReviewInput {
        @InvocableVariable(required=true)
        public String applicationId;
        @InvocableVariable(required=true)
        public String reviewText;
        @InvocableVariable(required=true)
        public Boolean passOrFail;
        @InvocableVariable(required=true)
        public String interviewerMessage; // Message to send to the interviewer on Slack
    }

    public class ReviewOutput {
        @InvocableVariable
        public Boolean success;
        @InvocableVariable
        public String errorMessage;
    }

    @InvocableMethod(label='Submit Review and Notify Interviewer')
    public static List<ReviewOutput> submitReviewAndNotify(List<ReviewInput> inputs) {
        List<ReviewOutput> results = new List<ReviewOutput>();

        for (ReviewInput input : inputs) {
            ReviewOutput result = new ReviewOutput();
            result.success = false;
            results.add(result);

            if (String.isBlank(input.applicationId)) {
                result.errorMessage = 'ERROR: Application ID is missing';
                continue;
            }
            if (String.isBlank(input.reviewText)) {
                result.errorMessage = 'ERROR: Review text is missing';
                continue;
            }
            if (input.passOrFail == null) {
                result.errorMessage = 'ERROR: Pass/Fail status is missing';
                continue;
            }
            if (String.isBlank(input.interviewerMessage)) {
                result.errorMessage = 'ERROR: Interviewer message is missing';
                continue;
            }

            // 1. Send POST request to store the review
            HttpRequest reviewReq = new HttpRequest();
            reviewReq.setEndpoint('https://portainer.ccstiet.com/store-review');
            reviewReq.setMethod('POST');
            reviewReq.setHeader('Content-Type', 'application/json');

            Map<String, Object> reviewBody = new Map<String, Object>{
                'application_id' => Integer.valueOf(input.applicationId),
                'review' => input.reviewText,
                'pass' => input.passOrFail
            };
            reviewReq.setBody(JSON.serialize(reviewBody));

            Http http = new Http();
            HttpResponse reviewRes;

            try {
                reviewRes = http.send(reviewReq);
                if (reviewRes.getStatusCode() >= 200 && reviewRes.getStatusCode() < 300) {
                    result.success = true;
                    System.debug('Review submitted successfully for Application ID: ' + input.applicationId);

                    // 2. Send message to Slack
                    HttpRequest slackReq = new HttpRequest();
                    slackReq.setEndpoint(SLACK_WEBHOOK_URL);
                    slackReq.setMethod('POST');
                    slackReq.setHeader('Content-Type', 'application/json');
                    String message=input.interviewerMessage+'\n\n'+input.reviewText;
                    Map<String, Object> slackBody = new Map<String, Object>{
                        'text' => message
                    };
                    slackReq.setBody(JSON.serialize(slackBody));

                    HttpResponse slackRes;
                    try {
                        slackRes = http.send(slackReq);
                        if (slackRes.getStatusCode() >= 200 && slackRes.getStatusCode() < 300) {
                            System.debug('Slack notification sent successfully for Application ID: ' + input.applicationId);
                        } else {
                            System.debug('ERROR sending Slack notification (Status Code: ' + slackRes.getStatusCode() + ', Body: ' + slackRes.getBody() + ') for Application ID: ' + input.applicationId);
                            if (String.isBlank(result.errorMessage)) {
                                result.errorMessage = 'Warning: Review submitted successfully, but there was an error sending Slack notification.';
                            } else {
                                result.errorMessage += ' Warning: There was also an error sending Slack notification.';
                            }
                        }
                    } catch (Exception slackEx) {
                        System.debug('ERROR sending Slack notification: ' + slackEx.getMessage() + ' for Application ID: ' + input.applicationId);
                        if (String.isBlank(result.errorMessage)) {
                                result.errorMessage = 'Warning: Review submitted successfully, but there was an error sending Slack notification: ' + slackEx.getMessage();
                            } else {
                                result.errorMessage += ' Warning: There was also an error sending Slack notification: ' + slackEx.getMessage();
                            }
                    }

                } else {
                    result.errorMessage = 'ERROR: Failed to submit review (HTTP ' + reviewRes.getStatusCode() + ' - ' + reviewRes.getStatus() + ', Body: ' + reviewRes.getBody() + ')';
                }

            } catch (Exception e) {
                result.errorMessage = 'ERROR: ' + e.getMessage();
            }
        }
        return results;
    }
}