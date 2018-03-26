({
    handleMenuSelect: function(component, event, helper) {
        var selectedMenuItemValue = event.getParam("value");
        switch(selectedMenuItemValue) {
            case 'edit':  
                
                var editRecordEvent = $A.get("e.force:editRecord");
                // var sObjectEvent = $A.get("e.force:navigateToSObject");
                editRecordEvent.setParams({
                    "recordId": component.get("v.book.Id")
                });
                editRecordEvent.fire();
                break;
            case 'addAuthor':
                component.set('v.actionName','Author');
                var modal = component.find('author');
                // console.log(modal);
                modal.set('v.modalStatus',true);
                break;
            case 'addGenre':
                component.set('v.actionName','Genre');
                var modal = component.find('genre');
                modal.set('v.modalStatus',true);
                break;
            case 'delete':
                var modal = component.find('delete');
                modal.set('v.modalStatus',true);
                break;
        }
    },
    
    // changeRecord: function (component, event) {
    //     // console.log('aaaa');
    //     var c = event.getParam('newDataForBook');
        
    //     // console.log(JSON.parse(JSON.stringify(c)));
    // }
    
})