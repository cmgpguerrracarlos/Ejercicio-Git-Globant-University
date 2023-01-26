({
	search : function(component, event, helper) {
        helper.helpSearch(component, event, helper);
	},
    
    save : function(component, event, helper) {
		helper.helpSave(component, component.get("v.newPersonaje"));
	}
})