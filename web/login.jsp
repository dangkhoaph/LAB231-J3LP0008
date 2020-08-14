<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="khoaphd.utils.APIWrapper"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Login Page</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-primary">
            <div class="navbar-brand">
                <i class="fa fa-paper-plane" aria-hidden="true"></i>
                Dream Traveling
            </div>
            <div class="navbar-link">
                <a href="home">< Back to Home</a>
            </div>
        </nav>
        <div class="login-form shadow-lg rounded">
            <form action="login" method="POST">
                <div class="avatar">
                    <i class="fa fa-user fa-4x" aria-hidden="true"></i>
                </div>
                <div class="form-group">
                    <input type="text" class="form-control input-lg" name="txtUsername" placeholder="Username">
                </div>
                <div class="form-group">
                    <input type="password" class="form-control input-lg" name="txtPassword" placeholder="Password">
                </div>
                <div class="form-group d-flex justify-content-center">
                    <input type="submit" class="btn btn-primary btn-lg" value="Login"></button>
                </div>
                <div class="form-group">
                    <p class="text-center">Or</p>
                </div>
                <div class="form-group">
                    <c:set var="apiLink" value="${APIWrapper.getDialogLink()}"/>
                    <a href="${apiLink}" class="btn btn-primary btn-lg btn-block"><i class="fa fa-facebook-square" aria-hidden="true"></i> Login with Facebook</a>
                </div>
                <c:set var="userNotFoundError" value="${requestScope.USER_NOT_FOUND}"/>
                <c:if test="${not empty userNotFoundError}">
                    <div class="alert alert-danger" role="alert">
                        ${userNotFoundError}
                    </div>
                </c:if>
                <c:set var="facebookLoginError" value="${requestScope.FACEBOOK_LOGIN_ERROR}"/>
                <c:if test="${not empty facebookLoginError}">
                    <div class="alert alert-danger" role="alert">
                        ${facebookLoginError}
                    </div>
                </c:if>
            </form>
        </div>
    </body>
</html>