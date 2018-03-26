public with sharing class BooksController {

    @AuraEnabled
    public static BooksSelector[] getbookAfterDelete(Decimal pageNumber,String orderBy){
        String[] fieldsToCheck = new String[] {'Name','Price__c'};
        BooksSelector[] books = null;
        Boolean bookAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book__c','isAccessible');
        Boolean bookFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book__c','isAccessible',fieldsToCheck);

        if(bookAccess &&
            bookFieldsAccess){
            Integer recordlimit = 1;
            Integer offset = (Integer)pageNumber * Config.countRecordsForBookPage -1;
            books = BooksSelector.getBooks(recordlimit, offset, orderBy);
        }else{
            throw new AuraHandledException(Config.errorMsg(0));
        }
        
        return books;
    }
    
    @AuraEnabled
    public static Integer getBookCount(){
        return [SELECT Count() FROM book__c];
    }


    @AuraEnabled
    public static List<BooksSelector> getBooksForPage(Decimal pageNumber,String orderBy){
        
        String[] fieldsToCheck = new String[] {'Name','Price__c'};
        BooksSelector[] books = null;
        Boolean bookAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book__c','isAccessible');
        Boolean bookFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book__c','isAccessible',fieldsToCheck);

        if(bookAccess &&
            bookFieldsAccess){
            Integer recordlimit = Config.countRecordsForBookPage;
            Integer offset = ((Integer)pageNumber - 1) * recordlimit;
            books = BooksSelector.getBooks(recordlimit, offset, orderBy);
        }else{
            throw new AuraHandledException(Config.errorMsg(0));
        }
        
        return books;
    }

    @AuraEnabled
    public static List<GenresSelector> getGenres(){
        String[] fieldsToCheck = new String[] {'Name'};
        GenresSelector[] genres = null;
        Boolean genreAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Genre__c','isAccessible');
        Boolean genreFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Genre__c','isAccessible',fieldsToCheck);

        if(genreAccess &&
            genreFieldsAccess){
            genres = GenresSelector.getGenres();
        }else{
            throw new AuraHandledException(Config.errorMsg(0));
        }
        
        return genres;
    }


    
    @AuraEnabled
    public static List<AuthorsSelector> getAuthors(){

        String[] fieldsToCheck = new String[] {'Name'};
        AuthorsSelector[] authors = null;
        Boolean authorAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Author__c','isAccessible');
        Boolean authorFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Author__c','isAccessible',fieldsToCheck);

        if(authorAccess &&
            authorFieldsAccess){
            authors = AuthorsSelector.getAuthors();
        }else{
            throw new AuraHandledException(Config.errorMsg(0));
        }
        
        return authors;
    }

    @AuraEnabled
    public static List<Map<String,String>> getAvailableActions(){
        List<Map<String,String>> actions;
        bookAndBookAsssociatedRecordsSelector availableActions = new bookAndBookAsssociatedRecordsSelector();
        actions = availableActions.actionsWithBooks();
        
        return actions;
    }

}