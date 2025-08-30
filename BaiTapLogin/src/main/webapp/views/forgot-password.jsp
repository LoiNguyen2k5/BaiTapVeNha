<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên Mật Khẩu</title>
<style>
    /* Sử dụng lại CSS tương tự trang login để có sự đồng bộ */
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #f0f2f5;
    }

    .forgot-password-container {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 350px;
        text-align: center; /* Căn giữa nội dung bên trong */
    }

    h2 {
        color: #333;
        margin-top: 0;
    }
    
    .instructions {
        color: #555;
        margin-bottom: 1.5rem;
    }

    /* Định dạng cho cả thông báo thành công và lỗi */
    .alert {
        padding: 10px;
        border-radius: 4px;
        margin-bottom: 1rem;
        border: 1px solid transparent;
    }
    .alert-success {
        color: #155724;
        background-color: #d4edda;
        border-color: #c3e6cb;
    }
    .alert-danger {
        color: #721c24;
        background-color: #f8d7da;
        border-color: #f5c6cb;
    }

    .form-group {
        margin-bottom: 1.5rem;
        text-align: left; /* Căn trái cho các phần tử trong form */
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }

    .form-group input {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    button {
        width: 100%;
        padding: 12px;
        background-color: #ffc107; /* Màu vàng cho hành động phụ */
        color: #212529;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1em;
        font-weight: bold;
    }
    button:hover {
        background-color: #e0a800;
    }
    
    .back-link {
        display: block; /* Hiển thị trên một dòng riêng */
        margin-top: 1rem;
    }
    .back-link a {
        color: #007bff;
        text-decoration: none;
    }
    .back-link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="forgot-password-container">
        <h2>Khôi phục mật khẩu</h2>
        <p class="instructions">Vui lòng nhập email của bạn. Chúng tôi sẽ gửi một link khôi phục đến đó.</p>
        
        <%-- Hiển thị thông báo thành công hoặc lỗi --%>
        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="example@email.com" required />
            </div>
            <button type="submit">Gửi link khôi phục</button>
        </form>
        
        <p class="back-link">
            <a href="${pageContext.request.contextPath}/login">Quay lại trang Đăng nhập</a>
        </p>
    </div>
</body>
</html>