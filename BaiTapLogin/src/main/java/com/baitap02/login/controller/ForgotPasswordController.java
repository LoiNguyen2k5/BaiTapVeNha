
package com.baitap02.login.controller;
import java.io.IOException;
import service.UserService;
import service.UserServiceImpl; 
import util.EmailUtil;         
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");
        String email = req.getParameter("email");
        
        String token = userService.generateAndSaveResetToken(email);

        if (token != null) {
            EmailUtil.sendPasswordResetLink(email, token, req.getContextPath());
            req.setAttribute("message", "Link khôi phục đã được gửi. Vui lòng kiểm tra email của bạn.");
        } else {
            req.setAttribute("error", "Email không tồn tại trong hệ thống.");
        }
        
        req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
    }
}