// Initializes the database
function dbInit() {
    var db = LocalStorage.openDatabaseSync("ContactListDB", "1.0", "Holds local contacts", 1000000);

    try {
        db.transaction( function(tx){
            tx.executeSql('CREATE TABLE IF NOT EXISTS contact_list(id TEXT, firstname TEXT, lastname TEXT, mobile TEXT, email TEXT)')
        });
    } catch(err) {
        console.log("Error creating table in this database: "+ err);
    }
}

// Returns database handle to other functions
function dbHandle() {
    try {
        var db = LocalStorage.openDatabaseSync("ContactListDB", "1.0", "Holds local contacts", 1000000);
    } catch(err) {
        console.log("Error on opening database: "+err);
    }
    return db;
}

// Gets all contacts from local database
function dbGetAll() {
    var db = dbHandle();
    db.transaction( function(tx) {
        var results = tx.executeSql('SELECT rowid, * FROM contact_list ORDER BY firstname COLLATE NOCASE');

        listModelLocal.clear();
        for (var i = 0; i < results.rows.length; i++) {
            listModelLocal.append({  "id": results.rows.item(i).rowid,
                                     "remote_id": results.rows.item(i).id,
                                     "firstname": results.rows.item(i).firstname,
                                     "lastname": results.rows.item(i).lastname,
                                     "mobile": results.rows.item(i).mobile,
                                     "email": results.rows.item(i).email
                                 });

            // Checks if id is null
            // console.log(results.rows.item(i).remote_id !== null);
        }
    });
}

// Adds entry to local database
function dbInsert() {
    var db = dbHandle();
    var rowid = 0;
    console.log("Locally inserting...");
    db.transaction( function(tx){
        tx.executeSql('INSERT INTO contact_list(firstname, lastname, mobile, email) VALUES(?, ?, ?, ?)',
                      [form.firstName.text, form.lastName.text, form.mobile.text, form.email.text]);
        var result = tx.executeSql('SELECT last_insert_rowid()')
        rowid = result.insertId;
    });
    console.log("Locally inserted with insert_id :"+ rowid);

    dbGetAll();
}

// Updates entry in local database
function dbUpdate(id) {
    console.log("Locally updating rowid="+id);
    var db = dbHandle();
    db.transaction( function(tx){
        tx.executeSql('UPDATE contact_list SET firstname=?, lastname=?, mobile=?, email=? WHERE rowid=?',
                      [editform.firstName.text, editform.lastName.text, editform.mobile.text, editform.email.text, id]);
    });
    console.log("local update finished!");

    dbGetAll();
}

// Search in database
function dbSearch(search_text) {
    search_text += "%";
    var db = dbHandle();
    db.transaction( function(tx){
        var results = tx.executeSql('SELECT rowid, * FROM contact_list WHERE firstname LIKE ? OR lastname LIKE ? ORDER BY firstname COLLATE NOCASE',
                                    [search_text, search_text]);

        listModelLocal.clear();
        for (var i = 0; i < results.rows.length; i++) {
            listModelLocal.append({  "id": results.rows.item(i).rowid,
                                     "remote_id": results.rows.item(i).id,
                                     "firstname": results.rows.item(i).firstname,
                                     "lastname": results.rows.item(i).lastname,
                                     "mobile": results.rows.item(i).mobile,
                                     "email": results.rows.item(i).email
                                 });

            // Checks if id is null
            console.log(results.rows.item(i).remote_id !== null);
        }

    });

}

// Drops table: FOR TESTING PORPUSES ONLY
function dbDropTable(){
    var db = dbHandle();
    db.transaction( function(tx){
        tx.executeSql('DROP TABLE contact_list');
        console.log("table dropped");
    });
}

