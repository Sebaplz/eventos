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
<html>
  <head>
    <meta charset="ISO-8859-1" />
    <title>${event.name}</title>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/css/main.css" />
    <!-- change to match your file/naming structure -->
    <script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/js/app.js"></script>
    <!-- change to match your file/naming structure -->

  </head>
  <body>
    <div class="container d-flex align-items-top">
      <div class="col-6 mt-5">
        <h1>${event.name}</h1>
        <h4>
          Host: ${event.user_event.firstName} ${event.user_event.lastName}
        </h4>
        <h4>Date: <fmt:formatDate value="${event.date}" pattern="MMMM dd, yyyy"/>${date}</h4>
        <h4>Location: ${event.location}, ${event.state}</h4>
        <h4>People who are attending this event: ${event.asistentes.size()}</h4>
        <div>
          <table class="table table-striped border border-1 mt-3">
            <thead>
              <tr class="table-secondary">
                <th scope="col">Name</th>
                <th scope="col">Location</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${ event.asistentes }" var="user">
                <tr>
                  <td>${ user.firstName } ${ user.lastName }</td>
                  <td>${ user.location }</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
      <div class="col-6 mt-5 ms-5">
        <a href="/events" class="d-flex justify-content-end mb-5 fs-3"
          >Dashboard</a
        >
        <h2 class="fs-1">Message Wall</h2>
        <div class="messages border border-2">
          <c:forEach items="${ event.messages }" var="message">
            <p>${ message.author.firstName } says: ${ message.comment }</p>
          </c:forEach>
        </div>
        <form action="/events/${ event.id }/comment" method="post">
          <div class="form-group">
            <label for="comment">Add Comment:</label> <span>${ error }</span>
            <textarea
              name="comment"
              id="comment"
              class="form-control"
            ></textarea>
            <div class="d-flex justify-content-end mt-2">
              <button class="btn btn-success">Submit</button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
