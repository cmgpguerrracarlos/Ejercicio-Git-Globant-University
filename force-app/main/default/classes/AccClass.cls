public with sharing class AccClass {
    
    public static String metododeprueba(String val){


        if(val == 'false'){
            return 'true';
        }
        
        if(val == 'true' || 
        val == null){
            return 'false';
        }
        return '';
        
    }
}