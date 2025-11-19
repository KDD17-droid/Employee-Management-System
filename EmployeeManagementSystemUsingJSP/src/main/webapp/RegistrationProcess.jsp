<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnection.DBConnection" %>

<%
String EmployeeID = request.getParameter("EmployeeID");
String Name = request.getParameter("Name");
String Email = request.getParameter("Email");
String Phone = request.getParameter("Phone");
String Department = request.getParameter("Department");
String Password = request.getParameter("Password");

// Validation
if (EmployeeID == null || Name == null || Email == null || Phone == null || Department == null || Password == null
    || EmployeeID.trim().isEmpty() || Name.trim().isEmpty() || Email.trim().isEmpty()
    || Phone.trim().isEmpty() || Department.trim().isEmpty() || Password.trim().isEmpty()) {

    response.sendRedirect("EmployeeRegistrationSystemIndex.jsp?error=invalid");
    return;
}

Connection con = DBConnection.getConnection();

try {
    // Insert SQL Query
    String sql = "INSERT INTO employees (id, name, email, phone, department, password, registration_date) VALUES (?, ?, ?, ?, ?, ?, NOW())";

    PreparedStatement ps = con.prepareStatement(sql);

    ps.setString(1, EmployeeID);
    ps.setString(2, Name);
    ps.setString(3, Email);
    ps.setString(4, Phone);
    ps.setString(5, Department);
    ps.setString(6, Password);

    int rows = ps.executeUpdate();

    if (rows > 0) {
        response.sendRedirect("Login.jsp?success=true");
    } else {
        response.sendRedirect("EmployeeRegistrationSystemIndex.jsp?error=insertfail");
    }

} catch (SQLIntegrityConstraintViolationException e) {
    // Duplicate entry — EmployeeID OR Email already exists
    response.sendRedirect("EmployeeRegistrationSystemIndex.jsp?error=exists");
} catch (Exception e) {
    out.println("Error: " + e);
}
%>
