<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Senior2Junior Marketplace</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ===== GLOBAL ===== */
body {
    margin:0;
    font-family: 'Poppins', sans-serif;
    background: #f5f7fb;
    color: #1e293b;
}

/* ===== NAVBAR ===== */
.icon-navbar {
    background: white;
    padding: 15px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 10px rgba(0,0,0,0.05);
}

.icons {
    display: flex;
    gap: 25px;
}

.icon-navbar a {
    text-decoration: none;
    color: #334155;
    font-size: 13px;
    font-weight: 500;
    display: flex;
    flex-direction: column;
    align-items: center;
    transition: 0.3s;
}

.icon-navbar a i {
    font-size: 18px;
    color: #6366f1;
}

.icon-navbar a:hover {
    color: #4f46e5;
    transform: translateY(-2px);
}

/* ===== HERO ===== */
h1 {
    text-align: center;
    margin-top: 30px;
    color: #4f46e5;
    font-size: 32px;
}

/* ===== ITEMS GRID ===== */
.items {
    display: flex;
    flex-wrap: wrap;
    gap: 25px;
    justify-content: center;
    padding: 30px;
}

/* ===== ITEM CARD ===== */
.item-card {
    background: white;
    width: 240px;
    border-radius: 16px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    overflow: hidden;
    text-align: center;
    transition: transform 0.3s, box-shadow 0.3s;
}

.item-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(0,0,0,0.15);
}

.item-card img {
    width: 100%;
    height: 160px;
    object-fit: cover;
    border-bottom: 1px solid #e2e8f0;
}

.item-card h3 {
    margin: 12px 0 6px;
    font-size: 18px;
    color: #1e293b;
}

.item-card p {
    font-size: 14px;
    color: #475569;
    margin: 4px 0;
}

.delete-btn {
    background: #ef4444;
    color: white;
    border: none;
    padding: 8px 14px;
    cursor: pointer;
    border-radius: 8px;
    margin: 10px 0 12px;
    font-weight: 500;
    transition: background 0.3s, transform 0.2s;
}

.delete-btn:hover {
    background: #dc2626;
    transform: translateY(-2px);
}

/* ===== RESPONSIVE ===== */
@media(max-width:768px){
    .items {
        flex-direction: column;
        align-items: center;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="icon-navbar">
    <div class="icons">
        <a href="home.jsp"><i class="fa-solid fa-house"></i><span>Home</span></a>
        <a href="Senior2Junior.jsp"><i class="fa-solid fa-cart-shopping"></i><span>Buy Item</span></a>
        <a href="sellitem.jsp"><i class="fa-solid fa-plus"></i><span>Sell Item</span></a>
    </div>
</div>

<h1>Senior2Junior Marketplace</h1>

<div class="items">
<%
try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/marketplace",
        "root",
        "abc123"
    );
    Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("SELECT * FROM market_items");
    while(rs.next()){
%>
    <div class="item-card">
        <img src="<%=rs.getString("image_path")%>" alt="Item Image">
        <h3><%=rs.getString("item_name")%></h3>
        <p><b>Price:</b> ₹<%=rs.getString("price")%></p>
        <p><b>Seller:</b> <%=rs.getString("seller_name")%></p>
        <p><b>Phone:</b> <%=rs.getString("phone")%></p>
        <a href="deleteItem2.jsp?id=<%=rs.getInt("id")%>">
            <button class="delete-btn">Delete</button>
        </a>
    </div>
<%
    }
    con.close();
}catch(Exception e){
    out.println("<p style='color:red;text-align:center;'>"+e+"</p>");
}
%>
</div>

</body>
</html>