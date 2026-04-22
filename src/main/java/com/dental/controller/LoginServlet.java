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
// Handles user authentication and session creation
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

                // Redirect to the main dashboard / home page
                response.sendRedirect("index.jsp");
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