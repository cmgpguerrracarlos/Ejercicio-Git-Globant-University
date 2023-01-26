@isTest
public with sharing class PokeApiServiceTest {
    @isTest
    static void WillReturnResponseFromTheApi(){
        Test.setMock(HttpCalloutMock.class, new PokeApiServiceHttpCalloutMock()); 
        
        HttpResponse response = PokeApiService.getData('data');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = response.getBody();
        String expectedValue = '[{"data": "test"}]';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

}