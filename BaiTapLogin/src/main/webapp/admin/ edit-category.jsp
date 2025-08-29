<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head><title>Sửa Danh mục</title></head>
<body>
    <h2>Chỉnh sửa Danh mục</h2>
    <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="${category.cateId}" />
        Tên danh mục: <input type="text" name="cateName" value="${category.cateName}" required /><br/><br/>
        Ảnh hiện tại: <br/>
        <c:if test="${not empty category.icon}">
            <c:url value="/image?fname=${category.icon}" var="imgUrl" />
            <img src="${imgUrl}" width="100" />
        </c:if>
        <br/><br/>
        Chọn ảnh mới (nếu muốn thay đổi): <input type="file" name="icon" /><br/><br/>
        <button type="submit">Cập nhật</button>
    </form>
</body>
</html>