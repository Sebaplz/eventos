<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Welcome</title>
    <!-- for Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />
    <!-- For any Bootstrap that uses JS -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container mt-5">
      <h1>Welcome</h1>
      <div class="d-flex justify-content-between">
        <div>
          <form:form
            action="/registration"
            method="post"
            modelAttribute="register"
            class="mt-5"
          >
            <fieldset class="border border-3 p-3">
              <legend class="float-none w-auto">Register</legend>
              <div class="d-flex justify-content-between mt-3">
                <form:label path="firstName" class="fs-5 col-4"
                  >First Name:</form:label
                >
                <form:input path="firstName" class="col-8" />
              </div>
              <form:errors path="firstName" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="lastName" class="fs-5">Last Name:</form:label>
                <form:input path="lastName" class="col-8" />
              </div>
              <form:errors path="lastName" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="email" class="fs-5 col-4">Email:</form:label>
                <form:input path="email" type="email" class="col-8" />
              </div>
              <form:errors path="email" class="text-danger" />
              <div class="d-flex justify-content-between mt-3"></div>
              <div class="d-flex align-items-center">
                <form:label path="location" class="fs-5 col-4"
                  >Location:</form:label
                >
                <form:input path="location" class="w-50" />
                <form:label path="state" class="fs-5 mx-1">State:</form:label>
                <form:select
                  class="form-select w-auto"
                  type="text"
                  path="state"
                >
                  <c:forEach items="${states}" var="state">
                    <form:option value="${state}"></form:option>
                  </c:forEach>
                </form:select>
              </div>
              <form:errors path="location" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="password" class="fs-5 col-4"
                  >Password:</form:label
                >
                <form:password path="password" class="col-8" />
              </div>
              <form:errors path="password" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="passwordConfirmation" class="fs-5 col-4"
                  >PW Conf:</form:label
                >
                <form:password path="passwordConfirmation" class="col-8" />
              </div>
              <form:errors path="passwordConfirmation" class="text-danger" />
              <div class="d-flex justify-content-end mt-3">
                <input type="submit" value="Register" class="btn btn-success" />
              </div>
            </fieldset>
          </form:form>
        </div>
        <div class="ms-3">
          <form:form
            action="/login"
            method="post"
            modelAttribute="login"
            class="mt-5"
          >
            <fieldset class="border border-3 p-3">
              <legend class="float-none w-auto">Login</legend>
              <div class="d-flex justify-content-between mt-3">
                <form:label path="email" class="fs-5">Email:</form:label>
                <form:input path="email" type="email" class="ms-3" />
              </div>
              <form:errors path="email" class="text-danger" />
              <div class="d-flex justify-content-between mt-3">
                <form:label path="password" class="fs-5">Password:</form:label>
                <form:password path="password" class="ms-3" />
              </div>
              <form:errors path="password" class="text-danger" />
              <p class="text-danger">${error}</p>
              <div class="d-flex justify-content-end mt-3">
                <input type="submit" value="Login" class="btn btn-success" />
              </div>
            </fieldset>
          </form:form>
        </div>
      </div>
    </div>
  </body>
</html>
