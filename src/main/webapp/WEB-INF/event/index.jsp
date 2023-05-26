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
    <fmt:setLocale value="es_ES"/>
    <fmt:setTimeZone value="GMT"/>
  </head>
  <body>
    <div class="container mt-5">
      <div class="d-flex justify-content-between align-items-center">
        <h1>Welcome, ${user.firstName}</h1>
        <a href="/logout" class="fs-3">Logout</a>
      </div>
      <h2>Here are some of the events in your state:</h2>
      <div>
        <table class="table table-striped border border-1">
          <thead>
            <tr class="table-secondary">
              <th scope="col">Name</th>
              <th scope="col">Date</th>
              <th scope="col">Location</th>
              <th scope="col">Host</th>
              <th scope="col">Action / Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${allEventsWithState}" var="e">
              <tr>
                <td><a href="/events/${e.id}">${e.name}</a></td>
                <td><fmt:formatDate value="${e.date}" pattern="MMMM dd, yyyy"/>${date}</td>
                <td>${e.location}</td>
                <td>${e.user_event.firstName}</td>
                <td>
                  <c:choose>
                    <c:when test="${ e.user_event.id == user.id }">
                      <div class="d-flex align-items-center">
                        <a href="/events/${e.id}/edit">Edit</a>
                        <form:form class="delete-form" action="/events/${e.id}"
                        method="delete">
                          <input type="submit" value="Delete" class="btn btn-outline-danger ms-2">
                        </form:form>
                      </div>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${ e.asistentes.contains(user) }">
                                <span>Joining<a href="/event/${e.id}/cancel" class="ms-2">Cancel</a></span>
                            </c:when>
                            <c:otherwise>
                                <a href="/event/${e.id}/join">Join</a>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <h2>Here are some of the events in other states:</h2>
      <div>
        <table class="table table-striped border border-1">
          <thead>
            <tr class="table-secondary">
              <th scope="col">Name</th>
              <th scope="col">Date</th>
              <th scope="col">Location</th>
              <th scope="col">State</th>
              <th scope="col">Host</th>
              <th scope="col">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${allEventsWithoutState}" var="e">
              <tr>
                <td><a href="/events/${e.id}">${e.name}</a></td>
                <td><fmt:formatDate value="${e.date}" pattern="MMMM dd, yyyy"/>${date}</td>
                <td>${e.location}</td>
                <td>${e.state}</td>
                <td>${e.user_event.firstName}</td>
                <td>
                  <c:choose>
                    <c:when test="${ e.user_event.id == user.id }">
                        <div class="d-flex align-items-center">
                          <a href="/events/${e.id}/edit">Edit</a>
                          <form:form class="delete-form" action="/events/${e.id}"
                          method="delete">
                            <input type="submit" value="Delete" class="btn btn-outline-danger ms-2">
                          </form:form>
                        </div>
                    </c:when>
                    <c:when test="${ e.asistentes.contains(user) }">
                          <span>Joining<a href="/event/${e.id}/cancel" class="ms-2">Cancel</a></span>
                      </c:when>
                      <c:otherwise>
                          <a href="/event/${e.id}/join">Join</a>
                      </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="col-6">
        <h2>Create on Event</h2>
        <form:form
          action="/new/event"
          method="post"
          modelAttribute="event"
          class="mt-3"
        >
          <form:hidden value="${user.id}" path="user_event" />
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
            <form:select class="form-select w-auto" type="text" path="state">
              <c:forEach items="${states}" var="state">
                <form:option value="${state}"></form:option>
              </c:forEach>
            </form:select>
          </div>
          <form:errors path="location" class="text-danger" />
          <div class="d-flex justify-content-end mt-3">
            <input type="submit" value="Create" class="btn btn-success" />
          </div>
        </form:form>
      </div>
    </div>
  </body>
</html>
