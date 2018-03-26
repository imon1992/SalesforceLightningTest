({
    goToRecord : function(component, event, helper) {
        // Fire the event to navigate to the contact record
        console.log('aaa');
        var sObjectEvent = $A.get("e.force:navigateToSObject");
        sObjectEvent.setParams({
            "recordId": component.get("v.book.Id")
        })
        sObjectEvent.fire();
    },
})