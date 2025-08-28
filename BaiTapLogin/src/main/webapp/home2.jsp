<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.User" %> <%-- Thay đổi package cho đúng --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Chủ</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("account");
        if (user != null) {
    %>
        <h1>Chào mừng, <%= user.getFullName() %>!</h1>
        <p>Bạn đã đăng nhập thành công với vai trò người dùng.</p>
        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    <%
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    %>
</body>
</html>