
package com.baitap02.login.controller;

import java.io.IOException;
import model.User;
import service.UserService;
import service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/reset-password") // Đăng ký URL pattern
public class ResetPasswordController extends HttpServlet {
    
    private UserService userService = new UserServiceImpl();

    // Phương thức này được gọi khi người dùng bấm vào link trong email
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String token = req.getParameter("token");
        User user = userService.validateResetToken(token);

        if (user != null) {
            // Nếu token hợp lệ, chuyển tiếp đến trang JSP để người dùng nhập mật khẩu mới
            req.setAttribute("token", token);
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        } else {
            // Nếu token không hợp lệ, báo lỗi và chuyển về trang login
            req.setAttribute("error", "Link khôi phục không hợp lệ hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    // Phương thức này được gọi khi người dùng nhấn nút "Lưu mật khẩu"
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        String token = req.getParameter("token");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (password == null || confirmPassword == null || !password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("token", token); // Gửi lại token để form không bị mất
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        User user = userService.validateResetToken(token);
        if (user != null) {
            // Nếu token vẫn hợp lệ, cập nhật mật khẩu
            userService.updatePassword(user.getUserName(), password);
            // Chuyển hướng về trang đăng nhập với một thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/login?success=reset");
        } else {
            // Token đã không còn hợp lệ
            req.setAttribute("error", "Link khôi phục không hợp lệ hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}