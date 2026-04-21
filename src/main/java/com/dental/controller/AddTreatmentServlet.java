package com.dental.controller;

import com.dental.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

// The name defined here must match the action attribute in the form of treatments.jsp
@WebServlet("/AddTreatmentServlet")
public class AddTreatmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve data submitted from the HTML form
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String treatmentDate = request.getParameter("treatmentDate");
        String treatmentType = request.getParameter("treatmentType");
        double cost = Double.parseDouble(request.getParameter("cost"));
        String notes = request.getParameter("notes");

        try {
            // Establish connection to the database
            Connection con = DBConnection.getConnection();

            // SQL query to insert a new treatment record
            String sql = "INSERT INTO Treatments (patient_id, treatment_date, treatment_type, cost, notes) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setInt(1, patientId);
            ps.setString(2, treatmentDate);
            ps.setString(3, treatmentType);
            ps.setDouble(4, cost);
            ps.setString(5, notes);

            // Execute the query and get the number of affected rows
            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("✅ Record Saved Successfully!");
                // Redirect back to the form page after a successful save operation
                response.sendRedirect("treatments.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error saving record!");
        }
    }
}