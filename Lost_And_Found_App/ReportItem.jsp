<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It  Report Item</title>
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
            gap: 2.1rem;
            flex-wrap: wrap;
            justify-content: center;
        }

        .nav-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.96rem;
            display: flex;
            align-items: center;
            gap: 0.55rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            transform: translateZ(0);
        }

        .nav-links a:hover,
        .nav-links a.active {
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
            padding: 7rem 2rem 6rem;
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
            font-size: clamp(2.8rem, 8vw, 5.2rem);
            font-weight: 700;
            margin-bottom: 1rem;
            letter-spacing: -1.2px;
            text-shadow: 0 6px 24px rgba(0,0,0,0.45);
            transform: translateZ(40px);
        }

        .hero p {
            font-size: clamp(1.1rem, 3vw, 1.35rem);
            max-width: 680px;
            margin: 0 auto;
            opacity: 0.94;
            transform: translateZ(20px);
        }

        /* ==================== REPORT FORM SECTION ==================== */
        .report-section {
            padding: 4rem 1.5rem 7rem;
            max-width: 520px;
            margin: -110px auto 40px;
            perspective: 1400px;
        }

        .report-card {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border);
            border-radius: 1.8rem;
            padding: 2.8rem 2.4rem 3rem;
            box-shadow: var(--shadow);
            transition: all 0.55s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform-style: preserve-3d;
            opacity: 0;
            transform: translateY(40px) translateZ(-80px);
            animation: formEntrance 1s forwards 0.3s;
        }

        @keyframes formEntrance {
            to {
                opacity: 1;
                transform: translateY(0) translateZ(0);
            }
        }

        .report-card:hover {
            transform: translateY(-14px) translateZ(55px) rotateX(5deg) rotateY(6deg);
            box-shadow: var(--shadow-hover);
        }

        .form-group {
            margin-bottom: 1.8rem;
            transform: translateZ(25px);
        }

        .form-group label {
            display: block;
            margin-bottom: 0.6rem;
            font-size: 0.98rem;
            font-weight: 500;
            color: var(--text);
        }

        .form-group input[type="text"],
        .form-group input[type="file"],
        .form-group textarea {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 1px solid var(--border);
            border-radius: 1rem;
            background: rgba(255,255,255,0.5);
            font-size: 0.98rem;
            color: var(--text);
            transition: all 0.28s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(91, 33, 182, 0.22);
            transform: translateY(-1px) translateZ(30px);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 110px;
        }

        .form-group input[type="file"] {
            padding: 0.8rem;
        }

        .btn-submit {
            width: 100%;
            padding: 1.1rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border: none;
            color: white;
            font-size: 1.05rem;
            font-weight: 600;
            border-radius: 1rem;
            cursor: pointer;
            transition: all 0.32s cubic-bezier(0.4, 0, 0.2, 1);
            margin-top: 1.4rem;
            transform: translateZ(30px);
        }

        .btn-submit:hover {
            transform: translateY(-3px) translateZ(45px) scale(1.02);
            box-shadow: 0 14px 32px rgba(91, 33, 182, 0.32);
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
        }

        .success-msg {
            color: #15803d;
            font-size: 1rem;
            text-align: center;
            margin-top: 1.6rem;
            background: #dcfce7;
            padding: 1rem;
            border-radius: 1rem;
            transform: translateZ(20px);
        }

        .error-msg {
            color: #dc2626;
            font-size: 1rem;
            text-align: center;
            margin-top: 1.6rem;
            background: #fee2e2;
            padding: 1rem;
            border-radius: 1rem;
            transform: translateZ(20px);
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
        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1.2rem; }
            .nav-links { gap: 1.5rem; justify-content: center; }
            .hero { padding: 5.5rem 1.5rem 4.5rem; }
            .report-section { padding: 3rem 1.2rem 5rem; margin-top: -90px; }
        }

        @media (max-width: 480px) {
            .hero h1 { font-size: 2.8rem; }
            .report-card { padding: 2.2rem 1.8rem; }
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
        <a href="ReportItem.jsp" class="active"><i class="fa-solid fa-plus"></i>Report Item</a>
    </div>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Report Item</h1>
    <p>Help the community report lost or found items</p>
</div>

<!-- REPORT FORM -->
<section class="report-section">
    <div class="report-card">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Item Name</label>
                <input type="text" name="itemname" placeholder="Enter item name" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="desc" placeholder="Describe the item (color, condition, etc.)"></textarea>
            </div>

            <div class="form-group">
                <label>Location Found / Lost</label>
                <input type="text" name="location" placeholder="Where was it found or lost?" required>
            </div>

            <div class="form-group">
                <label>Collect From / Deliver To</label>
                <input type="text" name="collect_from" placeholder="Example: Security Office / Admin Desk" required>
            </div>

            <div class="form-group">
                <label>Item Image</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <button type="submit" class="btn-submit">Submit Report</button>
        </form>

        <%
        String itemname = "", desc = "", location = "", collect_from = "", imagePath = "";
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String fieldName = item.getFieldName();
                        if (fieldName.equals("itemname")) itemname = item.getString();
                        else if (fieldName.equals("desc")) desc = item.getString();
                        else if (fieldName.equals("location")) location = item.getString();
                        else if (fieldName.equals("collect_from")) collect_from = item.getString();
                    } else {
                        String fileName = System.currentTimeMillis() + "_" + new File(item.getName()).getName();
                        String uploadPath = application.getRealPath("/") + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs();
                        File file = new File(uploadPath + File.separator + fileName);
                        item.write(file);
                        imagePath = "uploads/" + fileName;
                    }
                }

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/users_10jan26", "root", "abc123"
                );
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO items(item_name, description, location, collect_from, image_path, status) VALUES (?, ?, ?, ?, ?, 'lost')"
                );
                ps.setString(1, itemname);
                ps.setString(2, desc);
                ps.setString(3, location);
                ps.setString(4, collect_from);
                ps.setString(5, imagePath);
                ps.executeUpdate();
                ps.close();
                con.close();
        %>
                <div class="success-msg">Item reported successfully! Redirecting...</div>
                <script>
                    setTimeout(() => { window.location.href = "index.jsp"; }, 2000);
                </script>
        <%
            }
        } catch (Exception e) {
        %>
            <div class="error-msg">Error: <%= e.getMessage() %></div>
        <%
        }
        %>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>@2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>