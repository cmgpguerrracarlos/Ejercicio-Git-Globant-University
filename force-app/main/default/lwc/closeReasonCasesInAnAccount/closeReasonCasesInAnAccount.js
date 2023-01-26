import { LightningElement, api, wire, track } from 'lwc';
import getCasesByAccountId from '@salesforce/apex/AccountHelper.getCasesByAccountId';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CloseReasonCasesInAnAccount extends LightningElement {
    @track columns = [
    {
        label: 'Case Number',
        fieldName: 'CaseNumber',
        type: 'text',
        sortable: true
    },
    {
        label: 'Close Reason',
        fieldName: 'CloseReason__c',
        type: 'text',
        editable: true
    },
    {
        label: 'Status',
        fieldName: 'Status',
        type: 'text',
        sortable: true,
    }
    ];


    @api recordId;
    @wire(getCasesByAccountId,{accountid: '$recordId'})
    cases;

    draftValues = [];

    handleSave(event){

        const recordInputs =  event.detail.draftValues.slice().map(draft => {
            if(draft.CloseReason__c != null){
                draft.Status = 'Closed';
            }
            const fields = Object.assign({}, draft);
            return { fields };
        });
    
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(cases => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contacts updated',
                    variant: 'success'
                })
            );
             this.draftValues = [];
             return refreshApex(this.cases);
        }).catch(error => {
            console.log(error);
        });
    }
}