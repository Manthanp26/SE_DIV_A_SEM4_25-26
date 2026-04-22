<%
String user = (String) session.getAttribute("un");
if (user == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It Senior2Junior Marketplace</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #5b21b6;
            --primary-light: #7c3aed;
            --primary-dark: #4c1d95;
            --accent: #ec4899;
            --bg: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.78);
            --text: #0f172a;
            --text-muted: #475569;
            --border: rgba(226, 232, 240, 0.78);
            --shadow: 0 12px 32px -10px rgba(91, 33, 182, 0.18);
            --shadow-hover: 0 28px 60px -12px rgba(91, 33, 182, 0.32);
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body { font-family:'Inter',sans-serif; background:linear-gradient(135deg,#f1f5f9,#e2e8f0); color:var(--text); min-height:100vh; }
        .navbar { position:sticky; top:0; z-index:1000; background:rgba(255,255,255,0.84); backdrop-filter:blur(18px); border-bottom:1px solid var(--border); padding:1rem 2.5rem; display:flex; justify-content:space-between; align-items:center; }
        .nav-brand { font-family:'Playfair Display',serif; font-size:1.75rem; font-weight:700; color:var(--primary); }
        .nav-links { display:flex; gap:2.4rem; flex-wrap:wrap; justify-content:center; }
        .nav-links a { color:var(--text-muted); text-decoration:none; font-weight:500; font-size:0.97rem; display:flex; align-items:center; gap:0.6rem; transition:all 0.3s; }
        .nav-links a:hover { color:var(--primary); transform:translateY(-3px); }
        .page-header { text-align:center; padding:4rem 1rem 2.5rem; }
        .page-header h1 { font-family:'Playfair Display',serif; font-size:clamp(2.4rem,6.5vw,4.2rem); font-weight:700; color:var(--primary-dark); }
        .items { display:grid; grid-template-columns:repeat(auto-fill,minmax(280px,1fr)); gap:2rem; max-width:1380px; margin:0 auto; padding:0 1.5rem 6rem; }
        .item-card { background:var(--card-bg); backdrop-filter:blur(14px); border:1px solid var(--border); border-radius:1.5rem; overflow:hidden; box-shadow:var(--shadow); transition:all 0.4s; }
        .item-card:hover { transform:translateY(-8px); box-shadow:var(--shadow-hover); }
        .item-card img { width:100%; height:180px; object-fit:cover; }
        .item-content { padding:1.3rem 1.4rem 1.8rem; }
        .item-card h3 { font-size:1.28rem; font-weight:600; margin-bottom:0.7rem; }
        .price { font-size:1.15rem; font-weight:700; color:var(--primary); margin:0.7rem 0 1rem; }
        .delete-btn { display:block; width:100%; padding:0.8rem; margin:1rem 0 0.6rem; background:linear-gradient(135deg,#ef4444,#dc2626); color:white; border:none; border-radius:0.9rem; font-weight:600; text-align:center; text-decoration:none; transition:all 0.3s; }
        .delete-btn:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(239,68,68,0.4); }
        footer { background:linear-gradient(135deg,#0f172a,#1e293b); color:#cbd5e1; text-align:center; padding:4rem 1.5rem 3rem; margin-top:5rem; }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-brand">APSiT Found It</div>
    <div class="nav-links">
        <a href="home.jsp"><i class="fa-solid fa-house"></i>Home</a>
        <a href="Senior2Junior.jsp" class="active"><i class="fa-solid fa-cart-shopping"></i>Marketplace</a>
        <a href="sellitem.jsp"><i class="fa-solid fa-plus"></i>Sell Item</a>
    </div>
</div>

<div class="page-header">
    <h1>Senior2Junior Marketplace</h1>
    <p>Buy & sell items within the APSIT community</p>
</div>

<div class="items">
<%
String currentUser = (String) session.getAttribute("un");

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/marketplace", "root", "abc123");
    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM market_items ORDER BY id DESC");
    int index = 0;
    while (rs.next()) {
        String sellerEmail = rs.getString("seller_email");
        boolean isOwner = (currentUser != null && currentUser.equalsIgnoreCase(sellerEmail));
%>
    <div class="item-card">
        <img src="<%= rs.getString("image_path") %>" alt="<%= rs.getString("item_name") %>">
        <div class="item-content">
            <h3><%= rs.getString("item_name") %></h3>
            <p class="price">Price <%= rs.getString("price") %></p>
            <p><strong>Seller:</strong> <%= rs.getString("seller_name") %></p>
            <p><strong>Phone:</strong> <%= rs.getString("phone") %></p>

            <% if (isOwner) { %>
                <a href="deleteItem2.jsp?id=<%= rs.getInt("id") %>" class="delete-btn">Delete Listing</a>
            <% } %>
        </div>
    </div>
<%
    }
    con.close();
} catch (Exception e) {
    out.println("<p style='color:#dc2626; text-align:center; padding:3rem;'>Error: " + e.getMessage() + "</p>");
}
%>
</div>

<footer>
    <p>@2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>