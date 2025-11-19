<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnection.DBConnection" %>

<%
String EmployeeID = request.getParameter("EmployeeID");
String Password = request.getParameter("Password");

// Validate inputs
if (EmployeeID == null || Password == null ||
    EmployeeID.trim().isEmpty() || Password.trim().isEmpty()) {
    response.sendRedirect("Login.jsp?error=invalid");
    return;
}

Connection con = DBConnection.getConnection();

try {
    // Fetch user from database
    String sql = "SELECT * FROM Employees WHERE ID = ? AND Password = ?";
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, EmployeeID);
    ps.setString(2, Password);

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        // Create session attributes
        session.setAttribute("EmployeeID", rs.getString("id"));
        session.setAttribute("Name", rs.getString("name"));
        session.setAttribute("Email", rs.getString("email"));
        session.setAttribute("Phone", rs.getString("phone"));
        session.setAttribute("Department", rs.getString("department"));
        session.setAttribute("RegistrationDate", rs.getString("registration_date"));

        response.sendRedirect("Profile.jsp");
    } else {
        response.sendRedirect("Login.jsp?error=invalid");
    }

} catch (Exception e) {
    out.println("Error: " + e);
}
%>
