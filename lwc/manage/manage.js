import { LightningElement } from 'lwc';

import findAEs from '@salesforce/apex/findLinks.getAEs';
import findAccounts from '@salesforce/apex/findLinks.getAccounts';
import findSubscriptions from '@salesforce/apex/findLinks.getSubscriptions';

export default class Manage extends LightningElement {
    version = 1.16;
    aes;
    aeSelectedId;
    aeSelectedName;
    accounts;
    accountSelectedId;
    accountSelectedName;
    subscriptions;
    showError;

    aeSelected(event){
        // alert(event.target.dataset.item);
        this.aeSelectedName = event.target.dataset.name;
        // console.log("test");
        this.aeSelectedId = event.target.id;  // alert(event.target.key);
        this.aeSelectedId = this.aeSelectedId.substring(0,18); // alert(this.aeSelectedId);
        this.searchAccounts();
        // this.subscriptions = null;
        // this.accountSelectedId = "";
        // this.searchsSubscriptions(event)
    }
    accountSelected(event){
        // alert(event.target.dataset.id);
        this.accountSelectedName = event.target.dataset.name;
        // this.accountSelectedId = event.target.id;  // alert(event.target.key);
        // this.accountSelectedId = this.accountSelectedId.substring(0,18); // alert(this.aeSelectedId);
        this.accountSelectedId = event.target.dataset.id;
        this.searchsSubscriptions();
    }

    loadAEs(event) {
        findAEs() 
            .then((result) => {
                this.aes = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.aes = undefined;
                this.error = error;
                this.errorString = '';
                if (Array.isArray(error.body)) {
                    // error.body.map((e) => e.message);
                    this.errorString += 'ARRAY';
                }
                if (error.body && typeof error.body.message === 'string') {
                    this.errorString += error.body.message;
                }
                if (typeof error.message === 'string') {
                    this.errorString += error.message;
                }
                this.errorString += ' : ' + error.statusText;
                this.showError = 'Error: ' + this.errorString;
            });
    }

    searchAccounts(event) {
        findAccounts({aeId: this.aeSelectedId}) 
            .then((result) => {
                this.accounts = result;
                this.error = undefined; // alert(this.accounts);
            })
            .catch((error) => {
                // alert("err");
                this.accounts = undefined;
                this.error = error;
                this.errorString = '';
                if (Array.isArray(error.body)) {
                    // error.body.map((e) => e.message);
                    this.errorString += 'ARRAY';
                }
                if (error.body && typeof error.body.message === 'string') {
                    this.errorString += error.body.message;
                }
                if (typeof error.message === 'string') {
                    this.errorString += error.message;
                }
                this.errorString += ' : ' + error.statusText;
                this.showError = 'Error: ' + this.errorString;
            });
    }

    searchsSubscriptions(event){
        findSubscriptions({accountId: this.accountSelectedId})  // alert(this.accountSelectedId);
        .then((result) => {
            this.subscriptions = result;
            this.error = undefined; 
        })
        .catch((error) => {
            // alert("err");
            this.subscriptions = undefined;
            this.error = error;
            this.errorString = '';
            if (Array.isArray(error.body)) {
                // error.body.map((e) => e.message);
                this.errorString += 'ARRAY';
            }
            if (error.body && typeof error.body.message === 'string') {
                this.errorString += error.body.message;
            }
            if (typeof error.message === 'string') {
                this.errorString += error.message;
            }
            this.errorString += ' : ' + error.statusText;
            this.showError = 'Error: ' + this.errorString;
        });
    }

    connectedCallback() {
        this.loadAEs();
        // this.searchAccounts();
        this.accountSelectedId = "0010100000SniDd";
        this.searchsSubscriptions();
    }
}