public class AuthorsSelector {
    @AuraEnabled
    public String recordId;
    @AuraEnabled
    public String recordName ;
    
    public AuthorsSelector(String recId) {
        this.recordId = recId;
    }
    
    public static List<AuthorsSelector> getAuthors()
    {
        List<AuthorsSelector> allAuthors = new List<AuthorsSelector>();
        List<Author__c> authors = null;

        authors = [SELECT id,name 
                    FROM Author__c
                    ORDER BY name]; 

        for (Author__c e: authors)
        {
            AuthorsSelector i = new AuthorsSelector(e.id);
            i.recordName = e.Name;

            allAuthors.add(i);
        }
        return allAuthors;
    }

    public static AuthorsSelector addAuthorToBook(Id bookId,Id authorId)
    {
        Book_Author__c bookAuthor;
        try {
            bookAuthor = new Book_Author__c(Book__c = bookId, Author__c = authorId);
            insert bookAuthor;
        } catch(Exception e) {
            throw new DmlException(e);
        }

        AuthorsSelector newAuthor = new AuthorsSelector(bookAuthor.id);

        return newAuthor;
    }
}