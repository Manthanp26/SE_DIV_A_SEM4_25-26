<%@ page import="java.sql.*" %>
<%
String user = (String) session.getAttribute("un");
if (user == null || !user.equals("Admin")) {
    response.sendRedirect("home.jsp");
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #5b21b6;
            --primary-light: #7c3aed;
            --primary-dark: #4c1d95;
            --accent: #ec4899;
            --bg: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.76);
            --text: #0f172a;
            --text-muted: #475569;
            --border: rgba(226, 232, 240, 0.78);
            --shadow: 0 12px 32px -10px rgba(91, 33, 182, 0.18);
            --shadow-hover: 0 28px 60px -12px rgba(91, 33, 182, 0.32);
            --depth: 35px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            color: var(--text);
            min-height: 100vh;
            line-height: 1.6;
        }

        /* ==================== NAVBAR ==================== */
        .navbar {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.84);
            backdrop-filter: blur(18px);
            border-bottom: 1px solid var(--border);
            padding: 1rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
        }

        .nav-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--primary);
            letter-spacing: -0.6px;
            transition: transform 0.35s ease;
        }

        .nav-brand:hover {
            transform: scale(1.06) translateZ(10px);
        }

        .nav-links {
            display: flex;
            gap: 2.2rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .nav-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.97rem;
            display: flex;
            align-items: center;
            gap: 0.6rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            transform: translateZ(0);
        }

        .nav-links a:hover {
            color: var(--primary);
            transform: translateY(-3px) translateZ(12px) scale(1.08);
            text-shadow: 0 2px 8px rgba(91, 33, 182, 0.25);
        }

        .nav-links i {
            font-size: 1.3rem;
            transition: transform 0.35s ease;
        }

        .nav-links a:hover i {
            transform: rotate(12deg) scale(1.15);
        }

        /* ==================== HERO ==================== */
        .hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            text-align: center;
            padding: 7.5rem 2rem 6rem;
            position: relative;
            overflow: hidden;
            border-bottom-left-radius: 4rem;
            border-bottom-right-radius: 4rem;
            transform-style: preserve-3d;
            perspective: 1200px;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 15% 85%, rgba(255,255,255,0.22) 0%, transparent 65%);
            pointer-events: none;
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.8rem, 8.5vw, 5.4rem);
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -1.3px;
            text-shadow: 0 6px 24px rgba(0,0,0,0.45);
            transform: translateZ(40px);
        }

        .hero p {
            font-size: clamp(1.1rem, 3vw, 1.4rem);
            max-width: 680px;
            margin: 0 auto;
            opacity: 0.94;
            transform: translateZ(20px);
        }

        /* ==================== SECTION ==================== */
        .section {
            padding: 5.5rem 1.5rem 6.5rem;
            max-width: 1380px;
            margin: 0 auto;
            perspective: 1400px;
        }

        .section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.9rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 3.8rem;
            color: var(--primary-dark);
            position: relative;
            transform: translateZ(30px);
        }

        .section h2::after {
            content: '';
            position: absolute;
            bottom: -1rem;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 6px;
            background: linear-gradient(to right, var(--primary), var(--accent));
            border-radius: 4px;
        }

        /* ==================== ITEM GRID ==================== */
        .items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2.4rem;
        }

        .item-card-wrapper {
            perspective: 1600px;
        }

        .item-card {
            background: var(--card-bg);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 1.6rem;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.55s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform-style: preserve-3d;
            position: relative;
            opacity: 0;
            transform: translateY(40px) translateZ(-80px);
            animation: cardEntrance 0.9s forwards;
            animation-delay: calc(var(--i) * 100ms);
        }

        @keyframes cardEntrance {
            to {
                opacity: 1;
                transform: translateY(0) translateZ(0);
            }
        }

        .item-card:hover {
            transform: translateY(-16px) translateZ(55px) rotateX(5deg) rotateY(7deg);
            box-shadow: var(--shadow-hover);
        }

        .card-img {
            position: relative;
            height: 190px;
            overflow: hidden;
            transform-style: preserve-3d;
        }

        .card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s cubic-bezier(0.22, 1, 0.36, 1);
            transform: translateZ(20px);
        }

        .item-card:hover .card-img img {
            transform: translateZ(55px) scale(1.12);
        }

        .menu {
            position: absolute;
            top: 1rem;
            right: 1rem;
            z-index: 10;
        }

        .menu i {
            color: white;
            font-size: 1.3rem;
            background: rgba(0,0,0,0.65);
            padding: 0.6rem 0.8rem;
            border-radius: 50%;
            cursor: pointer;
            transition: all 0.3s ease;
            transform: translateZ(30px);
        }

        .menu i:hover {
            background: rgba(0,0,0,0.85);
            transform: translateZ(40px) scale(1.15);
        }

        .dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 2.6rem;
            background: white;
            border-radius: 0.8rem;
            box-shadow: 0 8px 24px rgba(0,0,0,0.2);
            min-width: 160px;
            overflow: hidden;
            transform: translateZ(50px);
        }

        .dropdown a {
            display: block;
            padding: 0.9rem 1.3rem;
            color: var(--text);
            text-decoration: none;
            font-size: 0.95rem;
            transition: all 0.25s ease;
        }

        .dropdown a:hover {
            background: rgba(91, 33, 182, 0.1);
            color: var(--primary);
        }

        .item-card h3 {
            font-size: 1.32rem;
            font-weight: 600;
            margin: 1.2rem 1.4rem 0.6rem;
            color: var(--text);
            transform: translateZ(25px);
        }

        .item-card p {
            font-size: 0.97rem;
            color: var(--text-muted);
            margin: 0.4rem 1.4rem;
            transform: translateZ(25px);
        }

        .delete-btn {
            display: inline-block;
            margin: 1rem 1.4rem 1.6rem;
            padding: 0.6rem 1.3rem;
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            text-decoration: none;
            border-radius: 0.8rem;
            font-size: 0.92rem;
            font-weight: 500;
            transition: all 0.3s ease;
            transform: translateZ(30px);
        }

        .delete-btn:hover {
            transform: translateY(-2px) translateZ(40px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
        }

        /* ==================== FOOTER ==================== */
        footer {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #cbd5e1;
            text-align: center;
            padding: 4rem 1.5rem 3rem;
            margin-top: 5rem;
            font-size: 1rem;
        }

        footer .highlight {
            color: var(--accent);
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .section { padding: 4.5rem 1.25rem; }
            .items { gap: 2rem; }
        }

        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1.2rem; }
            .nav-links { gap: 1.5rem; justify-content: center; }
            .hero { padding: 5.5rem 1.5rem 4.5rem; }
            .hero h1 { font-size: 3.6rem; }
            .section h2 { font-size: 2.5rem; }
        }

        @media (max-width: 480px) {
            .hero h1 { font-size: 2.8rem; }
            .card-img { height: 170px; }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="nav-brand">APSiT Found It</div>
    <div class="nav-links">
        <a href="index.jsp"><i class="fa-solid fa-house"></i>Home</a>
        <a href="AboutUs.html"><i class="fa-solid fa-circle-info"></i>Our Story</a>
        <a href="ReportItem.jsp"><i class="fa-solid fa-plus"></i>Raise a Report</a>
        <a href="returnItem2.jsp"><i class="fa-solid fa-user-graduate"></i>Returned</a>
        <a href="logout.jsp"><i class="fa-solid fa-right-to-bracket"></i>Logout</a>
    </div>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Admin Dashboard</h1>
    <p>Manage Lost & Found Items</p>
</div>

<!-- LOST ITEMS -->
<section class="section">
    <h2>Lost Items</h2>
    <div class="items">
    <%
    String search = request.getParameter("search");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/users_10jan26", "root", "abc123"
    );
    PreparedStatement ps;
    if (search != null && !search.trim().isEmpty()) {
        ps = con.prepareStatement("SELECT * FROM items WHERE item_name LIKE ?");
        ps.setString(1, "%" + search + "%");
    } else {
        ps = con.prepareStatement("SELECT * FROM items WHERE status='lost'");
    }
    ResultSet rs = ps.executeQuery();
    int index = 0;
    while (rs.next()) {
        String img = rs.getString("image_path");
        if (img == null || img.trim().isEmpty()) img = "uploads/default.png";
    %>
        <div class="item-card-wrapper">
            <div class="item-card" style="--i: <%= index++ %>;">
                <div class="card-img">
                    <img src="<%= img %>" alt="<%= rs.getString("item_name") %>">
                    <div class="menu">
                        <i class="fa-solid fa-ellipsis-vertical" onclick="toggleMenu(this)"></i>
                        <div class="dropdown">
                            <a href="returnItem.jsp?id=<%= rs.getInt("id") %>">Mark as Returned</a>
                        </div>
                    </div>
                </div>
                <h3><%= rs.getString("item_name") %></h3>
                <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                <p><strong>Collect From:</strong> <%= rs.getString("collect_from") %></p>
            </div>
        </div>
    <% } con.close(); %>
    </div>
</section>

<!-- RETURNED ITEMS -->
<section class="section">
    <h2>Returned Items</h2>
    <div class="items">
    <%
    Connection con2 = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/users_10jan26", "root", "abc123"
    );
    PreparedStatement ps2 = con2.prepareStatement("SELECT * FROM items WHERE status='returned'");
    ResultSet rs2 = ps2.executeQuery();
    index = 0;
    while (rs2.next()) {
        String img = rs2.getString("image_path");
        if (img == null || img.trim().isEmpty()) img = "uploads/default.png";
    %>
        <div class="item-card-wrapper">
            <div class="item-card" style="--i: <%= index++ %>;">
                <div class="card-img">
                    <img src="<%= img %>" alt="<%= rs2.getString("item_name") %>">
                </div>
                <h3><%= rs2.getString("item_name") %></h3>
                <p><strong>Returned To:</strong> <%= rs2.getString("collect_from") %></p>
                <a href="deleteItem.jsp?id=<%= rs2.getInt("id") %>" class="delete-btn">Delete Record</a>
            </div>
        </div>
    <% } con2.close(); %>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>@ 2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

<script>
function toggleMenu(icon) {
    let dropdown = icon.nextElementSibling;
    dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
}
</script>

</body>
</html>