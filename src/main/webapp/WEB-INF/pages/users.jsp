<%@ page language="java" contentType="text/html; ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tg" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="http://www.thymeleaf.org">
<head>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="https://ajax.googLeapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <title>Users Page</title>

    <style type="text/css">
        .tg {
            border-collapse: collapse;
            border-spacing: 0;
            border-color: #ccc;
        }

        .tg td {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #fff;
        }

        .tg th {
            font-family: Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            padding: 10px 5px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #ccc;
            color: #333;
            background-color: #f0f0f0;
        }

        .tg .tg-4eph {
            background-color: #f9f9f9
        }
    </style>
</head>
<body>
<a href="../../index.jsp">Back to main menu</a>

<br/>
<br/>

<c:if test="${empty listUsers}" ><h3>Nothing to show</h3></c:if>

<c:if test="${!empty listUsers}">
    <h3>Search users by name</h3>
    <form:form method="post" action="/searchResults" modelAttribute="searchString">
        <form:input path="searchString" />
        <input class="btn btn-xs btn-default" type="submit" value="Search"/>
    </form:form>

    <h1>User List</h1>
    <table class="tg">
        <tr>
            <th width="80">ID</th>
            <th width="120">Name</th>
            <th width="60">Age</th>
            <th width="60">isAdmin</th>
            <th width="120">Created date</th>
            <th width="60">Edit</th>
            <th width="60">Delete</th>
        </tr>
        <c:forEach items="${listUsers}" var="user"  varStatus="itr">
            <tr>
                <td>${user.userId}</td>
                <td><a href="/userdata/${user.userId}" target="_blank">${user.userName}</a></td>
                <td>${user.userAge}</td>
                <td>${user.userIsAdmin}</td>
                <td>${user.userCreatedDate}</td>
                <td><a href="<c:url value='/edit/${user.userId}'/>">Edit</a></td>
                <td><a href="<c:url value='/remove/${user.userId}'/>">Delete</a></td>
            </tr>
        </c:forEach>
    </table>

    <div class="row">
        <div class="col-md-12 text-center">
            <div class='pagination pagination-centered'>
                <ul class="pagination">
                    <li <c:if test="${page<=1}"> class="disabled"</c:if>>
                        <a href="/users/page/1">First</a>
                    </li>
                    <li <c:if test="${page<=1}"> class="disabled" </c:if>>
                        <a href="/users/page/${page-1}">«</a>
                    </li>
                    <c:forEach begin="1" end="${pages}" var="p">
                        <li><a href="/users/page/${p}">${p}</a></li>
                     </c:forEach>
                    </li>
                    <li <c:if test="${page>=pages}"> class="disabled" </c:if>>
                        <a href="/users/page/${page+1}">&raquo;</a>
                    </li>
                    <li <c:if test="${page>=pages}"> class="disabled"</c:if>>
                        <a href="/users/page/${pages}">Last</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</c:if>


<h1>Add a User</h1>

<c:url var="addAction" value="/users/add"/>

<form:form action="${addAction}" commandName="user">
    <table>
        <c:if test="${!empty user.userName}">
            <tr>
                <td>
                    <form:label path="userId">
                        <spring:message text="ID"/>
                    </form:label>
                </td>
                <td>
                    <form:input path="userId" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="userId"/>
                </td>
            </tr>
        </c:if>
        <tr>
            <td>
                <form:label path="userName">
                    <spring:message text="Name"/>
                </form:label>
            </td>
            <td>
                <form:input path="userName"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="userAge">
                    <spring:message text="Age"/>
                </form:label>
            </td>
            <td>
                <form:input path="userAge"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="userIsAdmin">
                    <spring:message text="isAdmin"/>
                </form:label>
            </td>
            <td>
                <form:input path="userIsAdmin"/>
            </td>
        </tr>
        <tr>
            <td>
                <form:label path="userCreatedDate">
                    <spring:message text="CreatedDate"/>
                </form:label>
            </td>
            <td>
                <form:input path="userCreatedDate"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <c:if test="${!empty user.userName}">
                    <input type="submit" value="<spring:message text="Edit User"/>"/>
                </c:if>
                <c:if test="${empty user.userName}">
                    <input type="submit" value="<spring:message text="Add User"/>"/>
                </c:if>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
