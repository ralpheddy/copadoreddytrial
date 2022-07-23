import { LightningElement } from 'lwc';

import findAEs from '@salesforce/apex/findLinks.getAEs';
import findManagers from '@salesforce/apex/findLinks.getManagers';
import findAccounts from '@salesforce/apex/findLinks.getAccounts';
import findSubscriptions from '@salesforce/apex/findLinks.getSubscriptions';
import findOpps from '@salesforce/apex/findLinks.getOpps';
import findOppRows from '@salesforce/apex/findLinks.getOppRows';
// import findWhiteSpace from '@salesforce/apex/findLinks.getWhiteSpace';
import getWSGroups from '@salesforce/apex/findLinks.getWSGroups';

export default class MtestOne extends LightningElement {
    version = 0.1;
    aes;
    aeSelectedId;
    aeSelectedName;
    aeSelectedlOriginalID;
    aeSelectedPreviousItem;
    seeManagers;
    managerSelected;
    managers;
    manager;
    accounts;
    accountSelectedId;
    accountSelectedNameOpp;
    accountSelectedNameSub;
    accountSelectedPreviousItem;
    subscriptions;
    opps;
    oppSelectedId;
    oppSelectedName;
    oppsSearchAllForAE; // true or
    oppRows;
    whitespaces; // not using
    wsGroups; // the actual whitespace
    showError;
    testing;
    firstAEclick;
    firstAccountClick;
    myObject;
    isModalOpen;
    longText;

    openModal() {
        this.isModalOpen = true;
    }
    closeModal() {
        this.isModalOpen = false;
    }
    showManagers(){
        if ( this.seeManagers == true ) this.seeManagers = false;
        else this.seeManagers = true;
    }
    myManager(event){
        this.showManagers();
        this.managerSelected = event.target.dataset.item;
        this.manager = this.managerSelected;
        this.loadAEs();
    }


    aeSelected(event){
        // alert(event.target.dataset.item);
        this.aeSelectedName = event.target.dataset.name;
        this.manager =event.target.dataset.manager;
        // console.log("test");
        // this.aeSelectedId = event.target.id;  // alert(event.target.dataset.item);
        // this.aeSelectedId = this.aeSelectedId.substring(0,18); // alert(this.aeSelectedId);
        this.aeSelectedId = event.target.dataset.item;
        this.searchAccounts();
        this.aeSelectedlOriginalID = event.target.id;
        if ( this.firstAEclick == true ) { // skip}
            //var myDiv = "div[data-item=" + aeSelectedPreviousItem + "]"; // 
            var myDiv = "div[data-item=" + this.aeSelectedPreviousItem + "]";
            //alert(myDiv);
            //alert(this.template.querySelector(myDiv));
            this.template.querySelector(myDiv).style.removeProperty('background-color'); // backgroundColor = "darkred";
            this.template.querySelector(myDiv).style.removeProperty('color');
            // this.template.querySelector(myDiv).style.color = "white";
        } else this.firstAEclick = true;
        // alert(this.template.querySelector("div[data-item=a0101000003TFD9AAO]")); // .style.backgroundColor = "red";

        event.target.style.backgroundColor = "green";
        event.target.style.color = "white";
        this.aeSelectedlOriginalID = this.aeSelectedId; // event.target.id;
        this.aeSelectedPreviousItem = this.aeSelectedId
        // alert(this.firstClick); 
        
        this.accountSelectedId = ""; 
        this.clearSubscriptions();
        this.clearOpps();
        this.clearOppRows(); 
        this.clearWsGroups();
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
            // this.clearWsGroups();
        } else {
            this.searchsSubscriptions();
        }
        this.oppsSearchAllForAE = false;
        this.searchOpps();
        this.clearOppRows();
        this.getWhiteSpaceGroups();
        
        // event.target.parentElement.style.backgroundColor = "green";
        // event.target.parentElement.style.color = "white";
        
        // alert(myObject);
        if ( this.firstAccountClick == true ) { 
            
            //alert(myObject);
            //myObject.style.removeProperty('background-color');
            //alert("fail");
            //var myTD = "tr[data-item=" + this.accountSelectedPreviousItem + "]";
            //this.template.querySelector(myTD).style.removeProperty('background-color'); // backgroundColor = "darkred";
            // this.template.querySelector(myTD).style.removeProperty('color');
        } else this.firstAccountClick = true;
        this.accountSelectedPreviousItem = this.accountSelectedId;
       // myObject = event.target.parentElement;
        
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
    clearWsGroups(){
        this.wsGroups = [];
    }

    loadAEs(event) {
        // alert("1");
        findAEs()  // findAEs({managerName: this.manager}) 
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

    loadManagers(event) {
        findManagers() 
            .then((result) => {
                this.managers = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.managers = undefined;
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

    /*
    searchWhiteSpace(event){
        findWhiteSpace({accountId: this.aeSelectedId})
        .then((result) => {
            this.whitespaces = result;
            this.error = undefined; 
        })
        .catch((error) => {
            // alert("err");
            this.whitespaces = undefined;
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
    }*/

    
    getWhiteSpaceGroups(event){ // alert(this.aeSelectedId);
        getWSGroups({accountId: this.accountSelectedId})
        .then((result) => {
            this.wsGroups = result;
            this.error = undefined; 
        })
        .catch((error) => {
            // alert("err");
            this.wsGroups = undefined;
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
        this.loadManagers();
        // this.searchAccounts();
        // this.accountSelectedId = "0010100000SoV7dAAF";
        // this.searchsSubscriptions();
        // this.searchOpps();
        // this.searchOppRows();
        // this.accountSelectedId = "0010100000TJrvEAAT";
        // this.searchWhiteSpace();

        this.accountSelectedId = "";
        this.oppsSearchAllForAE = ""; // set to empty string
        this.firstAEclick = false;
        this.firstAccountClick = false;
        this.isModalOpen = false;
        this.seeManagers = false;
        this.managerSelected = "";
        this.manager = "";
        this.longText = "Email from Thiago: Unfortunately I do not have good news. We are facing a delay in the implementation in Brazil and already had a budget cut in 2021 for the implementation of the project itself. Of course it is still the beginning of the year and it...";
    }
}