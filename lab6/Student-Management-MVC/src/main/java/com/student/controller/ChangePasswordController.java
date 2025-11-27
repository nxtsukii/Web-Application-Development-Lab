/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.student.controller;

/**
 *
 * @author natsuki
 */

import com.student.dao.UserDAO;
import com.student.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {
    private UserDAO userDAO;
    
    @Override
    public void init() {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("views/change-password.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO: Get current user from session
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login");
            return;
        }
        
        // TODO: Get form parameters (currentPassword, newPassword, confirmPassword)
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // TODO: Validate current password
        if (!BCrypt.checkpw(currentPassword, currentUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            request.getRequestDispatcher("views/change-password.jsp").forward(request, response);
            return;
        }
        
        // TODO: Validate new password (length, match)
        if (newPassword.length() < 8) {
            request.setAttribute("error", "New password must be at least 8 characters.");
            request.getRequestDispatcher("views/change-password.jsp").forward(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match.");
            request.getRequestDispatcher("views/change-password.jsp").forward(request, response);
            return;
        }
        // TODO: Hash new password
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
        
        // TODO: Update in database
        boolean updated = userDAO.updatePassword(currentUser.getId(), hashedPassword);
        
        // TODO: Show success/error message
        if (updated) {
            currentUser.setPassword(hashedPassword);

            request.setAttribute("message", "Password updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update password. Try again.");
        }

        request.getRequestDispatcher("views/change-password.jsp").forward(request, response);
    }
}
