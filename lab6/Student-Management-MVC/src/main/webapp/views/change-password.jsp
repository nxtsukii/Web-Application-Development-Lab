<%-- 
    Document   : change-password.jsp
    Created on : Nov 27, 2025, 8:22:38 PM
    Author     : Admin
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>

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
            background: white;
            padding: 15px 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        .navbar-right {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .btn-nav, .btn-logout, .btn-change {
            padding: 8px 14px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            transition: 0.3s;
        }

        .btn-nav:hover, .btn-change:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.4);
        }

        .btn-logout {
            background: #dc3545;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 35px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            margin-bottom: 25px;
            color: #666;
        }

        .message, .error {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 6px;
            font-weight: 500;
        }

        .message {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }

        form input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            font-size: 16px;
            border-radius: 6px;
            border: 2px solid #ddd;
        }

        button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            color: white;
            border: none;
            border-radius: 6px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102,126,234,0.5);
        }
        
        .btn-nav {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .btn-nav:hover {
            background: #c0392b;
        }
        
        .btn-logout {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .btn-logout:hover {
            background: #c0392b;
        }
        
        .btn-changepass {
            padding: 8px 20px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background 0.3s;
        }
        
        .btn-changepass:hover {
            background: #c0392b;
        }
    </style>
</head>

<body>

    <!-- NAVBAR -->
    <div class="navbar">
        <h2>📚 Student Management System</h2>

        <div class="navbar-right">
            <span>Welcome, ${sessionScope.fullName}</span>

            <a href="dashboard" class="btn-nav">Dashboard</a>
            <a href="student?action=list" class="btn-nav">Students</a>
            <a href="change-password" class="btn-changepass">Change Password</a>
            <a href="logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1>Change Password</h1>
        <p class="subtitle">Keep your account secure by updating your password</p>

        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="message">✅ ${message}</div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="error">❌ ${error}</div>
        </c:if>

        <!-- FORM -->
        <form action="change-password" method="post">
            <input type="password" name="currentPassword" placeholder="Current Password" required>
            <input type="password" name="newPassword" placeholder="New Password (min 8 characters)" required>
            <input type="password" name="confirmPassword" placeholder="Confirm New Password" required>

            <button type="submit">Update Password</button>
        </form>
    </div>

</body>
</html>

