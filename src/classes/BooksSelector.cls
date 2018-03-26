public with sharing class BooksSelector {
    @AuraEnabled
    public String recordId;
    @AuraEnabled
    public String bookName;
    @AuraEnabled
    public List<BookGenres> bookGenres;
    @AuraEnabled
    public List<BookAuthor> bookAuthors;
    @AuraEnabled
    public Decimal price;
    


    public BooksSelector(String recId) {
        this.recordId = recId;
    }
    


    public static List<BooksSelector> getBooks(Integer pSize,Integer offset,String orderBy)
    {
        List<BooksSelector> bookForPage = new List<BooksSelector>();

        List<Book__c> books = Database.query('SELECT Name,Price__c,'+
                    		'(SELECT genre1__r.name FROM Book_genres__r),'+
                    		'(SELECT author__r.name FROM Book_authors__r)'+
                             '  FROM Book__c '+
                               'ORDER BY '+orderBy +
                               ' LIMIT '+ pSize +' OFFSET '+offset); 

        for (Book__c book: books)
        {
            BooksSelector oneBook = new BooksSelector(book.Id);
          List<BookGenres> bookGenres = new List<BookGenres>();
          List<BookAuthor> bookAuthors = new List<BookAuthor>();
          for (Book_Genre__c bookGenre: book.Book_Genres__r){
                BookGenres genreForBook = new BookGenres();
                genreForBook.recordId = bookGenre.Genre1__r.Id;
                genreForBook.genreName = bookGenre.Genre1__r.Name;
                bookGenres.add(genreForBook);
            }
            for (Book_Author__c bookAuthor: book.Book_Authors__r){
                BookAuthor authorForBook = new BookAuthor();
                authorForBook.recordId = bookAuthor.Author__r.Id;
                authorForBook.authorName = bookAuthor.Author__r.Name;
                bookAuthors.add(authorForBook);
            }
            oneBook.bookGenres = bookGenres;
            oneBook.bookAuthors = bookAuthors;
            oneBook.bookName = book.Name;
            oneBook.price = book.Price__c;
            bookForPage.add(oneBook);
        }
        return bookForPage;
    }

    public static Boolean deleteBookAndBookAssociated(Book__c[] objectForDelete){
        try {
            delete objectForDelete;
        } catch(Exception e) {
            throw new DmlException(e);
        }
        return true;
    }

    public static Book__c[] getBookById(Id bookId){
        Book__c[] bookForDelete = [SELECT Name,
                      (SELECT genre1__r.name FROM Book_genres__r),
                      (SELECT author__r.name FROM Book_authors__r)
                      FROM book__c
                      where id = :bookId];
        return bookForDelete;
    }
    public class BookGenres {
        @AuraEnabled
        public String genreName { get;set; }
        
        @AuraEnabled
        public String recordId { get;set; }
    }

    public class BookAuthor {
        @AuraEnabled
        public String authorName { get;set; }
        
        @AuraEnabled
        public String recordId { get;set; }

    }
}