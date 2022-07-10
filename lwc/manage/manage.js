import { LightningElement } from 'lwc';

import findAEs from '@salesforce/apex/findLinks.getAEs';
import findAccounts from '@salesforce/apex/findLinks.getAccounts';
import findSubscriptions from '@salesforce/apex/findLinks.getSubscriptions';
import findOpps from '@salesforce/apex/findLinks.getOpps';
import findOppRows from '@salesforce/apex/findLinks.getOppRows';

export default class Manage extends LightningElement {
    version = 1.2;
    aes;
    aeSelectedId;
    aeSelectedName;
    manager;
    accounts;
    accountSelectedId;
    accountSelectedNameOpp;
    accountSelectedNameSub;
    subscriptions;
    opps;
    oppSelectedId;
    oppSelectedName;
    oppsSearchAllForAE; // true or
    oppRows;
    showError;
    testing;

    aeSelected(event){
        // alert(event.target.dataset.item);
        this.aeSelectedName = event.target.dataset.name;
        this.manager =event.target.dataset.manager;
        // console.log("test");
        this.aeSelectedId = event.target.id;  // alert(event.target.key);
        this.aeSelectedId = this.aeSelectedId.substring(0,18); // alert(this.aeSelectedId);
        this.searchAccounts();
        /*
        this.accountSelectedId = "";
        this.clearSubscriptions();
        this.clearOpps();
        this.clearOppRows(); */
    }
    accountSelected(event){
        // alert(event.target.dataset.id);
        this.accountSelectedId = event.target.dataset.id;
        this.accountSelectedNameOpp = event.target.dataset.name;
        this.accountSelectedNameSub = event.target.dataset.name;
        // this.testing = event.target.attributes[7].value;
        // alert(event.target.dataset.type);
        if ( event.target.dataset.type == "Prospect" ) {
            this.clearSubscriptions();
        } else {
            this.searchsSubscriptions();
        }
        this.oppsSearchAllForAE = false;
        this.searchOpps();
        this.clearOppRows();
    }
    oppSelected(event){
        this.oppSelectedId = event.target.dataset.id;
        this.oppSelectedName = event.target.dataset.name;
        this.searchOppRows();
    }
    allOppsSelected(event){
        if ( this.aeSelectedId == null ) {
            alert("Select an AE.");
        } else {
            this.accountSelectedNameOpp = this.aeSelectedName + " - All Opportunities";
            this.oppsSearchAllForAE = true;
            this.searchOpps();
            // this.oppsSearchAllForAE = false";
        }
    }

    clearSubscriptions(){
        this.accountSelectedNameSub = "";
        this.subscriptions = [];
        // this.clearOpps();
    }
    clearOpps(){
        this.opps = [];
        this.oppSelectedId = "";
        this.accountSelectedNameOpp = "";
        // this.clearOppRows();
    }
    clearOppRows(){
        this.oppRows = [];
        this.oppSelectedName = "";
    }

    clearSubscriptions(){
        this.accountSelectedNameSub = "";
        this.subscriptions = [];
        // this.clearOpps();
    }
    clearOpps(){
        this.opps = [];
        this.oppSelectedId = "";
        this.accountSelectedNameOpp = "";
        // this.clearOppRows();
    }
    clearOppRows(){
        this.oppRows = [];
        this.oppSelectedName = "";
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

    searchOpps(event){
        /*alert(this.accountSelectedId);
        alert(this.aeSelectedId);
        alert(this.oppsSearchAllForAE);*/
        findOpps({accountId: this.accountSelectedId, aeId: this.aeSelectedId, searchAll: this.oppsSearchAllForAE})  // alert(this.accountSelectedId);
        .then((result) => {
            this.opps = result;
            this.error = undefined; 
        })
        .catch((error) => {
            // alert("err");
            this.opps = undefined;
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

    searchOppRows(event){
        findOppRows({oppSelectedId: this.oppSelectedId})  // alert(this.accountSelectedId);
        .then((result) => {
            this.oppRows = result;
            this.error = undefined; 
        })
        .catch((error) => {
            // alert("err");
            this.oppRows = undefined;
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
        // this.accountSelectedId = "0010100000SoV7dAAF";
        // this.searchsSubscriptions();
        // this.searchOpps();
        // this.searchOppRows();
        this.accountSelectedId = "";
        this.oppsSearchAllForAE = ""; // set to empty string
    }
}