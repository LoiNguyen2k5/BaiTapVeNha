package com.baitap02.login.controller;

import java.io.File;
import java.io.IOException;

// Import các lớp của dự án
import model.Category;
import service.CategoryService;
import service.CategoryServiceImpl;
import util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("--- Bắt đầu CategoryDeleteController - doGet ---");
        
        try {
            String idStr = req.getParameter("id");
            System.out.println("ID cần xóa: " + idStr);
            
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                
                // Lấy thông tin category trước khi xóa (để xóa file ảnh)
                Category category = cateService.get(id);
                
                if (category != null) {
                    System.out.println("Tìm thấy Category cần xóa: " + category.getCateName());
                    
                    // Xóa file ảnh nếu có
                    if (category.getIcon() != null && !category.getIcon().isEmpty()) {
                        String iconPath = Constant.DIR + "/" + category.getIcon();
                        File iconFile = new File(iconPath);
                        if (iconFile.exists()) {
                            boolean deleted = iconFile.delete();
                            System.out.println("Xóa file ảnh: " + (deleted ? "Thành công" : "Thất bại"));
                        }
                    }
                    
                    // Xóa category khỏi database
                    cateService.delete(id);
                    System.out.println("Đã xóa Category với ID = " + id);
                    
                    // Set thông báo thành công
                    req.getSession().setAttribute("message", "Xóa danh mục '" + category.getCateName() + "' thành công!");
                    
                } else {
                    System.out.println("KHÔNG tìm thấy Category với ID = " + id);
                    req.getSession().setAttribute("error", "Không tìm thấy danh mục cần xóa!");
                }
            } else {
                System.out.println("ID không hợp lệ");
                req.getSession().setAttribute("error", "ID danh mục không hợp lệ!");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("Lỗi format ID: " + e.getMessage());
            req.getSession().setAttribute("error", "ID danh mục không đúng định dạng!");
        } catch (Exception e) {
            System.out.println("Lỗi khi xóa category: " + e.getMessage());
            e.printStackTrace();
            req.getSession().setAttribute("error", "Có lỗi xảy ra khi xóa danh mục: " + e.getMessage());
        }
        
        // Chuyển hướng về trang danh sách
        System.out.println("--- Chuyển hướng về danh sách category ---");
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Có thể sử dụng POST method để xóa an toàn hơn
        // Gọi lại doGet để xử lý
        doGet(req, resp);
    }
}