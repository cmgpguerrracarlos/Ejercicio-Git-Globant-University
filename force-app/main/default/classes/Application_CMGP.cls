public with sharing class Application_CMGP {
    //define the UNIT OF WORK
    public static fflib_Application.UnitOfWorkFactory unitOfWork = new fflib_Application.UnitOfWorkFactory(
        new List<SObjectType> {
            Account.SObjectType
        }
    ); 

    //The selector was defined using the SObject class and mapped to the class selector specific
    public static fflib_Application.SelectorFactory selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type>{
            Account.SObjectType => Account_CMGP_selector.class
        }
    );
    
    //Create an instance of domain reciving the instance of selector and with mappin acc type to the respective constructor
    public static fflib_Application.DomainFactory domain = new fflib_Application.DomainFactory(
        Application_CMGP.selector, 
        new Map<SObjectType,Type>{
            Account.SObjectType => AccountsImpl_CMGP.construct.class
        }
    );

    // Finally we define the instance of service mapping the interface with the concrete class
    public static fflib_Application.ServiceFactory service = new fflib_Application.ServiceFactory(
        new Map<Type,Type>{
            Account_CMGP_service.class => Account_CMGP_serviceImpl.class
        }
    );

}