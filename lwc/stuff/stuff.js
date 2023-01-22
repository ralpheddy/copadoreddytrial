import { LightningElement } from 'lwc';

import loadStuff from '@salesforce/apex/stuffController.getStuff';
import loadStaples from '@salesforce/apex/stuffController.getStaples';
import insertStuffFromStaples from '@salesforce/apex/stuffController.addStuffFromStaple';
import updateDone from '@salesforce/apex/stuffController.markDone';
import loadCheckList from '@salesforce/apex/stuffController.getCheckList';
import loadCheckListMV from '@salesforce/apex/stuffController.getCheckListMV';
import { NavigationMixin } from 'lightning/navigation';

    /*{ label: ' ', fieldName: 'Completed__c', type: 'checkbox' }, */
const columns = [
    { label: "Done", type: 'button-icon', initialWidth: 30,  
                  typeAttributes: { 
                    name: "DoneIcon", iconName: 'action:remove', iconPosition: 'center' }
                  }, // iconName: 'utility:settings', 
    // { label: 'Completed', fieldName: 'Completed__c', type:"boolean", initialWidth: 10 },  
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

const columnsStaple = [
    { label: 'Item', fieldName: 'Name', type:"text" },  
    { type: "button", initialWidth: 90, typeAttributes: {  
        label: 'Add',  name: 'Add',  title: 'Add',  disabled: false,  value: 'add',  iconPosition: 'left'} 
    },  
    { type: "button", initialWidth: 90, typeAttributes: {  
        label: 'Edit',  name: 'Edit',  title: 'Edit',  disabled: false,  value: 'edit',  iconPosition: 'left'} 
    }
]; 

const columnsCheckList = [
    { label: 'Verify', fieldName: 'Name', type:"text" },
]; 

export default class Stuff extends NavigationMixin(LightningElement) { // extends LightningElement {
    version = 'v.43';
    stuffs;
    staples;
    checkList;
    checkListMV;
    error;
    columns = columns;
    columnsStaple = columnsStaple;
    columnsCheckList = columnsCheckList;
    theRecordId;
    theRecordName;

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
        this.theRecordName = event.detail.row.Name;  //   alert(this.theRecordName);
        // alert(JSON.stringify(event.detail.row)); // JSON.stringify(event.detail.row)
        const actionName = event.detail.action.name;  
        if ( actionName === 'Edit' ) {   // alert(recId);
            this.navigateToEditStuffPage();
        } else if ( actionName === 'Add') {   // alert('>>' + this.theRecordId);
            this.addStapleToStuff(); // this.theRecordName); 
        } else if ( actionName === 'Done' || actionName === 'DoneIcon') {   // alert('>>' + this.theRecordId);
            this.markStuffDone(); // this.navigateToEditStuffPage();
        } else {
            alert("Row Action not found: " + actionName)
        }
    }

    addStapleToStuff(){
        // alert (this.theRecordId);
        // alert (this.theRecordName);
        try{
            insertStuffFromStaples({description: this.theRecordName});
        } catch (e) {
            alert(e);
        }
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
    refreshStaples(){
        this.getAllStaples(); // this.navigateToTab();
    }

    showStaples(){
        this.getAllStaples();
    }
    getAllStaples(event) {
        // alert("1");
        loadStaples() 
            .then((result) => {
                this.staples = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.staples = undefined;
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

    getCheckList(event) {
        // alert("1");
        loadCheckList() 
            .then((result) => {
                this.checkList = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.checkList = undefined;
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

    getCheckListMV(event) {
        // alert("1");
        loadCheckListMV() 
            .then((result) => {
                this.checkListMV = result;
                this.error = undefined;
            })
            .catch((error) => {
                this.checkListMV = undefined;
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
        this.getAllStuff();
        this.getAllStaples();
        this.getCheckList();
        this.getCheckListMV();
    }

}