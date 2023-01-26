public class AccountUtils {
    public static List<Account> accountsByState(String bill){
     	return [SELECT ID,Name FROM Account WHERE BillingState= :bill];
    }
}