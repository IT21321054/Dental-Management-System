package com.dental.controller;

import com.dental.dao.UserDAO;
import com.dental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// =======================================================================
// CONTROLLER: RegisterServlet
// Handles the creation of a new user account from the registration page
// =======================================================================
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve data from the register.jsp form
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Default values for a public registration
        String role = "Patient";
        String status = "Active";

        // Populate Model
        User newUser = new User(username, password, role, email, status);

        // Save via DAO
        UserDAO dao = new UserDAO();
        boolean isRegistered = dao.registerUser(newUser);

        // Redirect based on result
        if (isRegistered) {
            // If successful, send them back to login page with a success message
            response.sendRedirect("login.jsp?register=success");
        } else {
            // If failed (e.g., username already exists)
            response.sendRedirect("register.jsp?error=failed");
        }
    }
}