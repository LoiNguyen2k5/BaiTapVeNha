package com.baitap02.login.controller; 

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;

import util.Constant; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        String fileName = req.getParameter("fname");
        
        if (fileName == null || fileName.isEmpty()) {
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        File file = new File(Constant.DIR, fileName);

        if (file.exists()) {
            resp.setContentType("image/jpeg"); // Hoặc image/png, image/gif...
            
            try (FileInputStream in = new FileInputStream(file)) {
                IOUtils.copy(in, resp.getOutputStream());
            }
        } else {
            // In ra console để gỡ lỗi
            System.out.println("File not found at path: " + file.getAbsolutePath());
            resp.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}