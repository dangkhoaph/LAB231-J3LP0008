<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="css/viewCart.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>View Cart</title>
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
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:if test="${not empty cart}">
            <c:set var="tourList" value="${cart.tourList}"/>
            <c:if test="${not empty tourList}">
                <div class="table-show-cart">
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
                                <th>Amount</th>
                                <th>Total</th>
                                <th>Update</th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="tour" items="${tourList}" varStatus="counter">
                            <form action="updateAmountOfTour" method="POST" onsubmit="return confirm('Are you sure to update?')">
                                <tr class="table-light">
                                    <td>
                                        ${counter.count}
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
                                        <input type="number" class="form-control" name="txtAmount" value="${tour.amount}" min="1" required>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${tour.price * tour.amount}" type="number" maxFractionDigits="10"/> đ
                                    </td>
                                    <td>
                                        <input type="submit" class="btn btn-warning" value="Update"/>
                                        <input type="hidden" name="tourIdToUpdate" value="${tour.tourId}"/>
                                    </td>
                                    <td>
                                        <c:url var="urlRewritingRemove" value="removeTourFromCart">
                                            <c:param name="tourIdToRemove" value="${tour.tourId}"/>
                                        </c:url>
                                        <a href="${urlRewritingRemove}" class="btn btn-danger" onclick="return confirm('Are you sure?')">Remove</a>
                                    </td>
                                </tr>
                            </form>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="show-total-form">
                    <c:set var="nonFinalPrice" value="${0}"/>
                    <c:forEach var="tour" items="${tourList}" >
                        <c:set var="nonFinalPrice" value="${nonFinalPrice + tour.price * tour.amount}"/>
                    </c:forEach>
                    <div class="row">
                        <div class="col-sm-12">
                            <h5>
                                Price (no discount): 
                                <span class="text-danger">
                                    <fmt:formatNumber value="${nonFinalPrice}" type="number" maxFractionDigits="10"/> đ
                                </span>
                            </h5>
                        </div>
                    </div>
                    <form action="checkDiscountCode" method="POST">
                        <div class="form-group row">
                            <div class="col-sm-2 col-form-label">
                                <h5>Discount code:</h5>
                            </div>
                            <div class="col-sm-4">
                                <input type="text" class="form-control" name="txtCheckDiscountCode" value="${param.txtCheckDiscountCode}" id="txtCheckDiscountCode"/>
                            </div>
                            <div class="col-sm-1">
                                <input type="submit" class="btn btn-primary btn-block" value="Check" onclick="return validateInput()"/>
                            </div>
                            <div class="col-sm-1">
                                <a href="resetDiscountCode" class="btn btn-danger btn-block">Reset</a>
                            </div>
                            <div class="col-sm-4 text-danger" style="margin-top: 5px;">
                                <c:set var="checkDiscountCodeError" value="${requestScope.NO_DISCOUNT_CODE_FOUND}"/>
                                <c:if test="${not empty checkDiscountCodeError}">
                                    ${checkDiscountCodeError}
                                </c:if>
                            </div>
                        </div>
                        <c:set var="discount" value="${sessionScope.DISCOUNT}"/>
                        <c:if test="${not empty discount}">
                            <div class="row" role="alert">
                                <div class="col-sm-12 alert alert-primary">
                                    <h5>Currently used discount</h5>
                                    <p><b>Discount Code:</b> ${discount.discountId}</p>
                                    <p><b>Discount Name:</b> ${discount.discountName}</p>
                                    <p><b>Value:</b> ${discount.percentage}%</p>
                                    <p><b>Expiry Date:</b> ${discount.expiryDate}</p>
                                </div>
                            </div>
                        </c:if>
                    </form>
                    <div class="row">
                        <div class="col-sm-12">
                            <h3>
                                Final Price: 
                                <span class="text-danger">
                                    <c:if test="${not empty discount}">
                                        <fmt:formatNumber value="${nonFinalPrice * (100 - discount.percentage) / 100}" type="number" maxFractionDigits="10"/> đ
                                    </c:if>
                                    <c:if test="${empty discount}">
                                        <fmt:formatNumber value="${nonFinalPrice}" type="number" maxFractionDigits="10"/> đ
                                    </c:if>
                                </span>
                            </h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <form action="submitBooking" method="POST" onsubmit="return confirm('Are you sure?')">
                                <input type="submit" class="btn btn-primary btn-block" value="Submit Booking"/>
                            </form>
                        </div>
                    </div>
                    <c:set var="invalidDiscountError" value="${requestScope.INVALID_DISCOUNT}"/>
                    <c:if test="${not empty invalidDiscountError}">
                        <div class="alert alert-danger">
                            ${invalidDiscountError}
                        </div>
                    </c:if>
                    <c:set var="invalidTourList" value="${requestScope.INVALID_TOUR_LIST}"/>
                    <c:if test="${not empty invalidTourList}">
                        <div class="alert alert-danger">
                            <c:forEach var="invalidTour" items="${invalidTourList}" varStatus="counter">
                                <p>${counter.count}. <b>${invalidTour[0]}</b>: ${invalidTour[1]} slots left</p>
                            </c:forEach>
                        </div>
                    </c:if>
                </div>
            </c:if>
            <c:if test="${empty tourList}">
                <div class="alert alert-danger" role="alert">
                    Cart is empty
                </div>
            </c:if>
        </c:if>
        <c:if test="${empty cart}">
            <div class="alert alert-danger" role="alert">
                Cart is empty
            </div>
        </c:if>
        <script>
            function validateInput() {
                var txtCheckDiscountCode = document.getElementById("txtCheckDiscountCode").value.trim();
                if (txtCheckDiscountCode !== "") {
                    return true;
                }
                return false;
            }
        </script>
    </body>
</html>