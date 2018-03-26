public class GenresSelector {
    @AuraEnabled
    public String recordId;
    @AuraEnabled
    public String recordName ;
    
    public GenresSelector(String recId) {
        this.recordId = recId;
    }
    
    public static List<GenresSelector> getGenres()
    {
        List<GenresSelector> allGenres = new List<GenresSelector>();
        List<Genre__c> genres = null;

        genres = [SELECT id,name 
                    FROM Genre__c
                    ORDER BY name]; 
                    
        for (Genre__c e: genres)
        {
            GenresSelector i = new GenresSelector(e.id);
            i.recordName = e.Name;

            allGenres.add(i);
        }
        return allGenres;
    }

    public static GenresSelector addAuthorToBook(Id bookId,Id genreId)
    {
        Book_Genre__c bookRenre;
        try {
            bookRenre = new Book_Genre__c(Book__c = bookId, Genre1__c = genreId);
            insert bookRenre;
        } catch(Exception e) {
            throw new DmlException(e);
        }

        GenresSelector newGenre = new GenresSelector(bookRenre.id);

        return newGenre;
    }
}