({
    ShowHideModal: function(component, event, helper) {
        var modalStatus = component.get('v.modalStatus');
        var modal = component.find('modal');
        
        if(modalStatus == true){
            $A.util.removeClass(modal, 'slds-hide');
        } else {
            $A.util.addClass(modal, 'slds-hide');
        }
    },
    hideModalWindow: function(component, event, helper) {
        helper.hideModal(component);
    },
    changeRecord: function(component, event, helper) {
        var authorGenreKey = component.get('v.recordKey');
        var authorsGenres = component.get('v.actionRecords');
        var componentAction = component.get('v.actionName');
        
        switch(componentAction) {
            case 'Author':
                helper.addAuthor(component);
                helper.hideModal(component);
                break;
            case 'Genre':
                helper.addGenre(component);
                helper.hideModal(component);
                break;
        }
        
    },
    handleSelect : function(component, event, helper) {
        var authorGenreKey = event.getSource().get("v.value");
        component.set('v.recordKey',authorGenreKey);
    }
})