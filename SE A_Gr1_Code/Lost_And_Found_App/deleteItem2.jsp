<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Item APSiT Found It</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f1f5f9, #e2e8f0);
            color: #0f172a;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 2.5rem 3rem;
            border-radius: 1rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            max-width: 500px;
            text-align: center;
        }
        h1 { color: #5b21b6; margin-bottom: 1.5rem; }
        .success { color: #15803d; font-size: 1.2rem; margin: 1.5rem 0; }
        .error   { color: #dc2626; font-size: 1.2rem; margin: 1.5rem 0; }
        .btn {
            display: inline-block;
            padding: 0.9rem 2rem;
            background: #5b21b6;
            color: white;
            text-decoration: none;
            border-radius: 0.6rem;
            margin-top: 1.5rem;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn:hover { background: #4c1d95; transform: translateY(-2px); }
    </style>
</head>
<body>

<div class="container">
<%
    String currentUser = (String) session.getAttribute("un");
    if (currentUser == null) {
        out.println("<h1>Please log in first</h1>");
        out.println("<p><a href='Login.jsp' class='btn'>Go to Login</a></p>");
        return;
    }

    String idStr = request.getParameter("id");
    if (idStr == null || idStr.trim().isEmpty()) {
        out.println("<h1>Invalid request</h1>");
        out.println("<p><a href='Senior2Junior.jsp' class='btn'>Back to Marketplace</a></p>");
        return;
    }

    int itemId = Integer.parseInt(idStr);

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/marketplace", "root", "abc123"
        );

        // Check ownership
        PreparedStatement check = con.prepareStatement(
            "SELECT seller_email FROM market_items WHERE id = ?"
        );
        check.setInt(1, itemId);
        ResultSet rs = check.executeQuery();

        if (rs.next()) {
            String sellerEmail = rs.getString("seller_email");
            if (!currentUser.equalsIgnoreCase(sellerEmail)) {
                out.println("<h1>Access Denied</h1>");
                out.println("<p class='error'>You are not the owner of this item.</p>");
                out.println("<p><a href='Senior2Junior.jsp' class='btn'>Back to Marketplace</a></p>");
                con.close();
                return;
            }
        } else {
            out.println("<h1>Item Not Found</h1>");
            out.println("<p class='error'>This item no longer exists.</p>");
            out.println("<p><a href='Senior2Junior.jsp' class='btn'>Back to Marketplace</a></p>");
            con.close();
            return;
        }

        // Delete item
        PreparedStatement ps = con.prepareStatement("DELETE FROM market_items WHERE id = ?");
        ps.setInt(1, itemId);
        int rows = ps.executeUpdate();
        con.close();

        if (rows > 0) {
%>
            <h1>Success!</h1>
            <p class="success">Item deleted successfully.</p>
            <p>Redirecting back to marketplace...</p>
            <script>
                setTimeout(() => {
                    window.location.href = "Senior2Junior.jsp";
                }, 1800);
            </script>
<%
        } else {
            out.println("<h1>Error</h1>");
            out.println("<p class='error'>Could not delete item.</p>");
        }
    } catch (Exception e) {
        out.println("<h1>Error</h1>");
        out.println("<p class='error'>" + e.getMessage() + "</p>");
    }
%>
    <p><a href="Senior2Junior.jsp" class="btn">Go to Marketplace</a></p>
</div>

</body>
</html>