({
	helpSearch : function(component, event, helper) {
        component.set("v.aviso", "");
        let id = component.get("v.nroPersonaje");
        let action = component.get("c.findById");
        action.setParams({
            "id":id
        });
        
        action.setCallback(this, function(response){
            let state = response.getState();
            let personaje = response.getReturnValue();
            if (state === "SUCCESS" && personaje !== null) {
                component.set("v.buscado",true);
                component.set("v.newPersonaje", personaje);
                component.set("v.error", "");
            }else{
                component.set("v.error", "[*] No es valido");
            }
        });
        $A.enqueueAction(action);
	},
    helpSave : function(component, personaje) {
        let action = component.get("c.savePersonaje");
        action.setParams({
            "personaje": personaje
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            let respuesta = response.getReturnValue();
            if (state === "SUCCESS" && respuesta !== null) {
                component.set("v.aviso", "Agregado... ");
                component.set("v.error", "");
            }else{
                component.set("v.error", "[*] Ya existe... ");
                component.set("v.aviso", "");
            }
        });
        $A.enqueueAction(action);

	}
})