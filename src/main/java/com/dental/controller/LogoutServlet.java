package com.dental.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// =======================================================================
// CONTROLLER: LogoutServlet
// Handles securely logging out the user by destroying their session
// =======================================================================
@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch the current session, but don't create a new one if it doesn't exist (false)
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Destroy the session and clear all saved data
            session.invalidate();
        }

        // Redirect back to the login page
        response.sendRedirect("login.jsp?logout=success");
    }
}