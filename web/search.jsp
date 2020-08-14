<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/search.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Dream Traveling</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-primary">
            <div class="navbar-brand">
                <i class="fa fa-paper-plane" aria-hidden="true"></i>
                Dream Traveling
            </div>
            <div class="navbar-link">
                <c:set var="user" value="${sessionScope.USER}"/>
                <c:if test="${empty user}">
                    <a href="loginPage">Login</a>
                </c:if>
                <c:if test="${not empty user}">
                    Welcome, ${user.fullName} |
                    <c:if test="${user.roleName eq 'Admin'}">
                        <a href="createNewTourPage">Create New Tour</a> |
                    </c:if>
                    <c:if test="${user.roleName eq 'User'}">
                        <a href="viewCartPage">View Cart</a> |
                    </c:if>
                    <a href="logout">Logout</a>
                </c:if>
            </div>
        </nav>
        <div class="search-form shadow-lg rounded">
            <form action="search" onsubmit="return isSearching()" id="searchTourForm">
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Place</label>
                    </div>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" name="txtSearchPlace" value="${param.txtSearchPlace}">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Date</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="date" class="form-control" name="txtSearchDateFrom" value="${param.txtSearchDateFrom}"/>
                    </div>
                    <div class="col-sm-2 col-form-label text-center" style="font-weight: normal;">
                        <label>to</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="date" class="form-control" name="txtSearchDateTo" value="${param.txtSearchDateTo}"/>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-2 col-form-label">
                        <label>Price</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="number" class="form-control" name="txtSearchPriceFrom" value="${param.txtSearchPriceFrom}" min="0" step="any">
                    </div>
                    <div class="col-sm-2 col-form-label text-center" style="font-weight: normal;">
                        <label>to</label>
                    </div>
                    <div class="col-sm-4">
                        <input type="number" class="form-control" name="txtSearchPriceTo" value="${param.txtSearchPriceTo}" min="0" step="any">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-sm-6">
                        <input type="submit" class="btn btn-primary btn-block" value="Search"/>
                    </div>
                    <div class="col-sm-6">
                        <a href="home" class="btn btn-primary btn-block">Show All</a>
                    </div>
                </div>
            </form>
        </div>
        <c:set var="tourList" value="${requestScope.SEARCH_TOUR_LIST}"/>
        <c:if test="${empty tourList}">
            <div class="alert alert-danger" role="alert">
                No tour can be found!
            </div>
        </c:if>
        <c:set var="addToListResult" value="${requestScope.ADD_TO_CART_RESULT}"/>
        <c:if test="${not empty addToListResult}">
            <c:if test="${addToListResult}">
                <div class="alert alert-primary" role="alert">
                    Add to cart succeed
                </div>
            </c:if>
            <c:if test="${!addToListResult}">
                <div class="alert alert-danger" role="alert">
                    Add to cart failed
                </div>
            </c:if>
        </c:if>
        <c:if test="${not empty tourList}">
            <table class="table table-hover table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Tour name</th>
                        <th>Place</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Price</th>
                        <th>Add to Cart</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="searchPageNo" value="${(not empty param.searchPageNo) ? param.searchPageNo : 1}"/>
                    <c:set var="rowsPerPage" value="${requestScope.ROWS_PER_PAGE}"/>
                    <c:forEach var="tour" items="${tourList}" varStatus="counter">
                    <form action="addToCart" method="POST" onsubmit="return confirm('Are you sure?')">
                        <tr class="table-light">
                            <td>
                                ${(searchPageNo - 1) * rowsPerPage + counter.count}
                            </td>
                            <td>
                                <img src="${tour.imageLink}" alt="No image available" width="200px" height="100px"/>
                            </td>
                            <td>${tour.tourName}</td>
                            <td>${tour.place}</td>
                            <td>
                                <fmt:formatDate value="${tour.fromDate}" type="date" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${tour.toDate}" type="date" pattern="dd/MM/yyyy"/>
                            </td>
                            <td>
                                <fmt:formatNumber value="${tour.price}" type="number" maxFractionDigits="10"/> đ
                            </td>
                            <td>
                                <input type="submit" class="btn btn-primary" value="Add to Cart"
                                        <c:if test="${empty user or (not empty user and user.roleName ne 'User')}">disabled</c:if>/>                                       
                                <input type="hidden" name="txtSearchPlace" value="${param.txtSearchPlace}"/>
                                <input type="hidden" name="txtSearchDateFrom" value="${param.txtSearchDateFrom}"/>
                                <input type="hidden" name="txtSearchDateTo" value="${param.txtSearchDateTo}"/>
                                <input type="hidden" name="txtSearchPriceFrom" value="${param.txtSearchPriceFrom}"/>
                                <input type="hidden" name="txtSearchPriceTo" value="${param.txtSearchPriceTo}"/>
                                <input type="hidden" name="searchPageNo" value="${searchPageNo}"/>
                                <input type="hidden" name="tourIdToAdd" value="${tour.tourId}"/>
                            </td>
                        </tr>
                    </form>
                    </c:forEach>
                </tbody>
            </table>
            <c:set var="totalPages" value="${requestScope.TOTAL_PAGES}"/>
            <nav>
                <ul class="pagination justify-content-center">
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item <c:if test="${i == searchPageNo}">active</c:if>">
                            <c:url var="urlRewritingPaging" value="search">
                                <c:param name="txtSearchPlace" value="${param.txtSearchPlace}"/>
                                <c:param name="txtSearchDateFrom" value="${param.txtSearchDateFrom}"/>
                                <c:param name="txtSearchDateTo" value="${param.txtSearchDateTo}"/>
                                <c:param name="txtSearchPriceFrom" value="${param.txtSearchPriceFrom}"/>
                                <c:param name="txtSearchPriceTo" value="${param.txtSearchPriceTo}"/>
                                <c:param name="searchPageNo" value="${i}"/>
                            </c:url>
                            <a href="${urlRewritingPaging}" class="page-link">${i}</a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </c:if>
        <script>
            function isSearching() {
                var userInputFields = document.querySelectorAll("#searchTourForm .form-control");
                for (var i = 0; i < userInputFields.length; i++) {
                    if (userInputFields[i].value.trim() !== "") {
                        return true;
                    }
                }
                return false;
            }
        </script>
    </body>
</html>