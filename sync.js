.import "database.js" as DB
.import "request.js" as Request

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
                DB.dbGetAll();
            }
        }
    });
}

function postRequest(content) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('POST HEADERS_RECEIVED');

        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('POST DONE');
            var object = JSON.parse(xhr.response);
            console.log(xhr.response.id)

            // Gets contacts after adding new one
            Request.getContacts2();

        }
    }

    xhr.open("POST", "https://qtphone.herokuapp.com/contact", true);
    xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
    xhr.send(content);
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




