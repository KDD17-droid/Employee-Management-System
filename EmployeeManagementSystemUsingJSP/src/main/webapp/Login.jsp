<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    // Check if already logged in
    if (session.getAttribute("EmployeeID") != null) {
        response.sendRedirect("Profile.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Login</title>
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

.form-group input {
	width: 100%;
	padding: 12px 15px;
	border: 2px solid #e0e0e0;
	border-radius: 8px;
	font-size: 14px;
	transition: all 0.3s;
}

.form-group input:focus {
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
			<h1>Welcome Back</h1>
			<p>Login to your account</p>
		</div>
		<div class="form-container">
			<h2 style="text-align: center; margin-bottom: 30px; color: #333;">Login</h2>

			<% 
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                String logout = request.getParameter("logout");
                
                if (error != null) {
            %>
			<div class="error-message">
				<%= error.equals("invalid") ? "Invalid Employee ID or Password!" : 
                        error.equals("session") ? "Please login to continue!" : 
                        "Login failed. Please try again." %>
			</div>
			<% } %>

			<% if (success != null && success.equals("true")) { %>
			<div class="success-message">Registration successful! Please
				login with your credentials.</div>
			<% } %>

			<% if (logout != null && logout.equals("true")) { %>
			<div class="success-message">You have been logged out
				successfully!</div>
			<% } %>

			<form action="LoginProcess.jsp" method="post">
				<div class="form-group">
					<label for="EmployeeID">Employee ID</label> <input type="text"
						id="EmployeeID" name="EmployeeID" required>
				</div>

				<div class="form-group">
					<label for="Password">Password</label> <input type="Password"
						id="Password" name="Password" required>
				</div>

				<button type="submit" class="btn">Login</button>
			</form>

			<div class="switch-link">
				Don't have an account? <a href="EmployeeRegistrationSystemIndex.jsp">Register
					here</a>
			</div>
		</div>
	</div>
</body>
</html>