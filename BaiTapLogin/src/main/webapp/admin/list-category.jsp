<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý Danh mục</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- CSS cải tiến -->
<style>
    /* Reset và font cơ bản */
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        min-height: 100vh;
        padding: 20px;
    }

    /* Container chính - tận dụng toàn bộ chiều rộng */
    .container {
        max-width: 95%;
        width: 100%;
        margin: 0 auto;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        animation: slideUp 0.6s ease-out;
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* Header section */
    .header-section {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
        padding: 30px 40px;
        position: relative;
        overflow: hidden;
    }

    .header-section::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: repeating-linear-gradient(
            45deg,
            transparent,
            transparent 10px,
            rgba(255,255,255,0.05) 10px,
            rgba(255,255,255,0.05) 20px
        );
        animation: slide 20s linear infinite;
    }

    @keyframes slide {
        0% { transform: translate(-50%, -50%) rotate(0deg); }
        100% { transform: translate(-50%, -50%) rotate(360deg); }
    }

    .header-content {
        position: relative;
        z-index: 2;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 20px;
    }

    .header-title {
        font-size: 2.5em;
        font-weight: 700;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        letter-spacing: -1px;
    }

    .stats-container {
        display: flex;
        gap: 20px;
        flex-wrap: wrap;
    }

    .stat-card {
        background: rgba(255, 255, 255, 0.2);
        padding: 15px 20px;
        border-radius: 12px;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.3);
        text-align: center;
        min-width: 120px;
    }

    .stat-number {
        font-size: 1.8em;
        font-weight: bold;
        display: block;
    }

    .stat-label {
        font-size: 0.9em;
        opacity: 0.9;
        margin-top: 5px;
    }

    /* Content section */
    .content-section {
        padding: 40px;
    }

    /* Action bar */
    .action-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        flex-wrap: wrap;
        gap: 15px;
    }

    .btn-add {
        background: linear-gradient(45deg, #56ab2f, #a8e6cf);
        color: white;
        padding: 12px 25px;
        text-decoration: none;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(86, 171, 47, 0.3);
        position: relative;
        overflow: hidden;
    }

    .btn-add::before {
        content: '+ ';
        font-size: 1.2em;
        margin-right: 5px;
    }

    .btn-add:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(86, 171, 47, 0.4);
        background: linear-gradient(45deg, #4a9426, #95d6b8);
    }

    .search-box {
        display: flex;
        align-items: center;
        background: white;
        border-radius: 25px;
        padding: 8px 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border: 2px solid #e1e8ed;
        transition: all 0.3s ease;
    }

    .search-box:focus-within {
        border-color: #667eea;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.2);
    }

    .search-box input {
        border: none;
        outline: none;
        padding: 8px;
        font-size: 14px;
        flex: 1;
        background: transparent;
    }

    .search-box button {
        background: #667eea;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .search-box button:hover {
        background: #5a67d8;
        transform: scale(1.05);
    }

    /* Bảng với thiết kế hiện đại */
    .table-container {
        background: white;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        border: 1px solid #e1e8ed;
    }

    .styled-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95em;
    }

    .styled-table thead tr {
        background: linear-gradient(45deg, #667eea, #764ba2);
        color: white;
    }
    
    .styled-table th {
        padding: 18px 20px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        border: none;
        position: relative;
    }

    .styled-table th::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 3px;
        background: rgba(255, 255, 255, 0.3);
    }
    
    .styled-table td {
        padding: 18px 20px;
        border-bottom: 1px solid #f0f0f0;
        vertical-align: middle;
        transition: all 0.3s ease;
    }
    
    .styled-table tbody tr {
        transition: all 0.3s ease;
    }

    .styled-table tbody tr:hover {
        background: linear-gradient(45deg, #f8f9ff, #fff5f5);
        transform: scale(1.01);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    /* Căn chỉnh cột */
    .col-stt {
        text-align: center;
        width: 80px;
        font-weight: bold;
        color: #667eea;
    }

    .col-image {
        text-align: center;
        width: 120px;
    }
    
    .col-image img {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        transition: all 0.3s ease;
        border: 3px solid #f0f0f0;
    }

    .col-image img:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
        border-color: #667eea;
    }

    .col-name {
        font-weight: 600;
        color: #2c3e50;
        font-size: 1.1em;
    }

    .col-action {
        text-align: center;
        width: 150px;
    }
    
    /* Action buttons */
    .action-link {
        display: inline-block;
        padding: 8px 16px;
        margin: 0 5px;
        border-radius: 20px;
        text-decoration: none;
        font-weight: 600;
        font-size: 0.9em;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }

    .action-link.edit {
        background: linear-gradient(45deg, #4CAF50, #45a049);
        color: white;
        box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
    }

    .action-link.edit:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(76, 175, 80, 0.4);
        background: linear-gradient(45deg, #45a049, #3d8b40);
    }

    .action-link.delete {
        background: linear-gradient(45deg, #f44336, #d32f2f);
        color: white;
        box-shadow: 0 2px 8px rgba(244, 67, 54, 0.3);
    }

    .action-link.delete:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(244, 67, 54, 0.4);
        background: linear-gradient(45deg, #d32f2f, #b71c1c);
    }

    /* Empty state */
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        color: #666;
    }

    .empty-state img {
        width: 120px;
        opacity: 0.5;
        margin-bottom: 20px;
    }

    .empty-state h3 {
        font-size: 1.5em;
        margin-bottom: 10px;
        color: #999;
    }

    .empty-state p {
        font-size: 1.1em;
        line-height: 1.6;
    }

    /* Responsive design */
    @media (max-width: 768px) {
        body {
            padding: 10px;
        }

        .container {
            max-width: 100%;
            border-radius: 15px;
        }

        .header-section {
            padding: 20px;
        }

        .header-title {
            font-size: 2em;
        }

        .content-section {
            padding: 20px;
        }

        .action-bar {
            flex-direction: column;
            align-items: stretch;
        }

        .search-box {
            order: -1;
            margin-bottom: 15px;
        }

        .styled-table {
            font-size: 0.85em;
        }

        .styled-table th,
        .styled-table td {
            padding: 12px 8px;
        }

        .col-image img {
            width: 60px;
            height: 60px;
        }

        .action-link {
            display: block;
            margin: 2px 0;
            padding: 6px 12px;
            font-size: 0.8em;
        }

        .stats-container {
            justify-content: center;
        }

        .stat-card {
            min-width: 100px;
            padding: 12px 15px;
        }
    }

    @media (max-width: 480px) {
        .header-title {
            font-size: 1.8em;
        }

        .stats-container {
            display: none;
        }

        .styled-table th,
        .styled-table td {
            padding: 10px 5px;
            font-size: 0.8em;
        }
    }

    /* Hiệu ứng loading cho bảng */
    .table-loading {
        opacity: 0.7;
        pointer-events: none;
    }

    /* Tooltip cho hình ảnh */
    .image-tooltip {
        position: relative;
        display: inline-block;
    }

    .image-tooltip:hover::after {
        content: 'Click để xem chi tiết';
        position: absolute;
        bottom: -30px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(0, 0, 0, 0.8);
        color: white;
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 0.8em;
        white-space: nowrap;
        z-index: 1000;
    }

    /* Pagination styles (nếu cần thêm sau) */
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 30px;
        gap: 10px;
    }

    .pagination a {
        padding: 10px 15px;
        background: white;
        border: 2px solid #667eea;
        color: #667eea;
        text-decoration: none;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .pagination a:hover,
    .pagination a.active {
        background: #667eea;
        color: white;
        transform: translateY(-2px);
    }

    /* Badge cho số lượng */
    .count-badge {
        background: linear-gradient(45deg, #ff6b6b, #ee5a52);
        color: white;
        padding: 5px 12px;
        border-radius: 20px;
        font-size: 0.9em;
        font-weight: bold;
        box-shadow: 0 2px 8px rgba(255, 107, 107, 0.3);
    }

    /* Floating action button cho mobile */
    .fab {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        background: linear-gradient(45deg, #56ab2f, #a8e6cf);
        border-radius: 50%;
        display: none;
        align-items: center;
        justify-content: center;
        color: white;
        text-decoration: none;
        font-size: 1.5em;
        box-shadow: 0 4px 20px rgba(86, 171, 47, 0.4);
        transition: all 0.3s ease;
        z-index: 1000;
    }

    @media (max-width: 768px) {
        .fab {
            display: flex;
        }
        
        .btn-add {
            display: none;
        }
    }

    .fab:hover {
        transform: scale(1.1);
        box-shadow: 0 6px 25px rgba(86, 171, 47, 0.5);
    }
</style>

</head>
<body>
    <div class="container">
        <!-- Header Section -->
        <div class="header-section">
            <div class="header-content">
                <h1 class="header-title">Quản lý Danh mục</h1>
                <div class="stats-container">
                    <div class="stat-card">
                        <span class="stat-number">${cateList.size()}</span>
                        <div class="stat-label">Tổng danh mục</div>
                    </div>
                    <div class="stat-card">
                        <span class="stat-number count-badge">Hoạt động</span>
                        <div class="stat-label">Trạng thái</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content Section -->
        <div class="content-section">
            <!-- Action Bar -->
            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/admin/category/add" class="btn-add">
                    Thêm danh mục mới
                </a>
                
                <div class="search-box">
                    <input type="text" placeholder="Tìm kiếm danh mục..." id="searchInput">
                    <button type="button" onclick="searchCategories()">🔍</button>
                </div>
            </div>
            
            <!-- Table Container -->
            <div class="table-container">
                <table class="styled-table" id="categoryTable">
                    <thead>
                        <tr>
                            <th class="col-stt">STT</th>
                            <th class="col-image">Hình ảnh</th>
                            <th class="col-name">Tên danh mục</th>
                            <th class="col-action">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty cateList}">
                                <c:forEach items="${cateList}" var="cate" varStatus="loop">
                                    <tr>
                                        <td class="col-stt">${loop.index + 1}</td>
                                        <td class="col-image">
                                            <c:choose>
                                                <c:when test="${not empty cate.icon}">
                                                    <c:url value="/image" var="imgUrl">
                                                        <c:param name="fname" value="${cate.icon}" />
                                                    </c:url>
                                                    <div class="image-tooltip">
                                                        <img src="${imgUrl}" alt="${cate.cateName}" />
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="width: 80px; height: 80px; background: #f0f0f0; border-radius: 12px; display: flex; align-items: center; justify-content: center; color: #999; font-size: 0.8em;">
                                                        📁<br>Không có ảnh
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="col-name">${cate.cateName}</td>
                                        <td class="col-action">
                                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.cateId}" 
                                               class="action-link edit" title="Chỉnh sửa danh mục">
                                               ✏️ Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.cateId}" 
                                               class="action-link delete" 
                                               title="Xóa danh mục"
                                               onclick="return confirm('⚠️ Bạn có chắc chắn muốn xóa danh mục \"${cate.cateName}\" không?\n\nLưu ý: Hành động này không thể hoàn tác!');">
                                               🗑️ Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="empty-state">
                                        <div>
                                            <div style="font-size: 4em; margin-bottom: 20px;">📂</div>
                                            <h3>Chưa có danh mục nào</h3>
                                            <p>Hãy thêm danh mục đầu tiên để bắt đầu quản lý sản phẩm của bạn!</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Pagination sẽ được thêm ở đây nếu cần -->
            <!-- <div class="pagination">
                <a href="#" class="active">1</a>
                <a href="#">2</a>
                <a href="#">3</a>
                <a href="#">...</a>
                <a href="#">10</a>
            </div> -->
        </div>
    </div>

    <!-- Floating Action Button cho mobile -->
    <a href="${pageContext.request.contextPath}/admin/category/add" class="fab" title="Thêm danh mục mới">
        +
    </a>

    <!-- JavaScript cho search và các hiệu ứng -->
    <script>
        // Search functionality
        function searchCategories() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const table = document.getElementById('categoryTable');
            const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
            
            for (let i = 0; i < rows.length; i++) {
                const nameCell = rows[i].getElementsByClassName('col-name')[0];
                if (nameCell) {
                    const name = nameCell.textContent || nameCell.innerText;
                    if (name.toLowerCase().indexOf(searchTerm) > -1) {
                        rows[i].style.display = '';
                    } else {
                        rows[i].style.display = 'none';
                    }
                }
            }
        }

        // Real-time search
        document.getElementById('searchInput').addEventListener('keyup', function(e) {
            if (e.key === 'Enter') {
                searchCategories();
            }
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Loading effect cho table khi click action
        document.querySelectorAll('.action-link').forEach(link => {
            link.addEventListener('click', function(e) {
                if (!this.classList.contains('delete')) {
                    document.getElementById('categoryTable').classList.add('table-loading');
                }
            });
        });

        // Animate on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe table rows
        document.querySelectorAll('.styled-table tbody tr').forEach(row => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(20px)';
            row.style.transition = 'all 0.6s ease';
            observer.observe(row);
        });
    </script>
</body>
</html>