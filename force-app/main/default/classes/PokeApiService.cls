public with sharing class PokeApiService {
    public static HttpResponse getData(String query){
        String endpoint = 'https://pokeapi.co/'+ query;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        return http.send(request);
    }
}