import { LightningElement, wire } from 'lwc';

import findLinks from '@salesforce/apex/findLinks.getLinks';


import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import LINK_OBJECT from '@salesforce/schema/Link__c';
import TYPE_FIELD from '@salesforce/schema/Link__c.Type__c'; 

export default class LinksList extends LightningElement {
    links;
    version = 3.5;
    x = 1;
    searchText = 'sm';
    searchValue = '';
    allCheck = false;
    valueOfSelectedType ='';
    browserURL = document.URL;
    isLocalhost = false;
    // myPosition = this.browserURL.substring(1, 4);  
    recordsFound = 0;
    myPosition = this.browserURL.indexOf("localhost");
    // if (browserURL.indexOf("localhost"))
    // if ( p > -1 ) isLocalhost = true;
   

    searchKeyword(event) {
        this.searchValue = event.target.value;  // alert (this.searchValue);
    }

    handleEnter(event){
        if(event.keyCode === 13){
          this.handleSearch();
        }
    }

    handleAllCheck(event){
        this.allCheck = event.target.checked;  // alert (this.allCheck);
        // handleSearch(event);
    }
 
    handleSearch(event) {
        findLinks({searchValue: this.searchValue, allCheck: this.allCheck, valueOfSelectedType: this.valueOfSelectedType} ) // ({searchValue: this.isBigBetChecked, isSortByRVPchecked: this.isSortByRVPchecked, isSortByADchecked: this.isSortByADchecked})
            .then((result) => {
                this.links = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.links = undefined;
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
            });
    }

    connectedCallback() {
        this.handleSearch();
        if (this.myPosition > 0) this.browserURL = "localhost";
    }
    
    
    
    // to get the default record type id, if you dont' have any recordtypes then it will get master
    @wire(getObjectInfo, { objectApiName: LINK_OBJECT }) linkMetadata;
    // now get the industry picklist values
    @wire(getPicklistValues,
        {
            recordTypeId: '$linkMetadata.data.defaultRecordTypeId', 
            fieldApiName: TYPE_FIELD
        }
    ) linkPicklist;
    // on select picklist value to show the selected value
    handleChange(event) {
        this.valueOfSelectedType = event.detail.value;
    }
    
    handleOpen(event){
        alert("open");
        window.open('/lightning/n/Links', 'Links Tab', 'titlebar=no,menubar=no,location=no');
    }

}