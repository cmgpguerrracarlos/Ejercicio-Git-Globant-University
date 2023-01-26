public class AnimalLocator {
    public static String getAnimalNameById(Integer nro){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+ nro);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            Object animal = (Object) results.get('animals');
             Map<String, Object> result = (Map<String, Object>) animal;
            return String.valueOf(result.get('name'));
        }
        return null;
    }
}