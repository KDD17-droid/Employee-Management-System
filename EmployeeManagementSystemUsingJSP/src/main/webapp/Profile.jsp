<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.DBConnection.DBConnection" %>

<%
    // Check if user is logged in
    String EmployeeID = (String) session.getAttribute("EmployeeID");
    if (EmployeeID == null) {
        response.sendRedirect("Login.jsp?error=session");
        return;
    }

    // Variables to hold profile data
    String Name = null, Email = null, Phone = null, Department = null, RegistrationDate = null;

    // JDBC: Fetch user details
    try {
        Connection con = DBConnection.getConnection();
        String sql = "SELECT * FROM employees WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, EmployeeID);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Name = rs.getString("name");
            Email = rs.getString("email");
            Phone = rs.getString("phone");
            Department = rs.getString("department");
            RegistrationDate = rs.getString("registration_date");
        } else {
            response.sendRedirect("Login.jsp?error=notfound");
            return;
        }
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Profile</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
	padding: 20px;
}

.navbar {
	background: rgba(255, 255, 255, 0.95);
	padding: 15px 30px;
	border-radius: 15px;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	max-width: 1200px;
	margin: 0 auto 30px;
}

.navbar h2 {
	color: #667eea;
	font-size: 24px;
}

.logout-btn {
	padding: 10px 25px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: 600;
	text-decoration: none;
	transition: transform 0.2s;
}

.logout-btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
}

.container {
	max-width: 900px;
	margin: 0 auto;
}

.profile-card {
	background: white;
	border-radius: 20px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
	overflow: hidden;
}

.profile-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 50px 30px;
	text-align: center;
	color: white;
}

.profile-avatar {
	width: 120px;
	height: 120px;
	background: white;
	border-radius: 50%;
	margin: 0 auto 20px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 48px;
	font-weight: bold;
	color: #667eea;
	box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
}

.profile-name {
	font-size: 32px;
	font-weight: bold;
	margin-bottom: 10px;
}

.profile-id {
	font-size: 16px;
	opacity: 0.9;
}

.profile-body {
	padding: 40px 30px;
}

.info-section {
	margin-bottom: 30px;
}

.info-section h3 {
	color: #333;
	font-size: 20px;
	margin-bottom: 20px;
	padding-bottom: 10px;
	border-bottom: 2px solid #667eea;
}

.info-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	gap: 20px;
}

.info-item {
	background: #f8f9fa;
	padding: 20px;
	border-radius: 12px;
	border-left: 4px solid #667eea;
}

.info-label {
	font-size: 12px;
	color: #666;
	text-transform: uppercase;
	letter-spacing: 1px;
	margin-bottom: 8px;
	font-weight: 600;
}

.info-value {
	font-size: 16px;
	color: #333;
	font-weight: 500;
}

.status-badge {
	display: inline-block;
	padding: 6px 15px;
	background: #4caf50;
	color: white;
	border-radius: 20px;
	font-size: 14px;
	font-weight: 600;
}

.actions {
	display: flex;
	gap: 15px;
	margin-top: 30px;
	flex-wrap: wrap;
}

.btn {
	padding: 12px 30px;
	border: none;
	border-radius: 8px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s;
	text-decoration: none;
	display: inline-block;
}

.btn-primary {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
}

.btn-primary:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
}

.btn-secondary {
	background: #e0e0e0;
	color: #333;
}

.btn-secondary:hover {
	background: #d0d0d0;
}

@media ( max-width : 768px) {
	.navbar {
		flex-direction: column;
		gap: 15px;
	}
	.info-grid {
		grid-template-columns: 1fr;
	}
}
</style>
</head>
<body>
	<div class="navbar">
		<h2>Employee Portal</h2>
		<a href="Logout.jsp" class="logout-btn">Logout</a>
	</div>

	<div class="container">
		<div class="profile-card">
			<div class="profile-header">
				<div class="profile-avatar">
					<%=Name != null ? Name.substring(0, 1).toUpperCase() : "E"%>
				</div>
				<div class="profile-name"><%=Name%></div>
				<div class="profile-id">
					Employee ID:
					<%=EmployeeID%></div>
			</div>

			<div class="profile-body">
				<div class="info-section">
					<h3>Personal Information</h3>
					<div class="info-grid">
						<div class="info-item">
							<div class="info-label">Full Name</div>
							<div class="info-value"><%=Name%></div>
						</div>
						<div class="info-item">
							<div class="info-label">Employee ID</div>
							<div class="info-value"><%=EmployeeID%></div>
						</div>
						<div class="info-item">
							<div class="info-label">Email Address</div>
							<div class="info-value"><%=Email%></div>
						</div>
						<div class="info-item">
							<div class="info-label">Phone Number</div>
							<div class="info-value"><%=Phone%></div>
						</div>
					</div>
				</div>
				<div class="info-section">
					<h3>Employment Details</h3>
					<div class="info-grid">
						<div class="info-item">
							<div class="info-label">Department</div>
							<div class="info-value"><%=Department%></div>
						</div>
						<div class="info-item">
							<div class="info-label">Status</div>
							<div class="info-value">
								<span class="status-badge">Active</span>
							</div>
						</div>
						<div class="info-item">
							<div class="info-label">Registration Date</div>
							<div class="info-value">
								<%=RegistrationDate != null ? RegistrationDate.substring(0, 10) : "N/A"%>
							</div>
						</div>
					</div>
				</div>

				<div class="actions">
					<button class="btn btn-primary"
						onclick="alert('Edit functionality coming soon!')">Edit Profile</button>
					<button class="btn btn-secondary" onclick="window.print()">Print Profile</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
