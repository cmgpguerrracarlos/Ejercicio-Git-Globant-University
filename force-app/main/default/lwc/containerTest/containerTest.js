import { LightningElement } from 'lwc';

export default class ContainerTest extends LightningElement {
    pageparent = 1;

    inchandler(){
        this.pageparent += 1;
    }

    dechandler(){
       if(this.pageparent > 1) {
        this.pageparent -= 1;
    }   
        
    }
}