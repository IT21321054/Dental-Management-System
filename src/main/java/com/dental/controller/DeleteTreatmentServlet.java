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

// Map this servlet to the URL used in the delete button href
@WebServlet("/DeleteTreatmentServlet")
public class DeleteTreatmentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Retrieve the treatment ID passed via the URL parameter
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int treatmentId = Integer.parseInt(idParam);

                // Establish connection to the database
                Connection con = DBConnection.getConnection();

                // SQL query to delete the specific record based on its ID
                String sql = "DELETE FROM Treatments WHERE treatment_id = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, treatmentId);

                // Execute the delete operation
                int rowsDeleted = ps.executeUpdate();

                if (rowsDeleted > 0) {
                    System.out.println("✅ Record Deleted Successfully!");
                }

                // Close the database connection
                con.close();

            } catch (Exception e) {
                e.printStackTrace();
                System.out.println("❌ Error deleting record!");
            }
        }

        // Redirect back to the treatments page to show the updated table
        response.sendRedirect("treatments.jsp");
    }
}