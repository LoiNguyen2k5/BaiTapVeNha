<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa Danh mục</title>
<style>
    /* Sử dụng lại CSS tương tự trang add-category để có sự đồng bộ */
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f7fa;
        color: #333;
        margin: 0;
        padding: 20px;
    }

    .form-container {
        max-width: 600px;
        margin: auto;
        background-color: #fff;
        padding: 20px 30px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        color: #2c3e50;
        border-bottom: 2px solid #e0e0e0;
        padding-bottom: 10px;
        margin-top: 0;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #555;
    }

    .form-group .form-control {
        width: 100%;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 1em;
    }
    
    .form-group input[type="file"] {
        border: 1px solid #ccc;
        padding: 5px;
    }
    
    /* CSS cho phần hiển thị ảnh hiện tại */
    .current-image-container {
        margin-bottom: 1rem;
    }
    
    .current-image-container label {
        font-weight: bold;
        color: #555;
    }
    
    .current-image {
        margin-top: 10px;
        max-width: 150px;
        height: auto;
        border: 1px solid #ddd;
        border-radius: 5px;
        padding: 5px;
    }

    /* Nhóm các nút bấm */
    .button-group {
        display: flex;
        gap: 10px;
        margin-top: 20px;
    }

    .button-group button {
        flex-grow: 1;
        padding: 12px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1em;
        font-weight: bold;
    }

    .btn-submit {
        background-color: #007bff; /* Màu xanh dương cho nút cập nhật */
        color: white;
    }
    .btn-submit:hover {
        background-color: #0069d9;
    }

    .back-link {
        display: block;
        margin-top: 20px;
        text-align: center;
    }
    .back-link a {
        color: #007bff;
        text-decoration: none;
    }
</style>
</head>
<body>
    <div class="form-container">
        <h2>Chỉnh sửa Danh mục</h2>

        <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
            
            <!-- Trường ẩn này rất quan trọng để gửi id của category đi -->
            <input type="hidden" name="id" value="${category.cateId}" />
            
            <div class="form-group">
                <label for="cateName">Tên danh mục:</label>
                <input type="text" id="cateName" name="cateName" class="form-control" value="${category.cateName}" required />
            </div>
            
            <div class="current-image-container">
                <label>Ảnh hiện tại:</label><br/>
                <c:if test="${not empty category.icon}">
                    <c:url value="/image" var="imgUrl">
                        <c:param name="fname" value="${category.icon}" />
                    </c:url>
                    <img src="${imgUrl}" class="current-image" />
                </c:if>
                <c:if test="${empty category.icon}">
                    <span>(Chưa có ảnh)</span>
                </c:if>
            </div>
            
            <div class="form-group">
                <label for="icon">Chọn ảnh mới (nếu muốn thay đổi):</label>
                <input type="file" id="icon" name="icon" class="form-control" />
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">Cập nhật</button>
            </div>
            
        </form>
        
        <p class="back-link">
            <a href="${pageContext.request.contextPath}/admin/category/list">Quay lại Danh sách</a>
        </p>
    </div>
</body>
</html>