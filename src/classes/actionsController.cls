public with sharing class actionsController {
    
    @AuraEnabled
    public static AuthorsSelector addNewAuthorToBook(Id bookId,Id authorId){

        String[] fieldsToCheck = new String[] {'Book__c','Author__c'};
        AuthorsSelector newAuthor;
        
        Boolean bookAuthorAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book_Author__c','isCreateable');
        Boolean bookAuthorFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book_Author__c','isCreateable',fieldsToCheck);

        try{
            if(bookAuthorAccess &&
                bookAuthorFieldsAccess){
                newAuthor = AuthorsSelector.addAuthorToBook(bookId,authorId);
            }else{
                throw new AuraHandledException(Config.errorMsg(1));
            }
        }catch(DmlException e){
            throw new AuraHandledException(Config.errorMsg(4));
        }
        return newAuthor;
        
    }
    
    @AuraEnabled
    public static GenresSelector AddNewGenreToBook(Id bookId,Id genreId){
        String[] fieldsToCheck = new String[] {'Book__c','Genre1__c'};

        GenresSelector newGenre;
        
        Boolean bookAuthorAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book_Genre__c','isCreateable');
        Boolean bookAuthorFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book_Genre__c','isCreateable',fieldsToCheck);

        try{
            if(bookAuthorAccess &&
                bookAuthorFieldsAccess){
                newGenre = GenresSelector.addAuthorToBook(bookId,genreId);
            }else{
                throw new AuraHandledException(Config.errorMsg(1));
            }
        }catch(DmlException e){
            throw new AuraHandledException(Config.errorMsg(4));
        }
        return newGenre;
    }
    
    @AuraEnabled
    public static Boolean deleteBook(Id bookIdForDelete){
        Boolean deleteResult;
        Book__c[] bookForDelete;
        Boolean bookDeleteAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book__c','isDeletable');

        try{
            if(bookDeleteAccess ){
                bookForDelete = BooksSelector.getBookById(bookIdForDelete);
                deleteResult = BooksSelector.deleteBookAndBookAssociated(bookForDelete);
            }else{
                throw new AuraHandledException(Config.errorMsg(5));
            }
        }catch(DmlException e){
            throw new AuraHandledException(Config.errorMsg(6));
        }
        return deleteResult;
    }
}