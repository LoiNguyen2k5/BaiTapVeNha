package com.baitap02.login.controller;

import java.io.IOException;
import service.UserService;
import service.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Khi người dùng truy cập /register, hiển thị trang đăng ký
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (userService.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        if (userService.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        boolean isSuccess = userService.register(email, password, username, fullname, phone);
        if (isSuccess) {
            // Đăng ký thành công, chuyển hướng về trang đăng nhập
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            // Có lỗi hệ thống (có thể do username đã tồn tại, race condition)
            req.setAttribute("alert", "Lỗi hệ thống! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }
}