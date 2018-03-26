public class bookAndBookAsssociatedRecordsSelector {
    
    private String errMsg;
    
    public List<Genre__c> getAllGenres(){
         String[] fieldsToCheck = new String[] {'Name'};
             Genre__c[] result = null;
             Boolean genreAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Genre__c','isAccessible');
             Boolean genreFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Genre__c','isAccessible',fieldsToCheck);
        try{
            if(genreAccess &&
                genreFieldsAccess){
                result = [SELECT name from Genre__c];
            }else{
                this.setErrMsg(0);
            }
        }catch(DMLException e){
            this.setErrMsg(2);
            return null;
        }
        
        return result;
    }
    
    public String getErrMsg(){
        return errMsg;
    }
    
    public List<Author__c> getAllAuthors(){
        String[] fieldsToCheck = new String[] {'Name'};
        Author__c[] result = null;
        Boolean authorAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Author__c','isAccessible');
        Boolean authorFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Author__c','isAccessible',fieldsToCheck);
        try{
            if(authorAccess &&
                authorFieldsAccess){
                result = [SELECT name from Author__c];
            }else{
                this.setErrMsg(3);
            }
        }catch(DMLException e){
            this.setErrMsg(2);
            return null;
        }
        
        return result;
    }

    public List<Map<String,String>> actionsWithBooks(){
        // List<Map<String,String>>
        List<Map<String,String>> actions = new List<Map<String,String>>();
        String[] bookAuthorFields = new String[] {'Book__c','Author__c'};
        String[] bookGenreFields = new String[] {'Book__c','Genre1__c'};
        String[] bookFields = new String[] {'Name','Price__c'};

        Boolean bookUpdateAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book__c','isUpdateable');
        Boolean bookDeleteAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book__c','isDeletable');
        Boolean bookFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book__c','isUpdateable',bookFields);
        Boolean bookAuthorAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book_Author__c','isCreateable');
        Boolean bookAuthorFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book_Author__c','isCreateable',bookAuthorFields);
        Boolean bookGenreAccess = ObjectAndFieldsAccessCheck.checkAccessToObject('Book_Genre__c','isCreateable');
        Boolean bookGenreFieldsAccess = ObjectAndFieldsAccessCheck.checkAccessToObjectFields('Book_Genre__c','isCreateable',bookGenreFields);

        // String objectForCheck = 'Book_Author__c';

        if(bookUpdateAccess &&
            bookFieldsAccess){
                Map<String, String> addGenre = new Map<String, String>();
                addGenre.put('label','Edit');
                addGenre.put('value','edit');
                actions.add(addGenre);
            }

        if(bookAuthorAccess &&
            bookAuthorFieldsAccess){
                Map<String, String> addAuthor = new Map<String, String>();
                addAuthor.put('label','Add Author To Book');
                addAuthor.put('value','addAuthor');
                actions.add(addAuthor);
            }

        if(bookGenreAccess &&
            bookGenreFieldsAccess){
                Map<String, String> addGenre = new Map<String, String>();
                addGenre.put('label','Add Genre To Book');
                addGenre.put('value','addGenre');
                actions.add(addGenre);
            }
            
        if(bookDeleteAccess){
                Map<String, String> addGenre = new Map<String, String>();
                addGenre.put('label','Delete Book');
                addGenre.put('value','delete');
                actions.add(addGenre);
            }

        return actions;
    }
    
    private void setErrMsg(Integer errCode){
        Map<Integer,String> errors= new Map<Integer,String> {0=>'Do not have access to Genre fields or object',
        1=>'Do not have access to edit record',
        2=>'Somthing wrong with Record',
        3=>'Do not have access to Author fields or object'};
        this.errMsg = errors.get(errCode);
    }
    // public Boolean checkAccessToObjectFields(String objectName,String accessType,List<String> fieldsToCheck){
        
    //     SObjectType schemaType = Schema.getGlobalDescribe().get(objectName);
    //     Map<String, SObjectField> objectFieldMap = schemaType.getDescribe().fields.getMap();

    //     if(accessType == 'isAccessible'){
    //         for (String fieldToCheck : fieldsToCheck) {
    //             if (!objectFieldMap.get(fieldToCheck).getDescribe().isAccessible()) {
    //                 return false;
    //             }
    //         }
    //     }
        
    //     if(accessType == 'isCreateable'){
    //         for (String fieldToCheck : fieldsToCheck) {
    //             if (!objectFieldMap.get(fieldToCheck).getDescribe().isCreateable()) {
    //                 return false;
    //             }
    //         }
    //     }
    //     if(accessType == 'isUpdateable'){
    //         for (String fieldToCheck : fieldsToCheck) {
    //             if (!objectFieldMap.get(fieldToCheck).getDescribe().isUpdateable()) {
    //                 return false;
    //             }
    //         }
    //     }
        
    //     return true;
    // }

    // public Boolean checkAccessToObject(String objectName,String accessType){
        
    //     if(accessType == 'isAccessible'){
    //         if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isAccessible()){
    //             return false;
    //         }
    //     }
        
    //     if(accessType == 'isCreateable'){
    //         if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isCreateable()){
    //             return false;
    //         }
    //     }
        
    //     if(accessType == 'isUpdateable'){
    //         if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isUpdateable()){
    //             return false;
    //         }
    //     }
        
    //     if(accessType == 'isDeletable'){
    //         if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isDeletable()){
    //             return false;
    //         }
    //     }
    //     return true;
    // }

}