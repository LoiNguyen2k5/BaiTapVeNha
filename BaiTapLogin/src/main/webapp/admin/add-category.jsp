<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Thêm Danh mục</title></head>
<body>
    <h2>Thêm Danh mục mới</h2>
    <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
        Tên danh mục: <input type="text" name="cateName" required /><br/><br/>
        Ảnh đại diện: <input type="file" name="icon" /><br/><br/>
        <button type="submit">Thêm</button>
    </form>
</body>
</html>