<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Danh mục</title>
</head>
<body>
    <h2>Danh sách Danh mục</h2>
    <a href="${pageContext.request.contextPath}/admin/category/add">Thêm mới</a>
    <br/><br/>
    <table border="1" style="width: 600px; border-collapse: collapse;">
        <tr style="background-color: #f2f2f2;">
            <th style="padding: 8px;">STT</th>
            <th style="padding: 8px;">Hình ảnh</th>
            <th style="padding: 8px;">Tên danh mục</th>
            <th style="padding: 8px;">Hành động</th>
        </tr>
        <c:forEach items="${cateList}" var="cate" varStatus="loop">
            <tr>
                <td style="text-align: center; padding: 8px;">${loop.index + 1}</td>
                <td style="text-align: center; padding: 8px;">
                    <c:if test="${not empty cate.icon}">
                        <c:url value="/image" var="imgUrl">
                            <c:param name="fname" value="${cate.icon}" />
                        </c:url>
                        <img src="${imgUrl}" width="100" alt="Icon" />
                    </c:if>
                </td>
                <td style="padding: 8px;">${cate.cateName}</td>
                <td style="text-align: center; padding: 8px;">
                    <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.cateId}">Sửa</a> |
                    <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.cateId}" onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>