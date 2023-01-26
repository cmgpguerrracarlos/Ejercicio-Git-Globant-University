import { LightningElement } from 'lwc';

export default class BodyTest extends LightningElement {

    
    handlenext(){
        this.dispatchEvent(new CustomEvent('inc'));
    }

    handleprev(){
        this.dispatchEvent(new CustomEvent('dec'));
    }
}