<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Tài Khoản</title>
</head>
<body>
    <h2>Tạo Tài Khoản Mới</h2>
    <form action="${pageContext.request.contextPath}/register" method="post">
        <c:if test="${not empty alert}">
            <h3 style="color:red;">${alert}</h3>
        </c:if>
        
        Họ tên: <input type="text" name="fullname" required /><br/><br/>
        Email: <input type="email" name="email" required /><br/><br/>
        Số điện thoại: <input type="text" name="phone" required /><br/><br/>
        Tên đăng nhập: <input type="text" name="username" required /><br/><br/>
        Mật khẩu: <input type="password" name="password" required /><br/><br/>
        
        <input type="submit" value="Tạo tài khoản" />
    </form>
    <p>Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
</body>
</html>