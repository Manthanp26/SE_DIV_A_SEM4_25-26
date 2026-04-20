<%@ page import="java.sql.*" %>
<%
String user = (String) session.getAttribute("un");
if (user == null) {
    response.sendRedirect("Login.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Returned Items</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>

/* ===== PREMIUM BLACK GOLD THEME ===== */
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: #0f172a;
    color: #f1f5f9;
}

/* NAVBAR */
.navbar {
    background: #020617;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #d4af37;
}

.navbar h2 {
    color: #d4af37;
    font-weight: bold;
}

.navbar a {
    color: #e2e8f0;
    text-decoration: none;
    margin-left: 20px;
    transition: 0.3s;
}

.navbar a:hover {
    color: #d4af37;
}

/* HEADER */
.header {
    text-align: center;
    padding: 3rem 1rem;
}

.header h1 {
    font-size: 2.8rem;
    color: #d4af37;
}

/* GRID */
.container {
    padding: 2rem;
}

.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 25px;
}

/* CARD */
.card {
    background: #020617;
    border-radius: 15px;
    overflow: hidden;
    border: 1px solid #1e293b;
    transition: 0.4s;
}

.card:hover {
    transform: translateY(-8px);
    box-shadow: 0 0 20px rgba(212,175,55,0.3);
}

.card img {
    width: 100%;
    height: 200px;
    object-fit: cover;
}

.card-content {
    padding: 15px;
}

.card-content h3 {
    color: #f8fafc;
}

.card-content p {
    color: #cbd5e1;
    font-size: 0.9rem;
}

/* DELETE BUTTON */
.delete-btn {
    display: inline-block;
    margin-top: 10px;
    padding: 8px 14px;
    background: #dc2626;
    color: white;
    text-decoration: none;
    border-radius: 8px;
    transition: 0.3s;
}

.delete-btn:hover {
    background: #b91c1c;
}

/* FOOTER */
footer {
    text-align: center;
    padding: 20px;
    border-top: 1px solid #1e293b;
    margin-top: 40px;
    color: #94a3b8;
}

</style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>APSiT Found It</h2>
    <div>
        <a href="index.jsp"><i class="fa fa-home"></i> Home</a>
        <a href="ReportItem.jsp">Report</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<!-- HEADER -->
<div class="header">
    <h1>Returned Items</h1>
</div>

<!-- DATA -->
<div class="container">
<div class="grid">

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/users_10jan26", "root", "abc123"
);

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM items WHERE status='returned'"
);

ResultSet rs = ps.executeQuery();

while(rs.next()) {
    String img = rs.getString("image_path");
    if(img == null || img.trim().equals("")) {
        img = "uploads/default.png";
    }
%>

<div class="card">
    <img src="<%= img %>">

    <div class="card-content">
        <h3><%= rs.getString("item_name") %></h3>

        <p><strong>Returned To:</strong> <%= rs.getString("collect_from") %></p>

        <p><strong>Location:</strong> <%= rs.getString("location") %></p>

        <a href="deleteItem.jsp?id=<%= rs.getInt("id") %>" class="delete-btn">
            Delete Record
        </a>
    </div>
</div>

<%
}
con.close();
%>

</div>
</div>

<!-- FOOTER -->
<footer>
    © 2026 APSIT Lost & Found | Admin Panel
</footer>

</body>
</html>