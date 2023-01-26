import { LightningElement } from 'lwc';

export default class Carlos extends LightningElement {
  greeting = 'World';

  changeHandler1(event) {
    this.greeting = event.target.value;
  }

  changeHandler2(event) {
    this.greeting = event.target.value;
  }
}