@isTest
global class PokeApiServiceHttpCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('[{"data": "test"}]');
        response.setStatusCode(200);
        return response; 
    }
}