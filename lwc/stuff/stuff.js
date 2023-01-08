import { LightningElement } from 'lwc';

import loadStuff from '@salesforce/apex/stuffController.getStuff';
import updateDone from '@salesforce/apex/stuffController.markDone';
import { NavigationMixin } from 'lightning/navigation';

const columns = [
    /*{ label: ' ', fieldName: 'Completed__c', type: 'checkbox' }, */
    /*{ type: "button", initialWidth: 85, typeAttributes: {  
        label: 'Done',  
        name: 'Done',  
        title: 'Done',  
        disabled: false,  
        value: 'done',  
        iconPosition: 'left', 
    } },*/
    { label: "Done", type: 'button-icon', initialWidth: 30,  
                  typeAttributes: { 
                    name: "DoneIcon", iconName: 'utility:settings', iconPosition: 'center' }
                  }, // iconName: 'utility:settings', 

    { label: 'Completed', fieldName: 'Completed__c', type:"boolean", initialWidth: 10 },  
    { label: 'Item', fieldName: 'Name', type:"text" },  /*  , editable: true  */
    { type: "button", initialWidth: 90, typeAttributes: {  
        label: 'Edit',  
        name: 'Edit',  
        title: 'Edit',  
        disabled: false,  
        value: 'edit',  
        iconPosition: 'left'
    } }
    
]; 

export default class Stuff extends NavigationMixin(LightningElement) { // extends LightningElement {

    version = 'v.20';
    stuffs;
    error;
    columns = columns;
    theRecordId;

    getAllStuff(event) {
        // alert("1");
        loadStuff() 
            .then((result) => {
                this.stuffs = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.stuffs = undefined;
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

    newStuff (event){
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                objectApiName: "Stuff__c",
                actionName: "new"
            },
        });
    }

    callRowAction( event ) {  
          
        const recId =  event.detail.row.Id;  
        this.theRecordId = event.detail.row.Id;  
        const actionName = event.detail.action.name;  
        if ( actionName === 'Edit' ) {  
            // alert(recId);
            this.navigateToEditStuffPage();
        } else {
        if ( actionName === 'Done' || actionName === 'DoneIcon') {   // alert('>>' + this.theRecordId);
            this.markStuffDone(); // this.navigateToEditStuffPage();
        } else {
            alert("Row Action not found: " + actionName)
        }}
    }

    markStuffDone(){
        try{
            updateDone({recId: this.theRecordId});  // alert('done');
        } catch (e) {
            alert(e);
        }
    }

    // Navigate to Edit Account Record Page
    navigateToEditStuffPage() {
        // alert('1');
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.theRecordId,
                objectApiName: 'Stuff__c',
                actionName: 'edit'
            }
        })
        // .then( this.navigateToTab() );
    }

    navigateToTab() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'Stuff'
            }
        });
    }

    refreshStuff(){
        this.getAllStuff(); // this.navigateToTab();
    }

    connectedCallback() {
        this.getAllStuff();
    }

}