import { LightningElement } from 'lwc';

export default class Cronometer extends LightningElement {
    time = '00:00';
    secs = 0;
    myInterval;
    
    clockHandlerStart(){
        this.setTime();
    }

    clockHandlerStop(){
        this.time = '00:00';
        this.secs = 0;
        clearInterval(this.myInterval);
    }

    clockHandlerPause(){
        clearInterval(this.myInterval);
    }

    setTime() {
       this.myInterval = setInterval(() => {
            var min = 0;
            var sec = 0;
            this.secs = this.secs + 1;
            if(this.secs > 59){
                sec = this.secs % 60;
                min = (this.secs - sec)/ 60;
                if(sec < 10){
                    this.time = '0'+ min + ':0' + sec;
                }else{
                    this.time = '0'+ min + ':' + sec;
                }
            }else{
                sec = this.secs;
                if(sec < 10){
                    this.time = '00'+ ':0' + sec;
                }else{
                    this.time = '00'+ ':' + sec;
                }
            }
        }, 1000);
    }
    
}