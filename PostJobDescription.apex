public with sharing class PostJobDescription {
    
    @InvocableMethod(label='Post Job Description' description='Posts job details to portainer.ccstiet.com/add-job-description and returns success or error')
    public static List<JobResult> postJob(List<JobInput> inputs) {
        List<JobResult> results = new List<JobResult>();

        for (JobInput input : inputs) {
            JobResult result = new JobResult();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://portainer.ccstiet.com/add-job-description');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');

            // Build JSON body
            String body = JSON.serialize(new Map<String, Object>{
                'title' => input.title,
                'description' => input.description,
                'location' => input.location,
                'deadline' => input.deadline
            });

            req.setBody(body);

            Http http = new Http();
            try {
                HttpResponse res = http.send(req);
                if (res.getStatusCode() == 200 || res.getStatusCode() == 201) {
                    result.status = 'Success';
                    result.message = 'Job description posted successfully.';
                } else {
                    result.status = 'Failure';
                    result.message = 'Error: ' + res.getStatusCode() + ' - ' + res.getBody();
                }
            } catch (Exception e) {
                result.status = 'Failure';
                result.message = 'Exception occurred: ' + e.getMessage();
            }

            results.add(result);
        }

        return results;
    }

    public class JobInput {
        @InvocableVariable(label='Title' required=true)
        public String title;

        @InvocableVariable(label='Description' required=true)
        public String description;

        @InvocableVariable(label='Location' required=true)
        public String location;

        @InvocableVariable(label='Deadline (YYYY-MM-DD)' required=true)
        public String deadline;
    }

    public class JobResult {
        @InvocableVariable(label='Status')
        public String status;

        @InvocableVariable(label='Message')
        public String message;
    }
}