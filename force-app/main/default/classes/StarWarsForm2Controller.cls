public with sharing class StarWarsForm2Controller {
    private static final String swapi = 'https://www.swapi.tech/api';
    @AuraEnabled
    public static StarWarsPersonaje__c savePersonaje(StarWarsPersonaje__c personaje){
        String idm = personaje.Name;
        List<StarWarsPersonaje__c> existente = [SELECT Name FROM StarWarsPersonaje__c WHERE Name = :idm ];
        if(existente.size() > 0){
            return null;
        }
        insert personaje;
      	return personaje;
    }
    
 	@AuraEnabled
    public static StarWarsPersonaje__c findById(Integer id){
        String urlApi = swapi +'/people/'+id;
        HttpResponse response = getHttpResponse(urlApi, 'GET');
        if(response.getStatusCode() == 200) {
            Map<String,Object> properties = getMapProperties(response);
            String planetaUrl = properties.get('homeworld').toString();
            HttpResponse response2 = getHttpResponse(planetaUrl, 'GET');            
            Map<String,Object> properties2 = getMapProperties(response2);
                       
            return new StarWarsPersonaje__c(Name = properties.get('name').toString(), 
                                            Id__c = id, 
                                            gender__c = properties.get('gender').toString(),
                                            height__c = Integer.valueOf(properties.get('height')),
                                            hair_color__c = properties.get('hair_color').toString(),
                                            eye_color__c = properties.get('eye_color').toString(),
                                            url__c = properties.get('url').toString(),
                                            planet__c = properties2.get('name').toString()
                                           );
            
        }
        return null;
    }
    
    private static HttpResponse getHttpResponse(String url, String method){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(url);
		request.setMethod(method);
		return http.send(request);
    }
    
    private static Map<String,Object> getMapProperties(HttpResponse response){
        Map<String,Object> results = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        Map<String,Object> result = (Map<String,Object>)results.get('result');
        return (Map<String,Object>) result.get('properties');
    }
    
    
}