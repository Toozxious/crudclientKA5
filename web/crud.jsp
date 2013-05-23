<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
        <title>WannaBeKrak client</title>
        <style>
            body{
            background-image:url(https://s3.amazonaws.com/assets.kickofflabs.com/backgrounds/site/background_image/1523/light_grey_3000x3000.jpg);
            }
            p{
            font-weight: bold;    
            }
        </style>
    </head>
    <body>
        <button id="GetDivButt">FindById</button>
        <button id="DelDivButt">DeleteById</button>
        <button id="EditDivButt">EditById</button>
        <button id="CreateDivButt">CreateNew</button>
        <div id="getdiv">
            <p>Get id</p>
            <input id="getID">
            <button id="getButt">Get</button>            
        </div>
        <div id="textArea">
        <textarea id="messages" rows="16" cols="68" readonly="readonly "style="resize: none"></textarea>
        </div>
        <div id="deldiv">
            <p>Delete</p>
            <input id="getDelId">
            <button id="DelButt">Delete</button>
            <p id="delStatus">Status</p>
        </div>
        <div id="editdiv">
            <p>Edit:</p>
            <input id="getEditId">
            <button id="getIdButt">Get ID to edit</button>
            <p>First Name:</p>
            <input id="editFirstName">
            <p>Last Name:</p>
            <input id="editLastName">
            <p>City:</p>
            <input id="editCity">
            <p>ZipCode: </p>
            <input id="editZipcode">
            <p>Street:</p>
            <input id="editStreet">
            <p>Phone: </p>
            <input id="editPhone">
            <button id="editButt">Merge</button>
        </div>
        <div id="creatediv">
            <p>Create</p>
            <p>id:</p>
            <input id="createId">
            <p>First Name:</p>
            <input id="createFirstName">
            <p>Last Name:</p>
            <input id="createLastName">
            <p>City:</p>
            <input id="createCity">
            <p>ZipCode: </p>
            <input id="createZipcode">
            <p>Street:</p>
            <input id="createStreet">
            <p>Phone: </p>
            <input id="createPhone">
            <button id="createButt">Persist</button>
        </div>
    </body>
    <script>
        $(document).ready(function(e) {
            $("#deldiv").hide();
            $("#editdiv").hide();
            $("#creatediv").hide();
            $("#getdiv").show();
            $("#DelDivButt").click(function() {
                $("#getdiv").hide();
                $("#textArea").hide();
                $("#editdiv").hide();
                $("#creatediv").hide();
                $("#deldiv").show(500);
            });
            $("#GetDivButt").click(function() {
                $("#deldiv").hide();
                $("#textArea").show();
                $("#editdiv").hide();
                $("#creatediv").hide();
                $("#getdiv").show(500);
            });
            $("#EditDivButt").click(function() {
                $("#getdiv").hide();
                $("#textArea").hide();
                $("#deldiv").hide();
                $("#creatediv").hide();
                $("#editdiv").show(500);
            });
            $("#CreateDivButt").click(function() {
                $("#getdiv").hide();
                $("#textArea").hide();
                $("#deldiv").hide();
                $("#editdiv").hide();
                $("#creatediv").show(500);
            });
            //Get page 
            var info = "";
            $("#getButt").click(function() {
                $.ajax({
                    url: "http://localhost:8080/wannabekrak/webresources/rest.persondata/" + $("#getID").val() + "?",
                    cache: false,
                    dataType: "json",
                    success: dataReady
                });
                return false;
            });
            function dataReady(data) {
                info += data.id + " " + data.firstName + " " + data.lastName + " " + data.city + " " + data.zipcode + " " + data.street + " " + data.phone + "\n";
                $("#messages").val(info);
                console.log(data);
            }
            //Delete
            $("#DelButt").click(function() {
                var id = $("#getID").val();
                $.ajax({
                    url: "http://localhost:8080/wannabekrak/webresources/rest.persondata/" + id + "?",
                    type: "delete",
                    success: function setDelStatus() {
                        $("#delStatus").text("slettet");
                    }
                });
                return false;
            });
            //Create
            $("#createButt").click(function() {
                var json = {
                    "city":""+$("#createCity").val(),
                    "firstName":""+$("#createFirstName").val(),
                    "id":""+$("#createId").val(),
                    "lastName":""+$("#createLastName").val(),
                    "phone":""+$("#createPhone").val(),
                    "street":""+$("#createStreet").val(),
                    "zipcode":""+$("#createZipcode").val()
                };
                console.log(json);
                console.log(JSON.stringify(json));
                $.ajax({
                    type: "post",
                    url: "http://localhost:8080/wannabekrak/webresources/rest.persondata/?",
                    data: JSON.stringify(json),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function created(data) {
                        console.log(data);
                    },
                    failure: function(errMsg){
                        alert("failed");
                        console.log(errMsg);
                    }
                });
                return false;
            });
            $("#editButt").click(function() {
                var json = {
                    "city":""+$("#editCity").val(),
                    "firstName":""+$("#editFirstName").val(),
                    "id":""+$("#getEditId").val(),
                    "lastName":""+$("#editLastName").val(),
                    "phone":""+$("#editPhone").val(),
                    "street":""+$("#editStreet").val(),
                    "zipcode":""+$("#editZipcode").val()
                };
                console.log(json);
                console.log(JSON.stringify(json));
                $.ajax({
                    type: "put",
                    url: "http://localhost:8080/wannabekrak/webresources/rest.persondata/?",
                    data: JSON.stringify(json),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function edited(data) {
                        console.log(data);
                    },
                    failure: function(errMsg){
                        alert("failed");
                        console.log(errMsg);
                    }
                });
                return false;
            });
            $("#getIdButt").click(function() {
            var firstName ="";
            var lastName ="";
            var city ="";
            var street ="";
            var zipcode ="";
            var phone ="";
                $.ajax({
                    url: "http://localhost:8080/wannabekrak/webresources/rest.persondata/" + $("#getEditId").val() + "?",
                    cache: false,
                    dataType: "json",
                    success: function gotten(data){
                        firstName = data.firstName;
                        $("#editFirstName").val(firstName);
                        lastName = data.lastName;
                        $("#editLastName").val(lastName);
                        city = data.city;
                        $("#editCity").val(city);
                        street = data.street;
                        $("#editStreet").val(street);
                        zipcode = data.zipcode;
                        $("#editZipcode").val(zipcode);
                        phone = data.phone;
                        $("#editPhone").val(phone);
                    }
                });
                return false;
            });
        });
    </script>
</html>
