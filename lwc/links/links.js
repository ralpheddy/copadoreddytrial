import { LightningElement, wire } from 'lwc';

import findLinks from '@salesforce/apex/findLinks.getLinks';

export default class LinksList extends LightningElement {
    links;
    version = 3.2;
    x = 1;
    searchText = 'sm';
    searchValue = '';

    searchKeyword(event) {
        this.searchValue = event.target.value;  // alert (this.searchValue);
    }

    handleEnter(event){
        if(event.keyCode === 13){
          this.handleSearch();
        }
    }

    handleSearch(event) {
        findLinks({searchValue: this.searchValue}) // ({searchValue: this.isBigBetChecked, isSortByRVPchecked: this.isSortByRVPchecked, isSortByADchecked: this.isSortByADchecked})
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
    }
    

    
}