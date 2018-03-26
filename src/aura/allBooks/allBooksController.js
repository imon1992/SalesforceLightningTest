({
    doInit: function(component, event, helper) {
        helper.getBooksCount(component);
        helper.booksForPage(component);
        helper.getAllAuthors(component);
        helper.getAllGenres(component);
        helper.getAilableActions(component);
    },
    changeCurrentBooks: function(component, event, helper) {
        var pageNumber = component.get('v.pageNumber');
        helper.booksForPage(component,pageNumber);
    },
    createnewBook: function(component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "book__c"
        });
        createRecordEvent.fire();
    },
    deleteBook: function(component, event, helper) {
        var bookKey = event.getParam("recordKey");
        var currentBooks = component.get('v.currentBooks');
        var books = component.get('v.books');
        var pageNumber = component.get("v.pageNumber");

        var bookKeyForDelete = bookKey+((pageNumber-1)*10);
        
        books.splice(bookKeyForDelete,1);
        currentBooks.splice(bookKey,1);
        component.set('v.currentBooks',currentBooks);
        component.set('v.books',books);

        var roundUpBookLength = helper.roundUpBookLength(books.length);
        if(roundUpBookLength - bookKeyForDelete< 10){
            helper.newBookAfterDelete(component,pageNumber);
        }
        
        
    },
    sortByName: function(component, event, helper) {
        component.set('v.sortField','Name');
        helper.sortBy(component);
    },
    sortByPrice: function(component, event, helper) {
        component.set('v.sortField','Price__c');
        helper.sortBy(component);
    },
    
})