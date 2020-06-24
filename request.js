// Returns all contacts from remote database
function getContacts2() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('Get Contacts HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('Get Contacts Done');
            var object = JSON.parse(xhr.responseText);

            // Sorts in alphabetical order
            object.sort((a, b) => {
                            if(a.firstname[0].toUpperCase() < b.firstname[0].toUpperCase()){
                                return -1
                            }
                            if(a.firstname[0].toUpperCase() > b.firstname[0].toUpperCase()){
                                return 1
                            }
                            return 0;
                        });
            listModelJson.clear();

            for(var i in object){
                listModelJson.append({
                                     "id" : object[i].id,
                                     "firstname" : object[i].firstname,
                                     "lastname" : object[i].lastname,
                                     "mobile" : object[i].mobile,
                                     "email" : object[i].email});
            }
        }
    }
    xhr.open("GET", "https://qtphone.herokuapp.com/contact");
    xhr.send();
}

// Searches for remote contact dynamically
function searchContact(search_text) {

    if(!search_text){
        return
    }

    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('Get Contacts HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('Get Contacts Done');
            var object = JSON.parse(xhr.responseText);

            object.sort((a, b) => {
                            if(a.firstname[0].toUpperCase() < b.firstname[0].toUpperCase()){
                                return -1
                            }
                            if(a.firstname[0].toUpperCase() > b.firstname[0].toUpperCase()){
                                return 1
                            }
                            return 0;
                        });

            var regex = RegExp(search_text+'*');
            var result = object.filter(el => regex.test(el['firstname']) || regex.test(el['lastname']))


            listModelJson.clear();
            for(var i in result){
                listModelJson.append({
                                     "id" : result[i].id,
                                     "firstname" : result[i].firstname,
                                     "lastname" : result[i].lastname,
                                     "mobile" : result[i].mobile,
                                     "email" : result[i].email});
            }// Sets listView's data
        }
    }
    xhr.open("GET", "https://qtphone.herokuapp.com/contact");
    xhr.send();

}

// Inserts contact to remote database
function addContact() {
    var values = {
        "firstname": form.firstName.text,
        "lastname" : form.lastName.text,
        "mobile": form.mobile.text,
        "email": form.email.text
    }
    var content = JSON.stringify(values)

    // Post request Creates new Entry
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('POST HEADERS_RECEIVED');

        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('POST DONE');
            var object = JSON.parse(xhr.response);


            // Gets contacts after adding new one
            getContacts2();

        }
    }

    xhr.open("POST", "https://qtphone.herokuapp.com/contact", true);
    xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
    xhr.send(content);
}

// Edits remote contact
function editContact(id) {
    var values = {
        "firstname": editform.firstName.text,
        "lastname" : editform.lastName.text,
        "mobile": editform.mobile.text,
        "email": editform.email.text
    }
    var content = JSON.stringify(values)

    // Put request Creates new Entry
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('PUT HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('PUT DONE');

            // Gets contacts after editing
            getContacts2();
        }
    }

    xhr.open("PUT", "https://qtphone.herokuapp.com/contact/"+id, true);
    xhr.setRequestHeader('Content-type','application/json; charset=utf-8');
    xhr.send(content);

}

// Deletes remote contact
function deleteContact(id){
    // Delete request Creates new Entry
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('DELETE HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('DELETE DONE');
        }
    }

    xhr.open("DELETE", "https://qtphone.herokuapp.com/contact/"+id, true);
    xhr.send();
}
