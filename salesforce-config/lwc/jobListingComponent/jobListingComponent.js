import { LightningElement, track, wire } from 'lwc';
import getJobs from '@salesforce/apex/JobFetcher.getJobs';

export default class JobListings extends LightningElement {
    @track jobs = [];

    @wire(getJobs)
    wiredJobs({ data, error }) {
        if (data) {
            this.jobs = JSON.parse(data);
        } else if (error) {
            console.error(error);
        }
    }
}