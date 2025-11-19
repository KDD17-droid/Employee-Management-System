<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Registration System</title>
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
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.container {
	background: white;
	border-radius: 20px;
	box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
	overflow: hidden;
	max-width: 450px;
	width: 100%;
}

.header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 40px 30px;
	text-align: center;
}

.header h1 {
	font-size: 28px;
	margin-bottom: 10px;
}

.header p {
	font-size: 14px;
	opacity: 0.9;
}

.form-container {
	padding: 40px 30px;
}

.form-group {
	margin-bottom: 25px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	color: #333;
	font-weight: 500;
	font-size: 14px;
}

.form-group input, .form-group select {
	width: 100%;
	padding: 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.3s;
}

.form-group input:focus, .form-group select:focus {
	outline: none;
	border-color: #667eea;
	box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.btn {
	width: 100%;
	padding: 14px;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 16px;
	font-weight: 600;
	cursor: pointer;
	transition: transform 0.2s;
}

.btn:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
}

.switch-link {
	text-align: center;
	margin-top: 20px;
	font-size: 14px;
	color: #666;
}

.switch-link a {
	color: #667eea;
	text-decoration: none;
	font-weight: 600;
}

.switch-link a:hover {
	text-decoration: underline;
}

.error-message {
	background: #fee;
	color: #c33;
	padding: 12px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-size: 14px;
	border-left: 4px solid #c33;
}

.success-message {
	background: #efe;
	color: #3c3;
	padding: 12px;
	border-radius: 8px;
	margin-bottom: 20px;
	font-size: 14px;
	border-left: 4px solid #3c3;
}
</style>
</head>
<body>
	<div class="container">
		<div class="header">
			<h1>Welcome</h1>
			<p>Employee Management System</p>
		</div>
		<div class="form-container">
			<h2 style="text-align: center; margin-bottom: 30px; color: #333;">Registration</h2>

			<% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null) {
            %>
			<div class="error-message">
				<%= error.equals("exists") ? "Employee ID already exists!" : 
                        error.equals("invalid") ? "Please fill all fields correctly!" : 
                        "Registration failed. Please try again." %>
			</div>
			<% } %>

			<% if (success != null && success.equals("true")) { %>
			<div class="success-message">Registration successful! Please
				login.</div>
			<% } %>

			<form action="RegistrationProcess.jsp" method="post">
				<div class="form-group">
					<label for="EmployeeID">Employee ID *</label> <input type="text"
						id="EmployeeID" name="EmployeeID" required pattern="[A-Za-z0-9]+"
						title="Only letters and numbers allowed">
				</div>

				<div class="form-group">
					<label for="Name">Full Name *</label> <input type="text" id="Name"
						name="Name" required>
				</div>

				<div class="form-group">
					<label for="Email">Email *</label> <input type="Email" id="Email"
						name="Email" required>
				</div>

				<div class="form-group">
					<label for="Phone">Phone Number *</label> <input type="tel"
						id="Phone" name="Phone" required pattern="[0-9]{10}"
						title="Please enter 10 digit phone number">
				</div>

				<div class="form-group">
					<label for="Department">Department *</label> <select
						id="Department" name="Department" required>
						<option value="">Select Department</option>
						<option value="IT">IT</option>
						<option value="HR">HR</option>
						<option value="Finance">Finance</option>
						<option value="Marketing">Marketing</option>
						<option value="Operations">Operations</option>
					</select>
				</div>

				<div class="form-group">
					<label for="Password">Password *</label> <input type="Password"
						id="Password" name="Password" required minlength="6"
						title="Password must be at least 6 characters">
				</div>

				<button type="submit" class="btn">Register</button>
			</form>

			<div class="switch-link">
				Already have an account? <a href="Login.jsp">Login here</a>
			</div>
		</div>
	</div>
</body>
</html>