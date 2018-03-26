({
    ShowHideModal: function(component, event, helper) {
        var modalStatus = component.get('v.modalStatus');
        var modal = component.find('modal');
        
        if(modalStatus == true){
            console.log(modalStatus);
            $A.util.removeClass(modal, 'slds-hide');
        } else {
            $A.util.addClass(modal, 'slds-hide');
        }
    },
    hideModalWindow: function(component, event, helper) {
        helper.hideModal(component);
    },
    deleteRecord: function(component, event, helper) {
        var bookId = component.get('v.bookId');
        
        var bookForDelete = component.get("c.deleteBook");
        
        // console.log(bookForDelete);
        bookForDelete.setParams({'bookIdForDelete': bookId});

        bookForDelete.setCallback(this, function(response) {
            var state = response.getState();
            // console.log(state);
            
            if (state === "SUCCESS") {
                var deleteResult = response.getReturnValue();
                // console.log(deleteResult);
                if(deleteResult == true){
                    var bookKey = component.get('v.bookKey');
                //    console.log('dsasdads'); 
                    var cmpEvent = component.getEvent("deleteBook");
                    cmpEvent.setParams({'recordKey':bookKey});
                    cmpEvent.fire(); // возбуждаем event
                    helper.hideModal(component);
                }
                
                
            }
        });
		
        $A.enqueueAction(bookForDelete);
        
    },
})