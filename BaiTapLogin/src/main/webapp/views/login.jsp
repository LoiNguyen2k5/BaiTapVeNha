<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng Nhập</title>
<style>
/* CSS đơn giản để trang dễ nhìn hơn */
body {
	font-family: sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #f0f2f5;
}

.login-container {
	background: white;
	padding: 2rem;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	width: 300px;
}

h2 {
	text-align: center;
}

.alert-danger {
	color: red;
	background-color: #fdd;
	border: 1px solid red;
	padding: 10px;
	border-radius: 4px;
	margin-bottom: 1rem;
}

.form-group {
	margin-bottom: 1rem;
}

.form-group label {
	display: block;
	margin-bottom: 5px;
}

.form-group input {
	width: 100%;
	padding: 8px;
	box-sizing: border-box;
}

button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="login-container">
		<h2>Đăng Nhập Vào Hệ Thống</h2>

		<%-- SỬA LẠI ĐIỀU KIỆN KIỂM TRA CHO AN TOÀN HƠN --%>
		<c:if test="${not empty alert}">
			<div class="alert-danger">${alert}</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/login" method="post">
			<div class="form-group">
				<label for="username">Tài khoản</label> <input type="text"
					id="username" name="username" placeholder="Nhập tài khoản">
			</div>
			<div class="form-group">
				<label for="password">Mật khẩu</label> <input type="password"
					id="password" name="password" placeholder="Nhập mật khẩu">
			</div>
			<button type="submit">Đăng nhập</button>
		</form>
		<p style="text-align: center; margin-top: 1rem;">
			Chưa có tài khoản? <a
				href="${pageContext.request.contextPath}/register">Đăng ký tại
				đây</a>
		</p>
	</div>
</body>
</html>