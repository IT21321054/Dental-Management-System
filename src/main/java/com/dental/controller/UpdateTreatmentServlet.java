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

// Map this servlet to handle the update form submission
@WebServlet("/UpdateTreatmentServlet")
public class UpdateTreatmentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve the updated data from the form
        int treatmentId = Integer.parseInt(request.getParameter("treatmentId"));
        int patientId = Integer.parseInt(request.getParameter("patientId"));
        String treatmentDate = request.getParameter("treatmentDate");
        String treatmentType = request.getParameter("treatmentType");
        double cost = Double.parseDouble(request.getParameter("cost"));
        String notes = request.getParameter("notes");

        try {
            // Establish connection to the database
            Connection con = DBConnection.getConnection();

            // SQL query to update the specific record
            String sql = "UPDATE Treatments SET patient_id=?, treatment_date=?, treatment_type=?, cost=?, notes=? WHERE treatment_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            // Set parameters in the exact order of the SQL query question marks
            ps.setInt(1, patientId);
            ps.setString(2, treatmentDate);
            ps.setString(3, treatmentType);
            ps.setDouble(4, cost);
            ps.setString(5, notes);
            ps.setInt(6, treatmentId); // The ID used in the WHERE clause

            // Execute the update
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("✅ Record Updated Successfully!");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("❌ Error updating record!");
        }

        // Redirect back to the main treatments page to view the updated table
        response.sendRedirect("treatments.jsp");
    }
}