({
    getBooksCount: function(component,event){
        var booksCount = component.get('c.getBookCount');

        booksCount.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var count = response.getReturnValue();
                 component.set('v.totalBooks',count);
                component.set("v.maxPage", Math.floor((count+9)/10));
            }
        });
        
        $A.enqueueAction(booksCount);
    },

    booksForPage: function(component, pageNumber) {
        var allBooksOnPage = component.get('v.books');

        var currentBooksLength = allBooksOnPage.length;
        var allBooksCount = component.get('v.totalBooks');
        pageNumber = pageNumber || 1;
        var booksForNextPage = pageNumber * 10;
        if(booksForNextPage > allBooksCount){
            booksForNextPage = allBooksCount - 1;
        }
        if(currentBooksLength < booksForNextPage){
            this.getBooks(component,allBooksOnPage,pageNumber);
        } else {
            var booksForPage = allBooksOnPage.slice((pageNumber-1)*10,(pageNumber-1)*10+10*1);
            component.set('v.currentBooks',booksForPage);
        }
        // var spinner = component.find("spinner");
        // $A.util.removeClass(spinner, "slds-hide");
        // setTimeout(() => {
        //     component.set('v.loaded',false);
        // }, 5000);
        
    },

    getBooks: function(component,allBooksOnPage,pageNumber){
        var orderBy = component.get('v.sortField');
        var booksPerPage = component.get("c.getBooksForPage");
            booksPerPage.setParams({"pageNumber": pageNumber,
            "orderBy": orderBy
            });
    
            booksPerPage.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var booksForPage =response.getReturnValue();
                    for(var i in booksForPage){
                        allBooksOnPage.push(booksForPage[i]);
                    }
                    component.set('v.books',allBooksOnPage);
                    component.set('v.currentBooks',booksForPage);
                }
            });
            
            $A.enqueueAction(booksPerPage);
    },
    getAllAuthors: function(component){
        var getAuthors = component.get('c.getAuthors');
        getAuthors.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var authors =response.getReturnValue();
                component.set('v.authors',authors);
            }else if(state === "ERROR"){
                this.showToast(component,response.getError()[0].message,'error');
            }
        });
        $A.enqueueAction(getAuthors);
    },
    
    getAllGenres: function(component){
        var getGenres = component.get('c.getGenres');
        getGenres.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {;
                var genres =response.getReturnValue();
                component.set('v.genres',genres);
            }else if(state === "ERROR"){
                this.showToast(component,response.getError()[0].message,'error');
            }
        });
        $A.enqueueAction(getGenres);
    },
    getAilableActions: function(component){
        var getActions = component.get('c.getAvailableActions');
        getActions.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var actions =response.getReturnValue();
                component.set('v.actions',actions);
            }
        });
        $A.enqueueAction(getActions);
    },

    newBookAfterDelete: function(component, pageNumber) {
        var orderBy = component.get('v.sortField')
        var getNewBook = component.get("c.getbookAfterDelete");
        getNewBook.setParams({"pageNumber": pageNumber,
        "orderBy":orderBy
        });

        getNewBook.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var newBook =response.getReturnValue();
                var currentBooks = component.get('v.currentBooks');
                currentBooks.push(newBook[0]);
                component.set('v.currentBooks',currentBooks);
            }
        });
        $A.enqueueAction(getNewBook);
    },

    
    sortBy: function(component, field) {
            var books =[];
            component.set('v.pageNumber',1);
            this.getBooks(component,books,1);

    },
    roundUpBookLength: function(number){
        var zeroCount = Math.max(Math.floor(Math.log10(Math.abs(number))), 0);
        var zero ='';
        for(var i = 0; i<zeroCount;i++){
            zero+='0';
        }
        var c = ('1'+zero)*1;
        var roundnumber = Math.ceil(number/c)*c;
        return roundnumber;
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
    showSpinner : function (component, event, helper) {
        console.log(111)
        var spinner = component.find("spinner");
        $A.util.addClass(spinner, "slds-hide");  
    }
})