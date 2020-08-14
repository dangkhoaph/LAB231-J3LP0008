<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/createNewTour.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <title>Create New Tour</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-primary">
            <div class="navbar-brand">
                <i class="fa fa-paper-plane" aria-hidden="true"></i>
                Dream Traveling
            </div>
            <div class="navbar-link">
                <a href="home">< Back to Home</a> |
                <a href="logout">Logout</a>
            </div>
        </nav>
        <div class="create-tour-form">
            <form action="createNewTour"  enctype="multipart/form-data" method="POST" onsubmit="return confirm('Are you sure?')">
                <h2 class="text-center text-danger">Create New Tour</h2>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Tour Name:</label>
                    </div>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="txtCreateTourName" id="txtCreateTourName">
                    </div>
                    <div class="col-sm-5 text-danger" id="txtCreateTourNameError" style="margin-top: 5px;"></div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Place:</label>
                    </div>
                    <div class="col-sm-5">
                        <input type="text" class="form-control" name="txtCreatePlace" id="txtCreatePlace">
                    </div>
                    <div class="col-sm-5 text-danger" id="txtCreatePlaceError" style="margin-top: 5px;"></div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Date:</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="date" class="form-control" name="txtCreateDateFrom" id="txtCreateDateFrom" required/>
                    </div>
                    <div class="col-sm-2 col-form-label text-center" style="font-weight: normal;">
                        <label>to</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="date" class="form-control" name="txtCreateDateTo" id="txtCreateDateTo" required/>
                    </div>
                    <div class="col-sm-2"></div>
                    <div class="col-sm-10 text-danger" id="dateRangeError"></div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Price:</label>
                    </div>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" name="txtCreatePrice" id="txtCreatePrice" min="0" step="any" required>
                    </div>
                    <div class="col-sm-5 text-danger" id="txtCreatePriceError" style="margin-top: 5px;"></div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Quota:</label>
                    </div>
                    <div class="col-sm-5">
                        <input type="number" class="form-control" name="txtCreateQuota" min="1" required>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Image:</label>
                    </div>
                    <div class="col-sm-5">
                        <input type="file" name="txtCreateImage" style="margin-top: 5px;" id="txtCreateImage" accept="image/jpg, image/png" required>
                    </div>
                    <div class="col-sm-5 text-danger" id="txtCreateImageError" style="margin-top: 5px;"></div>
                </div>
                <img id="imagePreview" src="#" alt="Image Preview" width="300px" height="200px" style="margin-bottom: 30px;"/>
                <input type="submit" class="btn btn-primary btn-block" value="Submit" onclick="return validateInput()"/>
                <c:set var="message" value="${param.message}"/>
                <c:if test="${not empty message}">
                    <c:if test="${fn:contains(message, 'successful')}">
                        <div class="alert alert-primary" style="margin-top: 30px;">
                            ${message}
                        </div>
                    </c:if>
                    <c:if test="${fn:contains(message, 'failed')}">
                        <div class="alert alert-danger" style="margin-top: 30px;">
                            ${message}
                        </div>
                    </c:if>
                </c:if>
            </form>
        </div>
        <script>
            function validateInput() {
                var success = true;
                
                var txtCreateTourName = document.getElementById("txtCreateTourName").value.trim();
                if (txtCreateTourName === "") {
                    document.getElementById("txtCreateTourNameError").innerHTML = "Tour name is required";
                    success = false;
                } else {
                    document.getElementById("txtCreateTourNameError").innerHTML = "";
                }
                
                var txtCreatePlace = document.getElementById("txtCreatePlace").value.trim();
                if (txtCreatePlace === "") {
                    document.getElementById("txtCreatePlaceError").innerHTML = "Place is required";
                    success = false;
                } else {
                    document.getElementById("txtCreatePlaceError").innerHTML = "";
                }
                
                var txtCreateDateFrom = document.getElementById("txtCreateDateFrom").value.trim();
                var txtCreateDateTo = document.getElementById("txtCreateDateTo").value.trim();
                if (txtCreateDateFrom !== "" && txtCreateDateTo !== "") {
                    if (txtCreateDateFrom >= txtCreateDateTo) {
                        document.getElementById("dateRangeError").innerHTML = "Date range is invalid";
                        success = false;
                    } else {
                        document.getElementById("dateRangeError").innerHTML = "";
                    }
                }
                
                var txtCreatePrice = document.getElementById("txtCreatePrice").value.trim();
                if (txtCreatePrice !== "") {
                    if (txtCreatePrice <= 0) {
                        document.getElementById("txtCreatePriceError").innerHTML = "Price must be positive";
                        success = false;
                    } else {
                        document.getElementById("txtCreatePriceError").innerHTML = "";
                    }
                }
                
                var txtCreateImage = document.getElementById("txtCreateImage").value.trim();
                if (txtCreateImage !== "") {
                    var extension = txtCreateImage.substring(txtCreateImage.lastIndexOf("."));
                    if (extension !== ".jpg" && extension !== ".png") {
                        document.getElementById("txtCreateImageError").innerHTML = "Only JPG and PNG extension are allowed";
                        success = false;
                    } else {
                        document.getElementById("txtCreateImageError").innerHTML = "";
                    }
                }
                
                return success;
            }
            
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    
                    reader.onload = function(e) {
                        $("#imagePreview").attr("src", e.target.result);
                    };
                    
                    reader.readAsDataURL(input.files[0]);
                }
            }
            
            $("#txtCreateImage").change(function() {
                readURL(this);
            });
        </script>
    </body>
</html>