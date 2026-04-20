<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It Lost & Found Portal</title>
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
            gap: 2.4rem;
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
            padding: 8rem 2rem 6.5rem;
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
            font-size: clamp(3rem, 9vw, 5.8rem);
            font-weight: 700;
            margin-bottom: 1.2rem;
            letter-spacing: -1.4px;
            text-shadow: 0 6px 24px rgba(0,0,0,0.45);
            transform: translateZ(40px);
        }

        .hero p {
            font-size: clamp(1.15rem, 3.2vw, 1.45rem);
            max-width: 720px;
            margin: 0 auto;
            opacity: 0.95;
            transform: translateZ(20px);
        }

        /* ==================== SECTION ==================== */
        .section {
            padding: 6rem 1.5rem 7rem;
            max-width: 1380px;
            margin: 0 auto;
            perspective: 1400px;
        }

        .section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 4rem;
            color: var(--primary-dark);
            position: relative;
            transform: translateZ(30px);
        }

        .section h2::after {
            content: '';
            position: absolute;
            bottom: -1.1rem;
            left: 50%;
            transform: translateX(-50%);
            width: 130px;
            height: 6px;
            background: linear-gradient(to right, var(--primary), var(--accent));
            border-radius: 4px;
        }

        /* ==================== CARD GRID ==================== */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(310px, 1fr));
            gap: 2.5rem;
        }

        .card-wrapper {
            perspective: 1600px;
        }

        .card {
            background: var(--card-bg);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 1.8rem;
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: all 0.55s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform-style: preserve-3d;
            position: relative;
            opacity: 0;
            transform: translateY(40px) translateZ(-80px);
            animation: cardEntrance 0.9s forwards;
            animation-delay: calc(var(--i) * 120ms);
        }

        @keyframes cardEntrance {
            to {
                opacity: 1;
                transform: translateY(0) translateZ(0);
            }
        }

        .card:hover {
            transform: translateY(-18px) translateZ(60px) rotateX(6deg) rotateY(8deg);
            box-shadow: var(--shadow-hover);
        }

        .card-img-wrapper {
            position: relative;
            overflow: hidden;
            height: 210px;
            transform-style: preserve-3d;
        }

        .card-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s cubic-bezier(0.22, 1, 0.36, 1);
            transform: translateZ(20px);
        }

        .card:hover .card-img {
            transform: translateZ(60px) scale(1.14);
        }

        .badge {
            position: absolute;
            top: 1.2rem;
            left: 1.2rem;
            padding: 0.5rem 1.1rem;
            border-radius: 999px;
            font-size: 0.84rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.22);
            z-index: 2;
            transform: translateZ(30px);
        }

        .badge.lost { background: #fee2e2; color: #b91c1c; }
        .badge.returned { background: #dcfce7; color: #15803d; }

        .card-content {
            padding: 1.6rem 1.7rem 2rem;
            transform: translateZ(25px);
        }

        .card h3 {
            font-size: 1.38rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: var(--text);
        }

        .card p {
            font-size: 0.98rem;
            color: var(--text-muted);
            margin: 0.6rem 0;
        }

        /* ==================== FOOTER ==================== */
        footer {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #cbd5e1;
            text-align: center;
            padding: 4rem 1.5rem 3rem;
            margin-top: 6rem;
            font-size: 1rem;
        }

        footer .highlight {
            color: var(--accent);
            font-weight: 600;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .section { padding: 5rem 1.25rem; }
            .grid { gap: 2rem; }
        }

        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1.2rem; }
            .nav-links { gap: 1.6rem; justify-content: center; }
            .hero { padding: 6rem 1.5rem 5rem; }
            .hero h1 { font-size: 3.8rem; }
            .section h2 { font-size: 2.6rem; }
        }

        @media (max-width: 480px) {
            .hero h1 { font-size: 2.9rem; }
            .card-img-wrapper { height: 190px; }
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
        <a href="Feedback.jsp"><i class="fa-solid fa-comment-dots"></i>Rate Us</a>
        <a href="ContactUs.jsp"><i class="fa-solid fa-phone-volume"></i>Ping Us</a>
        <a href="Loginn.jsp"><i class="fa-solid fa-user-graduate"></i>Senior2Junior</a>
        <a href="Login.jsp" style="color:var(--primary);"><i class="fa-solid fa-shield-halved"></i>Admin</a>
    </div>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Found It!</h1>
    <p>Helping the APSIT community recover lost belongings and celebrate returned treasures.</p>
</div>

<!-- LOST ITEMS -->
<section class="section">
    <h2>Lost Items</h2>
    <div class="grid">
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
        <div class="card-wrapper">
            <div class="card" style="--i: <%= index++ %>;">
                <span class="badge lost">LOST</span>
                <div class="card-img-wrapper">
                    <img class="card-img" src="<%= img %>" alt="<%= rs.getString("item_name") %>">
                </div>
                <div class="card-content">
                    <h3><%= rs.getString("item_name") %></h3>
                    <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                    <p><strong>Collect From:</strong> <%= rs.getString("collect_from") %></p>
                </div>
            </div>
        </div>
    <% } con.close(); %>
    </div>
</section>

<!-- RETURNED ITEMS -->
<section class="section">
    <h2>Returned Items</h2>
    <div class="grid">
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
        <div class="card-wrapper">
            <div class="card" style="--i: <%= index++ %>;">
                <span class="badge returned">RETURNED</span>
                <div class="card-img-wrapper">
                    <img class="card-img" src="<%= img %>" alt="<%= rs2.getString("item_name") %>">
                </div>
                <div class="card-content">
                    <h3><%= rs2.getString("item_name") %></h3>
                    <p><strong>Returned To:</strong> <%= rs2.getString("collect_from") %></p>
                </div>
            </div>
        </div>
    <% } con2.close(); %>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>@2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>