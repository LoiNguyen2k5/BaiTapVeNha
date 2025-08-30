<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Ký Tài Khoản</title>
<style>
    /* Sử dụng lại CSS tương tự trang login để có sự đồng bộ */
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh; /* Dùng min-height để form dài hơn không bị cắt */
        background-color: #f0f2f5;
        margin: 20px 0; /* Thêm khoảng đệm trên dưới */
    }

    .register-container {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        width: 350px; /* Tăng chiều rộng một chút cho form dài hơn */
    }

    h2 {
        text-align: center;
        color: #333;
    }

    .alert-danger {
        color: #721c24;
        background-color: #f8d7da;
        border: 1px solid #f5c6cb;
        padding: 10px;
        border-radius: 4px;
        margin-bottom: 1rem;
        text-align: center;
    }

    .form-group {
        margin-bottom: 1rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #555;
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
        background-color: #28a745; /* Màu xanh lá cho nút đăng ký */
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1em;
        font-weight: bold;
    }
    button:hover {
        background-color: #218838;
    }
    
    .login-link {
        text-align: center;
        margin-top: 1rem;
        color: #555;
    }
    .login-link a {
        color: #007bff;
        text-decoration: none;
    }
    .login-link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
    <div class="register-container">
        <h2>Tạo Tài Khoản Mới</h2>

        <c:if test="${not empty alert}">
            <div class="alert-danger">${alert}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group">
                <label for="fullname">Họ tên</label>
                <input type="text" id="fullname" name="fullname" placeholder="Nhập họ và tên" required />
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Nhập email" required />
            </div>
            
            <div class="form-group">
                <label for="phone">Số điện thoại</label>
                <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required />
            </div>
            
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" name="username" placeholder="Nhập tên đăng nhập" required />
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required />
            </div>
            
            <button type="submit">Tạo tài khoản</button>
        </form>
        
        <p class="login-link">
            Nếu bạn đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </p>
    </div>
</body>
</html>