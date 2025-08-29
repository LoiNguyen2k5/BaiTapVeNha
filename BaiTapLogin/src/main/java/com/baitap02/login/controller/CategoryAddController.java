// Đảm bảo package khớp với vị trí file của bạn
package com.baitap02.login.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

// --- CÁC CÂU LỆNH IMPORT BỊ THIẾU ---
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.Category;
import service.CategoryService;
import service.CategoryServiceImpl;
import util.Constant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
// ------------------------------------

@WebServlet(urlPatterns = "/admin/category/add")
public class CategoryAddController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    CategoryService cateService = (CategoryService) new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị trang form add
        req.getRequestDispatcher("/admin/add-category.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Category category = new Category();
        DiskFileItemFactory factory = new DiskFileItemFactory();
        
        // Cấu hình factory
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
            // Phân tích request để lấy các file item
            List<FileItem> items = upload.parseRequest(req);
            
            // Xử lý từng file item
            for (FileItem item : items) {
                if (item.isFormField()) {
                    // Xử lý các trường form thông thường
                    if ("cateName".equals(item.getFieldName())) {
                        category.setCateName(item.getString("UTF-8"));
                    }
                } else {
                    // Xử lý trường upload file
                    if (item.getSize() > 0) { // Chỉ xử lý nếu có file được chọn
                        String originalFileName = item.getName();
                        int index = originalFileName.lastIndexOf(".");
                        String ext = originalFileName.substring(index + 1);
                        String fileName = System.currentTimeMillis() + "." + ext;
                        
                        // Tạo thư mục nếu chưa tồn tại
                        File dir = new File(Constant.DIR + "/category");
                        if (!dir.exists()) {
                            dir.mkdirs();
                        }
                        
                        File file = new File(dir, fileName);
                        item.write(file);
                        
                        category.setIcon("category/" + fileName);
                    }
                }
            }
            
            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/category/list");

        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}