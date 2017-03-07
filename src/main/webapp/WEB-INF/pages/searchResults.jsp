<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>
<html>
<head>
    <title>Search users</title>
    <link href="/webjars/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
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

<div class="container">
    <a href="/users">Back to list</a>
    <h3>Search results for ${searchString.searchString}</h3>
    <c:if test="${empty foundUsers}" ><h3>No users with name "${searchString.searchString}" found</h3></c:if>
    <c:if test="${!empty foundUsers}">

        <table class="tg">
            <tr>
                <th width="40">id</th>
                <th width="120">name</th>
                <th width="120">age</th>
                <th width="60">isAdmin</th>
                <th width="256">createdDate</th>
                <th width="80">edit</th>
                <th width="80">delete</th>
            </tr>
            <c:forEach items="${foundUsers}" var="user" varStatus="itr">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.userName}</td>
                    <td>${user.userAge}</td>
                    <td>${user.userIsAdmin}</td>
                    <td>${user.userCreatedDate}</td>
                    <td><a href="<c:url value='/edit/${user.userId}' />" >Edit</a></td>
                    <td><a href="<c:url value='/remove/${user.userId}' />" >Remove</a></td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>