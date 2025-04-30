public class SlackRoundZeroBot {

    public class SlackRequest {
        @InvocableVariable(label='Candidate Name')
        public String candidateName;

        @InvocableVariable(label='Slack Channel')
        public String slackChannel;

        @InvocableVariable(label='Candidate Email')
        public String candidateEmail;
    }

    @InvocableMethod(label='Send Round Zero Slack Message')
    public static void sendRoundZeroMessage(List<SlackRequest> requests) {
        for (SlackRequest reqData : requests) {
            String webhookUrl = 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'; // Replace with actual webhook

            String message = '👋 Hi ' + reqData.candidateName + '! We received your application. \n' +
                            'Are you available for a quick *Round 0* discussion? Please click one of the options below.';

            String availabilityButtons = '{"attachments": [{"text": "' + message + '",' +
                '"fallback": "You are unable to choose a time",' +
                '"callback_id": "round_zero_schedule",' +
                '"color": "#3AA3E3",' +
                '"attachment_type": "default",' +
                '"actions": [' +
                    '{"name": "time", "text": "10 AM Today", "type": "button", "value": "10am_today"},' +
                    '{"name": "time", "text": "4 PM Today", "type": "button", "value": "4pm_today"},' +
                    '{"name": "time", "text": "Tomorrow 11 AM", "type": "button", "value": "11am_tomorrow"}' +
                ']}]}';

            HttpRequest req = new HttpRequest();
            req.setEndpoint(webhookUrl);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(availabilityButtons);

            Http http = new Http();
            try {
                HttpResponse res = http.send(req);
                System.debug('Slack message sent: ' + res.getBody());
            } catch (Exception e) {
                System.debug('Error sending Slack message: ' + e.getMessage());
            }
        }
    }
}