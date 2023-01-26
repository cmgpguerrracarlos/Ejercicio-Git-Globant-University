public with sharing class ReasonToCloseCase {
    public static void updateReason(List<Case> cases){
        for(Case aCase: cases){
            aCase.Status = 'Closed';
        }
    }
}