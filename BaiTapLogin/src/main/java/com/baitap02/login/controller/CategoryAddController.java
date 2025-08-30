// Đảm bảo package khớp với vị trí file của bạn
package com.baitap02.login.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

// Import các lớp của dự án
import model.Category;
import service.CategoryService;
import service.CategoryServiceImpl;
import util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(urlPatterns = "/admin/category/add")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB  
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("--- Hiển thị trang thêm danh mục ---");
        // Hiển thị trang form add
        req.getRequestDispatcher("/admin/add-category.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");
            
            Category category = new Category();
            
            // Lấy tên danh mục từ form
            String cateName = req.getParameter("cateName");
            if (cateName != null && !cateName.trim().isEmpty()) {
                category.setCateName(cateName.trim());
                System.out.println("Tên danh mục: " + cateName);
            } else {
                throw new Exception("Tên danh mục không được để trống!");
            }
            
            // Xử lý file upload cho icon
            Part iconPart = req.getPart("icon");
            if (iconPart != null && iconPart.getSize() > 0) {
                String originalFileName = iconPart.getSubmittedFileName();
                System.out.println("File được chọn: " + originalFileName);
                
                if (originalFileName != null && !originalFileName.isEmpty()) {
                    // Lấy extension của file
                    int index = originalFileName.lastIndexOf(".");
                    if (index == -1) {
                        throw new Exception("File không có extension!");
                    }
                    
                    String ext = originalFileName.substring(index + 1);
                    String fileName = System.currentTimeMillis() + "." + ext;
                    
                    // Tạo thư mục nếu chưa tồn tại
                    File dir = new File(Constant.DIR + "/category");
                    if (!dir.exists()) {
                        boolean created = dir.mkdirs();
                        System.out.println("Tạo thư mục: " + created);
                    }
                    
                    // Lưu file
                    String filePath = dir.getAbsolutePath() + File.separator + fileName;
                    Files.copy(iconPart.getInputStream(), 
                              Paths.get(filePath), 
                              StandardCopyOption.REPLACE_EXISTING);
                    
                    category.setIcon("category/" + fileName);
                    System.out.println("File đã được lưu: " + filePath);
                }
            } else {
                System.out.println("Không có file nào được chọn");
                // Có thể set icon mặc định hoặc để null
                category.setIcon(null);
            }
            
            // Lưu category vào database
            cateService.insert(category);
            System.out.println("Đã thêm danh mục thành công!");
            
            // Chuyển hướng về trang danh sách
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } catch (Exception e) {
            System.out.println("Lỗi khi thêm danh mục: " + e.getMessage());
            e.printStackTrace();
            
            // Gửi thông báo lỗi về trang add
            req.setAttribute("error", "Có lỗi xảy ra khi thêm danh mục: " + e.getMessage());
            req.getRequestDispatcher("/admin/add-category.jsp").forward(req, resp);
        }
    }
}