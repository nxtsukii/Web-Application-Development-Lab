<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        h1 { color: #333; }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .message .icon {
            margin-right: 8px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin-bottom: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .table-responsive {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
        }
        th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-align: left;
        }
        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover { background-color: #f8f9fa; }
        .action-link {
            color: #007bff;
            text-decoration: none;
            margin-right: 10px;
        }
        .delete-link { color: #dc3545; }
        
        form.search-form {
            margin-bottom: 20px;
        }
        input[type="text"] {
            padding: 8px;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            padding: 8px 15px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        a.clear-link {
            margin-left: 10px;
            color: #dc3545;
            text-decoration: none;
        }
        .pagination a {
            margin: 0 5px;
            text-decoration: none;
            color: blue;
        }
        .pagination strong {
            margin: 0 5px;
        }

        @media (max-width: 768px) {
            table {
                font-size: 12px;
            }
            th, td {
                padding: 5px;
            }
        }
    </style>
</head>
<body>
    <h1>📚 Student Management System</h1>

    <% if (request.getParameter("message") != null) { %>
        <div class="message success">
            <span class="icon">✓</span>
            <%= request.getParameter("message") %>
        </div>
    <% } %>
    
    <% if (request.getParameter("error") != null) { %>
        <div class="message error">
            <span class="icon">✗</span>
            <%= request.getParameter("error") %>
        </div>
    <% } %>
    
    <a href="add_student.jsp" class="btn">➕ Add New Student</a>

    <form action="list_students.jsp" method="GET" class="search-form" onsubmit="return submitForm(this)">
        <input type="text" name="keyword" placeholder="Search by name, code, or major..." 
               value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
        <button type="submit">Search</button>
        <a href="list_students.jsp" class="clear-link">Clear</a>
    </form>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    String keyword = request.getParameter("keyword");

    // Pagination variables
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
    int recordsPerPage = 10;
    int offset = (currentPage - 1) * recordsPerPage;
    int totalRecords = 0;
    int totalPages = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/student_management",
            "root",
            "Long28012005"
        );

        // 1) Get total records
        PreparedStatement countStmt = null;
        ResultSet countRs = null;
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                countStmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM students WHERE full_name LIKE ? OR student_code LIKE ? OR major LIKE ?"
                );
                countStmt.setString(1, "%" + keyword + "%");
                countStmt.setString(2, "%" + keyword + "%");
                countStmt.setString(3, "%" + keyword + "%");
            } else {
                countStmt = conn.prepareStatement("SELECT COUNT(*) FROM students");
            }
            countRs = countStmt.executeQuery();
            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
            }
            totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
        } finally {
            if (countRs != null) countRs.close();
            if (countStmt != null) countStmt.close();
        }

        // 2) Get paginated records
        String sql;
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql = "SELECT * FROM students WHERE full_name LIKE ? OR student_code LIKE ? OR major LIKE ? ORDER BY id DESC LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");
            pstmt.setString(3, "%" + keyword + "%");
            pstmt.setInt(4, recordsPerPage);
            pstmt.setInt(5, offset);
        } else {
            sql = "SELECT * FROM students ORDER BY id DESC LIMIT ? OFFSET ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, recordsPerPage);
            pstmt.setInt(2, offset);
        }

        rs = pstmt.executeQuery();
%>
    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Student Code</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Major</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
<%
        int rowNumber = offset + 1;
        while (rs.next()) {
            int id = rs.getInt("id");
            String studentCode = rs.getString("student_code");
            String fullName = rs.getString("full_name");
            String emailVal = rs.getString("email");
            String majorVal = rs.getString("major");
            Timestamp createdAt = rs.getTimestamp("created_at");
%>
                <tr>
                    <td><%= rowNumber++ %></td>
                    <td><%= studentCode %></td>
                    <td><%= fullName %></td>
                    <td><%= emailVal != null ? emailVal : "N/A" %></td>
                    <td><%= majorVal != null ? majorVal : "N/A" %></td>
                    <td><%= createdAt %></td>
                    <td>
                        <a href="edit_student.jsp?id=<%= id %>" class="action-link">✏️ Edit</a>
                        <a href="delete_student.jsp?id=<%= id %>" 
                           class="action-link delete-link"
                           onclick="return confirm('Are you sure?')">🗑️ Delete</a>
                    </td>
                </tr>
<%
        }
%>
            </tbody>
        </table>
    </div>

    <!-- Pagination Links -->
    <div class="pagination">
        <% if (currentPage > 1) { %>
            <a href="list_students.jsp?page=<%= currentPage - 1 %><%= keyword != null ? "&keyword=" + keyword : "" %>">Previous</a>
        <% } %>
        
        <% for (int i = 1; i <= totalPages; i++) { %>
            <% if (i == currentPage) { %>
                <strong><%= i %></strong>
            <% } else { %>
                <a href="list_students.jsp?page=<%= i %><%= keyword != null ? "&keyword=" + keyword : "" %>"><%= i %></a>
            <% } %>
        <% } %>
        
        <% if (currentPage < totalPages) { %>
            <a href="list_students.jsp?page=<%= currentPage + 1 %><%= keyword != null ? "&keyword=" + keyword : "" %>">Next</a>
        <% } %>
    </div>

<%
    } catch (ClassNotFoundException e) {
        out.println("<tr><td colspan='7'>Error: JDBC Driver not found!</td></tr>");
        e.printStackTrace();
    } catch (SQLException e) {
        out.println("<tr><td colspan='7'>Database Error: " + e.getMessage() + "</td></tr>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

<script>
    // Auto-hide messages after 3 seconds
    setTimeout(function() {
        var messages = document.querySelectorAll('.message');
        messages.forEach(function(msg) {
            msg.style.display = 'none';
        });
    }, 3000);

    // Disable submit button after click to prevent double submission
    function submitForm(form) {
        var btn = form.querySelector('button[type="submit"]');
        btn.disabled = true;
        btn.textContent = 'Processing...';
        return true;
    }
</script>
</body>
</html>
