package com.dental.controller;

import com.dental.dao.UserDAO;
import com.dental.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// =======================================================================
// CONTROLLER: LoginServlet
// Handles user authentication, session creation, and role-based redirection
// =======================================================================
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User loggedInUser = dao.authenticateUser(user, pass);

        if (loggedInUser != null) {
            // Check if the user's account is active
            if ("Active".equalsIgnoreCase(loggedInUser.getStatus())) {

                // Login successful: Create a session to remember the user
                HttpSession session = request.getSession();
                session.setAttribute("activeUser", loggedInUser);

                // --- ROLE-BASED REDIRECTION LOGIC ---
                // Get the role of the user (Admin, Dentist, or Patient)
                String userRole = loggedInUser.getRole();

                if ("Admin".equalsIgnoreCase(userRole) || "Dentist".equalsIgnoreCase(userRole)) {
                    // If the user is an Admin or Dentist, send them to the Dashboard
                    response.sendRedirect("dashboard.jsp");
                } else {
                    // If the user is a normal Patient, send them to the regular Home Page
                    response.sendRedirect("index.jsp");
                }

            } else {
                // Account is inactive
                response.sendRedirect("login.jsp?error=inactive");
            }
        } else {
            // Login failed: Invalid credentials
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}