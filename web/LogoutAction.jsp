<%--
  Created by IntelliJ IDEA.
  User: leia_ira
  Date: 8/20/23
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset = UTF-8>
    <title>JSP 게시판 웹사이트</title>
</head>
<body>
    <%
        session.invalidate();
    %>
    <script>
        location.href = 'main.jsp';
    </script>
</body>
</html>