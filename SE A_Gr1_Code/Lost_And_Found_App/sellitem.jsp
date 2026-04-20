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
    <title>APSiT Found It Sell Item</title>
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
        body {
            font-family:'Inter',sans-serif;
            background:linear-gradient(135deg,#f1f5f9,#e2e8f0);
            color:var(--text);
            min-height:100vh;
        }
        .navbar {
            position:sticky; top:0; z-index:1000;
            background:rgba(255,255,255,0.84);
            backdrop-filter:blur(18px);
            border-bottom:1px solid var(--border);
            padding:1rem 2.5rem;
            display:flex; justify-content:space-between; align-items:center;
        }
        .nav-brand {
            font-family:'Playfair Display',serif;
            font-size:1.75rem; font-weight:700; color:var(--primary);
        }
        .nav-links {
            display:flex; gap:2.4rem; flex-wrap:wrap; justify-content:center;
        }
        .nav-links a {
            color:var(--text-muted); text-decoration:none; font-weight:500; font-size:0.97rem;
            display:flex; align-items:center; gap:0.6rem; transition:all 0.3s;
        }
        .nav-links a:hover { color:var(--primary); transform:translateY(-3px); }
        .page-header { text-align:center; padding:5rem 1rem 3rem; }
        .page-header h1 {
            font-family:'Playfair Display',serif;
            font-size:clamp(2.4rem,7vw,4.5rem); font-weight:700; color:var(--primary-dark);
        }
        .sell-section { padding:2rem 1.5rem 6rem; max-width:520px; margin:-80px auto 40px; }
        .sell-card {
            background:var(--card-bg); backdrop-filter:blur(16px);
            border:1px solid var(--border); border-radius:1.8rem;
            padding:2.8rem 2.4rem; box-shadow:var(--shadow);
            transition:all 0.4s;
        }
        .sell-card:hover { transform:translateY(-8px); box-shadow:var(--shadow-hover); }
        .form-group { margin-bottom:1.6rem; }
        .form-group label { display:block; margin-bottom:0.5rem; font-weight:500; }
        .form-group input {
            width:100%; padding:0.9rem 1.1rem;
            border:1px solid var(--border); border-radius:0.8rem;
            background:rgba(255,255,255,0.6);
        }
        .form-group input:focus {
            border-color:var(--primary); outline:none;
            box-shadow:0 0 0 3px rgba(91,33,182,0.2);
        }
        .btn-submit {
            width:100%; padding:1rem;
            background:linear-gradient(135deg,var(--primary),var(--primary-light));
            color:white; border:none; border-radius:0.8rem;
            font-size:1.05rem; font-weight:600; cursor:pointer;
            transition:all 0.3s;
        }
        .btn-submit:hover { transform:translateY(-2px); box-shadow:0 8px 20px rgba(91,33,182,0.3); }
        .success-msg, .error-msg {
            text-align:center; margin-top:1.5rem; padding:1rem; border-radius:0.8rem;
        }
        .success-msg { background:#dcfce7; color:#15803d; }
        .error-msg   { background:#fee2e2; color:#dc2626; }
        footer {
            background:linear-gradient(135deg,#0f172a,#1e293b);
            color:#cbd5e1; text-align:center; padding:3rem 1.5rem; margin-top:4rem;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="nav-brand">APSiT Found It</div>
    <div class="nav-links">
        <a href="home.jsp"><i class="fa-solid fa-house"></i>Home</a>
        <a href="Senior2Junior.jsp"><i class="fa-solid fa-cart-shopping"></i>Marketplace</a>
        <a href="sellitem.jsp" class="active"><i class="fa-solid fa-plus"></i>Sell Item</a>
    </div>
</div>

<div class="page-header">
    <h1>Sell Your Item</h1>
    <p>Post your item for the APSIT community to buy</p>
</div>

<section class="sell-section">
    <div class="sell-card">
        <form method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label>Item Name</label>
                <input type="text" name="itemname" placeholder="Enter item name" required>
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="text" name="price" placeholder="Enter price" required>
            </div>
            <div class="form-group">
                <label>Seller Name</label>
                <input type="text" name="seller" placeholder="Enter your name" required>
            </div>
            <div class="form-group">
                <label>Department</label>
                <input type="text" name="dept" placeholder="Enter your department" required>
            </div>
            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="Enter phone number" required>
            </div>
            <div class="form-group">
                <label>Item Image</label>
                <input type="file" name="image" accept="image/*" required>
            </div>
            <button type="submit" class="btn-submit">Post Item</button>
        </form>

        <%
        String itemname="", price="", seller="", dept="", phone="", imagePath="";
        String currentUser = (String) session.getAttribute("un");

        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> items = upload.parseRequest(request);

                for (FileItem item : items) {
                    if (item.isFormField()) {
                        String field = item.getFieldName();
                        if (field.equals("itemname")) itemname = item.getString();
                        else if (field.equals("price")) price = item.getString();
                        else if (field.equals("seller")) seller = item.getString();
                        else if (field.equals("dept")) dept = item.getString();
                        else if (field.equals("phone")) phone = item.getString();
                    } else {
                        String fileName = System.currentTimeMillis() + "_" + new File(item.getName()).getName();
                        String uploadPath = application.getRealPath("/") + "uploads";
                        File dir = new File(uploadPath);
                        if (!dir.exists()) dir.mkdirs();
                        File file = new File(uploadPath + File.separator + fileName);
                        item.write(file);
                        imagePath = "uploads/" + fileName;
                    }
                }

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/marketplace", "root", "abc123"
                );
                PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO market_items(item_name, price, seller_name, department, phone, image_path, seller_email) " +
                    "VALUES(?,?,?,?,?,?,?)"
                );
                ps.setString(1, itemname);
                ps.setString(2, price);
                ps.setString(3, seller);
                ps.setString(4, dept);
                ps.setString(5, phone);
                ps.setString(6, imagePath);
                ps.setString(7, currentUser); // ← who posted it
                ps.executeUpdate();
                con.close();
        %>
                <div class="success-msg">Item posted successfully! Redirecting to marketplace...</div>
                <script>
                    setTimeout(() => { window.location.href = "Senior2Junior.jsp"; }, 2000);
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

<footer>
    <p>@2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>