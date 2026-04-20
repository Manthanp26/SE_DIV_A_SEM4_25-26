
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Claim Missing Item | Lost and Found Portal</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ---------- COMMON ---------- */
body{
    margin:0;
    font-family:Arial, Helvetica, sans-serif;
    background:#f2f2f2;
}

/* ---------- NAVBAR ---------- */
.navbar{
    background:#fff;
    padding:10px 20px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 2px 5px rgba(0,0,0,0.1);
}
.nav-left a{
    margin-right:15px;
    text-decoration:none;
    color:#333;
    font-weight:bold;
}
.nav-left a.active{
    background:#1e90ff;
    color:#fff;
    padding:6px 12px;
    border-radius:5px;
}
.nav-right button{
    margin-left:10px;
    padding:6px 14px;
    border:1px solid #999;
    background:white;
    cursor:pointer;
    border-radius:4px;
}

/* ---------- HERO ---------- */
.hero {
    background-image: url("https://images.unsplash.com/photo-1500530855697-b586d89ba3ee");
    background-size: cover;
    background-position: center;
    height: 250px;
    color: white;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
}
.hero h1{margin:0;font-size:36px;}
.hero p{margin-top:8px;}


/* ---------- FORM SECTION ---------- */
.form-section{
    display:flex;
    justify-content:center;
    padding:50px 20px;
    background:#f2f2f2;
}

.form-container{
    background:#fff;
    padding:30px;
    width:380px;
    border-radius:8px;
    box-shadow:0 5px 20px rgba(0,0,0,0.2);
}

.form-container h2{
    text-align:center;
    margin-bottom:20px;
}

.input-box{
    display:flex;
    align-items:center;
    border:1px solid #ccc;
    padding:8px;
    margin-bottom:12px;
    border-radius:4px;
}

.input-box i{
    margin-right:10px;
    color:#1e90ff;
}

.input-box input,
.input-box textarea{
    border:none;
    outline:none;
    width:100%;
    font-size:14px;
}

textarea{
    resize:none;
    height:80px;
}

.btn-submit{
    width:100%;
    padding:10px;
    background:#1e90ff;
    color:white;
    border:none;
    border-radius:4px;
    font-size:16px;
    cursor:pointer;
}
.icon-navbar {
    background: #ffffff;
    padding: 12px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.icon-navbar .icons {
    display: flex;
    gap: 22px;
}

.icon-navbar a {
    text-decoration: none;
    color: #333;
    font-size: 13px;
    font-weight: 600;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 6px;
    padding: 8px 10px;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.icon-navbar a i {
    font-size: 18px;
    color: #1e90ff;
}

.icon-navbar a:hover {
    background: #f3f7ff;
    transform: translateY(-2px);
}

.icon-navbar a:hover i {
    color: #0056d2;
}


/* ---------- FOOTER ---------- */
footer{
    background:#343a40;
    color:white;
    padding:30px;
}
.footer-container{
    display:flex;
    justify-content:space-around;
    flex-wrap:wrap;
}
.footer-box{
    width:250px;
}
.footer-box a{
    color:#ccc;
    text-decoration:none;
    display:block;
}
.footer-bottom{
    text-align:center;
    margin-top:15px;
    color:#aaa;
}
</style>
</head>

<body>

<div class="navbar icon-navbar">

    <div class="nav-left icons">

        <a href="index.jsp">
            <i class="fa-solid fa-house"></i>
            <span>Home</span>
        </a>

        <a href="AboutUs.html">
            <i class="fa-solid fa-circle-info"></i>
            <span>Our Story</span>
        </a>

        <a href="ReportItem.jsp">
            <i class="fa-solid fa-plus"></i>
            <span>Raise a Report</span>
        </a>

        <a href="ClaimItem.jsp">
            <i class="fa-solid fa-magnifying-glass"></i>
            <span>Get It Back</span>
        </a>

        <a href="Feedback.jsp">
            <i class="fa-solid fa-comment"></i>
            <span>Rate Us</span>
        </a>

        <a href="ContactUs.jsp">
            <i class="fa-solid fa-phone"></i>
            <span>Ping Us</span>
        </a>

        <a href="Senior2Junior.html">
            <i class="fa-solid fa-user-graduate"></i>
            <span>Senior2Junior</span>
        </a>

    </div>

    <div class="nav-right icons">

        <a href="Login.jsp">
            <i class="fa-solid fa-right-to-bracket"></i>
            <span>Login</span>
        </a>

        <a href="Register.jsp">
            <i class="fa-solid fa-user-plus"></i>
            <span>Register</span>
        </a>

    </div>

</div>

<!-- HERO -->
<div class="hero">
    <h1>Claim Missing Item</h1>
    <p>Find what you lost. Return what you found.</p>
</div>

<!-- FORM -->
<section class="form-section">
    <div class="form-container">
        <h2>Claim Missing Item</h2>

  <form method="POST">
    <div class="input-box">
        <i class="fa fa-user"></i>
        <input type="text" name="name" placeholder="Your Name" required>
    </div>

    <div class="input-box">
        <i class="fa fa-envelope"></i>
        <input type="email" name="email" placeholder="Your Email" required>
    </div>

    <div class="input-box">
        <i class="fa fa-tag"></i>
        <input type="text" name="itemName" placeholder="Item Name" required>
    </div>

    <div class="input-box">
        <i class="fa fa-align-left"></i>
        <textarea name="description" placeholder="Item Description"></textarea>
    </div>

    <div class="input-box">
        <i class="fa fa-location-dot"></i>
        <input type="text" name="lastSeen" placeholder="Last Seen Location">
    </div>

    <button class="btn-submit" name="btn-submit">Submit</button>
</form>
<%@ page import="java.sql.*" %>
<%
    if(request.getParameter("btn-submit") != null) {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        String lastSeen = request.getParameter("lastSeen");

        try {
            // Register JDBC driver
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            String url = "jdbc:mysql://localhost:3306/users_26jan26"; // Change DB name
            Connection con = DriverManager.getConnection(url, "root", "abc123");

            String sql = "INSERT INTO claims (name, email, item_name, description, last_seen) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, itemName);
            pst.setString(4, description);
            pst.setString(5, lastSeen);

            int row = pst.executeUpdate();

            if(row > 0) {
                out.println("<p style='color:green; text-align:center;'>Claim submitted successfully!</p>");
            } else {
                out.println("<p style='color:red; text-align:center;'>Failed to submit claim.</p>");
            }

            con.close();
        } catch(SQLIntegrityConstraintViolationException e) {
            out.println("<p style='color:red; text-align:center;'>This item has already been claimed.</p>");
        } catch(SQLException e) {
            out.println("<p style='color:red; text-align:center;'>Database error: " + e.getMessage() + "</p>");
        }
    }
%>


    </div>
</section>

<!-- FOOTER -->
<footer>
    <div class="footer-container">
        <div class="footer-box">
            <h4>Contact</h4>
            <p>apshahinstitute@gmail.com</p>
        </div>

        <div class="footer-box">
            <h4>Quick Links</h4>
            <a href="AboutUs.html">About</a>
            <a href="index.jsp">Search</a>
        </div>
    </div>
    <div class="footer-bottom">@2026 Manthan Pratham Yathath Vedant</div>
</footer>

</body>
</html>
//CREATE TABLE claims (
    -> id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, email VARCHAR(100) NOT NULL, item_name VARCHAR(100) NOT NULL, description TEXT, last_seen VARCHAR(200), created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP );