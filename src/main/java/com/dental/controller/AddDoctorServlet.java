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
// CONTROLLER: AddDoctorServlet
// Handles the form submission to register a new dentist
// =======================================================================
@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String docName = request.getParameter("docName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Hardcoding role as 'Dentist' and status as 'Active' for this specific form
        String role = "Dentist";
        String status = "Active";

        User newDoctor = new User(docName, password, role, email, status);

        UserDAO dao = new UserDAO();
        boolean isAdded = dao.addDoctor(newDoctor);

        if (isAdded) {
            response.sendRedirect("doctors.jsp?status=success");
        } else {
            response.sendRedirect("doctors.jsp?status=error");
        }
    }
}