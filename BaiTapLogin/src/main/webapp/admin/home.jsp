<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- HÃY CHẮC CHẮN DÒNG IMPORT NÀY KHỚP VỚI CẤU TRÚC PACKAGE CỦA BẠN --%>
<%@ page import="model.User" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Quản Trị</title>
</head>
<body>
    <%
        User user = (User) session.getAttribute("account");
        if (user != null && user.getRoleid() == 1) {
    %>
        <h1>Chào mừng Admin, <%= user.getFullName() %>!</h1>
        <p>Đây là trang quản trị của bạn.</p>
        <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    <%
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    %>
</body>
</html>