({
    addAuthor : function(component) {
        var book = component.get('v.book');
        var authorGenreKey = component.get('v.recordKey');
        var authors = component.get('v.actionRecords');
        var addAuthor = component.get("c.addNewAuthorToBook");
        var chekResult = this.checkAuthorGenre(book.bookAuthors,
                                               'authorName',
                                               authors[authorGenreKey].recordName)
        if(chekResult == true){
            this.showToast(component,'This Author alredy exist.','warning');
            return;
        }
            
            
            addAuthor.setParams({'bookId': book.recordId,
                                 'authorId': authors[authorGenreKey].recordId});
            
            addAuthor.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var newAuthor =response.getReturnValue();
                    newAuthor.authorName = authors[authorGenreKey].recordName;
                    if(book.bookAuthors != undefined){
                        book.bookAuthors.push(newAuthor)
                    } else{
                        book.bookAuthors = [];
                        book.bookAuthors.push(newAuthor);
                    }
                    component.set('v.book',book);
                }else if(state === "ERROR"){
                    this.showToast(component,response.getError()[0].message,'error');
                }
            });
            $A.enqueueAction(addAuthor);
        
    },
    addGenre: function(component) {
        var book = component.get('v.book');
        var genreKey = component.get('v.recordKey');
        var genres = component.get('v.actionRecords');
        var addGenre = component.get("c.AddNewGenreToBook");
                var chekResult = this.checkAuthorGenre(book.bookGenres,
                                               'genreName',
                                               genres[genreKey].recordName)

        if(chekResult == true){
            this.showToast(component,'This Genre alredy exist.','warning');
            return;
        }
        
        addGenre.setParams({'bookId': book.recordId,
                            'genreId': genres[genreKey].recordId});
        
        addGenre.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var newGenre =response.getReturnValue();
                newGenre.genreName = genres[genreKey].recordName;
                if(book.bookGenres != undefined){
                    book.bookGenres.push(newGenre)
                } else{
                    book.bookGenres = [];
                    book.bookGenres.push(newGenre);
                }
                component.set('v.book',book);
            }
        });
        $A.enqueueAction(addGenre);
    },
    checkAuthorGenre: function(book, bookname,checkName){
        for(var item in book){
            if(book[item][bookname] !== undefined){

                if(book[item][bookname] == checkName){
                    return true;
                }
            }
        }
    },
    hideModal: function(component) {
        component.set('v.modalStatus',false);
    },
    showToast : function(component,toastMsg,ToastType) {
        var errorToastEvent = $A.get("e.force:showToast");
        errorToastEvent.setParams({
            "title": ToastType,
            "message": toastMsg,
            "type": ToastType
        });
        errorToastEvent.fire();
    },
    
})