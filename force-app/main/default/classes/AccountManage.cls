public with sharing class AccountManage {
        public static Id createAccount(String name, Integer numberOFEmployees, String DocumentNumber, String IdentificationType){
            String documentTypeAndNumber = IdentificationType + DocumentNumber;
            Account acc = new Account(
                Name = name,
                NumberOfEmployees = numberOFEmployees,
                Document_number__c = DocumentNumber,
                Identification_type__c = IdentificationType,
                Document_Type_Number_Id__c = documentTypeAndNumber
            );
            insert acc;
            return acc.Id;
        }

        public static Boolean updateAccount(Id id, String name, Integer numberOFEmployees, String documentNumber, String identificationType){
            String typeNumber = identificationType + documentNumber;
            Account accFromDB = [SELECT Id, Name, NumberOfEmployees, Document_Type_Number_Id__c 
                                FROM Account WHERE Id=:id LIMIT 1];

            if(accFromDB.Document_Type_Number_Id__c == typeNumber){
                return false;
            }

            accFromDB.Name = name;
            accFromDB.NumberOfEmployees=numberOFEmployees;
            accFromDB.Identification_type__c = identificationType;
            accFromDB.Document_number__c = documentNumber;
            accFromDB.Document_Type_Number_Id__c = typeNumber;
            Database.SaveResult result = Database.update(accFromDB);
            return result.success;
        }

        public static Boolean deleteAccount(Id id){
            Database.DeleteResult result = Database.delete(id);
            return result.success;
        }

        public static Account consultAccount(String documentNumber, String identificationType){
            List<Account> acc = [
                            SELECT Id, Name 
                            FROM Account 
                            WHERE Document_number__c = :documentNumber and Identification_type__c = :identificationType
                          ];
            if(acc.size() != 1){
                return null;
            }
            
            return acc.get(0);
        }

        public static void createOpportunity(List<Account> accounts){
            Date today = Date.today();
            Date in30days = today.addDays(30);
            List<Opportunity> Opportunities = new List<Opportunity>();
            for(Account acc: accounts){
                if(acc.Create_opportunity__c == true){
                    String name = 'Opportunity' + acc.Name + String.valueOf(today);
                    
                    Opportunities.add(new Opportunity(
                        Account = acc,
                        Name = name,
                        StageName = 'Prospection',
                        CloseDate = in30days
                    ));
                }
            }
            insert Opportunities;
        }
}