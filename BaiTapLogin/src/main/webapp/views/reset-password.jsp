<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đặt Lại Mật Khẩu</title>
</head>
<body>
    <h2>Đặt Lại Mật Khẩu Mới</h2>
    
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/reset-password" method="post">
        <%-- Đây là trường ẩn quan trọng để gửi token đi --%>
        <input type="hidden" name="token" value="${token}" />
        
        Mật khẩu mới: <input type="password" name="password" required /><br/><br/>
        Xác nhận mật khẩu mới: <input type="password" name="confirmPassword" required /><br/><br/>
        <input type="submit" value="Lưu mật khẩu" />
    </form>
</body>
</html>