
<%@   page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>About Us | Lost and Found Portal</title>

<style>
/* ---------- COMMON ---------- */
body{
    margin:0;
    font-family:Arial, Helvetica, sans-serif;
    background:#f2f2f2;
}
.about-section {
    text-align: center;
    padding: 20px;
}

.about-image-container {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.about-image-container img {
    width: 600px;
    max-width: 90%;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}
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
        }hero h1{margin:0;font-size:36px;}
.hero p{margin-top:8px;}


.about-text {
    max-width: 800px;
    margin: 25px auto;
    font-size: 16px;
    line-height: 1.7;
    color: #555;
}
/* ---------- NAVBAR ---------- */
.navbar{
    background:#fff;
    padding:10px 20px;
    display:flex;
    justify-content:space-between;
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

.about-image-container {
    display: flex;
    justify-content: center;
    margin-top: 40px;
}

.about-image-container img {
    width: 600px;
    max-width: 90%;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
}

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
.footer-box{width:250px;}
.footer-box a{color:#ccc;text-decoration:none;display:block;}
.footer-bottom{text-align:center;margin-top:15px;color:#aaa;}
</style>
</head>
</body>
<!-- NAVBAR -->
  <div class="navbar">
    <div class="nav-left">
        <a href="home.html">Home</a>
        <a href="Aboutus.html">About Us</a>
        <a href="ReportItem.html">Report Items</a>
        <a href="ClaimItem.html">Claim Missing</a>
        <a href="feedback.html">Feedback</a>
    </div>
  </div>

<div class="hero">
    <h1>About Us Page</h1>
    <p>Find what you lost. Return what you found.</p>
</div>



<div class="about-image-container">
    <img src="https://plus.unsplash.com/premium_photo-1661297433665-870517c1cf6f?q=80&w=880&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="About Us Image">
</div>


<div class="about-section">

    <div class="about-image-container">
             <p>
               Our Lost and Found Portal is a digital platform designed to help people quickly report, track, and recover lost items in an easy and transparent way. The portal acts as a bridge between individuals who have lost their belongings and those who have found them, promoting honesty, responsibility, and cooperation within the community.</br>
            </p>
<p>We aim to reduce the stress and time involved in finding lost items by providing a centralized system where users can post details of lost or found belongings. By using technology, we make the recovery process faster, more reliable, and accessible to everyone.<p>

<p>Our platform encourages ethical behavior and builds trust by ensuring secure information sharing and clear communication between users. Whether it’s a student, employee, or visitor, the Lost and Found Portal helps create a safer and more organized environment.</p>

<p>We believe that small digital solutions can create a big social impact by saving resources, reducing misuse of items, and strengthening community values.</p>

</div>

<!-- FOOTER -->
<footer>
<div class="footer-container">
<div class="footer-box">
<h4>Contact</h4>
<p>apshahinstitute@gmail.com</p>
</div>
<div class="footer-box">
<h4>Quick Links</h4>
<a href="home.html">About</a>
            <a href="index.html">Search</a>
</div>
</div>
<div class="footer-bottom">© 2026 Lost & Found</div>
</footer>

<script>
const updateSlider=document.getElementById("updateSlider");
function slideLeft(){updateSlider.scrollLeft-=270;}
function slideRight(){updateSlider.scrollLeft+=270;}

const stepSlider=document.getElementById("stepSlider");
function slideUp(){stepSlider.scrollLeft-=270;}
function slideDown(){stepSlider.scrollLeft+=270;}
</script>

</body>
</html>