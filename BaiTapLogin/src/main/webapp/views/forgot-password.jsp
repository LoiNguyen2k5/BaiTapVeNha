<%@ page language="java" contentType="text-html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên Mật Khẩu</title>
</head>
<body>
    <h2>Khôi phục mật khẩu</h2>
    <p>Vui lòng nhập email của bạn. Chúng tôi sẽ gửi một link khôi phục đến đó.</p>
    
    <c:if test="${not empty message}">
        <p style="color:green;">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot-password" method="post">
        Email: <input type="email" name="email" required size="30" /><br/><br/>
        <input type="submit" value="Gửi link khôi phục" />
    </form>
</body>
</html>