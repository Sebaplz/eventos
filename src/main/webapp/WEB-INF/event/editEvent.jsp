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
    <title>Events</title>
    <!-- for Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/style.css" />
    <!-- For any Bootstrap that uses JS -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
  </head>
  <body>
    <div class="container mt-5">
      <div class="d-flex justify-content-between align-items-center">
        <h1>${event.name}</h1>
        <a href="/events" class="fs-3">Dashboard</a>
      </div>
      <div class="col-6">
        <form:form action="/${event.id}" method="post" modelAttribute="event" class="mt-3">
          <input type="hidden" name="_method" value="put">
          <form:hidden value="${ user.id }" path="user_event" />
          <div class="d-flex justify-content-between mt-3">
            <form:label path="name" class="fs-5 col-4">Name:</form:label>
            <form:input path="name" class="col-8" />
          </div>
          <form:errors path="name" class="text-danger" />
          <div class="d-flex justify-content-between mt-3">
            <form:label path="date" class="fs-5 col-4">Date:</form:label>
            <form:input path="date" type="date" value="${now}" class="col-8" />
          </div>
          <form:errors path="date" class="text-danger" />
          <div class="d-flex align-items-center mt-3">
            <form:label path="location" class="fs-5 col-4"
              >Location:</form:label
            >
            <form:input path="location" class="w-50" />
            <form:label path="state" class="fs-5 mx-1">State:</form:label>
            <form:select class="form-control" path="state">
            <option value="${ event.state }">${ event.state }</option>
            <c:forEach items="${ states }" var="state">
              <option value="${ state }">${ state }</option>
            </c:forEach>
          </form:select>
          </div>
          <form:errors path="location" class="text-danger" />
          <div class="d-flex justify-content-end mt-3">
            <button class="btn btn-success">Edit</button>
          </div>
        </form:form>
      </div>
    </div>
  </body>
</html>
