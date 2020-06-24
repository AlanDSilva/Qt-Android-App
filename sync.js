.import "database.js" as DB
.import "request.js" as Request

// Syncs all local contacts to remote database
function syncToRemote() {
    var db = DB.dbHandle();
    db.transaction( function(tx) {
        var results = tx.executeSql('SELECT rowid, * FROM contact_list');

        for (var i = 0; i < results.rows.length; i++) {
            // Checks if id is null
            if(results.rows.item(i).id === null) {
                var values = {
                    "firstname": results.rows.item(i).firstname,
                    "lastname" : results.rows.item(i).lastname,
                    "mobile": results.rows.item(i).mobile,
                    "email": results.rows.item(i).email
                }
                var content = JSON.stringify(values);
                postRequest(content);

                // Deletes this local contact
                console.log("Deleting locally...");
                tx.executeSql('DELETE FROM contact_list WHERE rowid=?', [results.rows.item(i).rowid]);

            }
        }

    });
}


// Performs a post request to remote database
function postRequest(content) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('POST HEADERS_RECEIVED');

        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('POST DONE');
            var object = JSON.parse(xhr.response);


            getNewContact();

            // Gets contacts after adding new one
            Request.getContacts2();

        }
    }

    xhr.open("POST", "https://qtphone.herokuapp.com/contact", true);
    xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
    xhr.send(content);
}


// Returns contact with highest id from remote-database
function getNewContact(){
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('Get New Contact Done');
            var object = JSON.parse(xhr.responseText);

            // Sorts in id order (descending)
            object.sort((a, b) => {
                            if(a.id < b.id){
                                return 1
                            }
                            if(a.id > b.id){
                                return -1
                            }
                            return 0;
                        });
            insertToLocal(object[0]);
        }
    }
    xhr.open("GET", "https://qtphone.herokuapp.com/contact");
    xhr.send();
}

function insertToLocal(content){
    var db = DB.dbHandle();
    db.transaction( function(tx) {

        tx.executeSql('INSERT INTO contact_list(id, firstname, lastname, mobile, email) VALUES(?, ?, ?, ?, ?)',
                      [content.id ,content.firstname, content.lastname, content.mobile, content.email]);
    });
    DB.dbGetAll()
}


function syncToLocal() {
    var db = DB.dbHandle();
    db.transaction( function(tx) {
        for(var i = 0; i < listModelJson.count; i++) {
            var result = tx.executeSql('SELECT * FROM contact_list WHERE id=?', [listModelJson.get(i).id])
            if(result.rows.item(0) === undefined){
                tx.executeSql('INSERT INTO contact_list(id, firstname, lastname, mobile, email) VALUES(?, ?, ?, ?, ?)',
                              [listModelJson.get(i).id ,listModelJson.get(i).firstname, listModelJson.get(i).lastname, listModelJson.get(i).mobile, listModelJson.get(i).email]);
            }
        }
    });
    DB.dbGetAll();
}




