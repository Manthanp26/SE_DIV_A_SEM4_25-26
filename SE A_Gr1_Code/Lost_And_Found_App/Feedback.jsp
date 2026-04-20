<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It Feedback</title>
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

        /* ==================== HERO + FORM CONTAINER ==================== */
        .hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            padding: 6rem 1.5rem;
            position: relative;
            overflow: hidden;
            border-bottom-left-radius: 4rem;
            border-bottom-right-radius: 4rem;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 20% 80%, rgba(255,255,255,0.18) 0%, transparent 70%);
            pointer-events: none;
        }

        .feedback-box {
            background: var(--card-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--border);
            border-radius: 1.8rem;
            padding: 3rem 2.5rem;
            width: 100%;
            max-width: 520px;
            box-shadow: var(--shadow);
            transform-style: preserve-3d;
            perspective: 1400px;
            opacity: 0;
            transform: translateY(40px) translateZ(-60px);
            animation: formEntrance 1s forwards 0.3s;
        }

        @keyframes formEntrance {
            to {
                opacity: 1;
                transform: translateY(0) translateZ(0);
            }
        }

        .feedback-box:hover {
            transform: translateY(-12px) translateZ(50px) rotateX(4deg) rotateY(5deg);
            box-shadow: var(--shadow-hover);
        }

        .feedback-box h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.6rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 0.8rem;
            color: var(--primary-dark);
            transform: translateZ(30px);
        }

        .feedback-box p {
            text-align: center;
            font-size: 1.05rem;
            color: var(--text-muted);
            margin-bottom: 2.2rem;
            transform: translateZ(20px);
        }

        .input-group {
            margin-bottom: 1.6rem;
            transform: translateZ(25px);
        }

        .input-group label {
            display: block;
            margin-bottom: 0.6rem;
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text);
        }

        .input-group label i {
            margin-right: 0.5rem;
            color: var(--primary);
        }

        .input-group input,
        .input-group textarea {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 1px solid var(--border);
            border-radius: 1rem;
            background: rgba(255,255,255,0.5);
            font-size: 0.98rem;
            color: var(--text);
            transition: all 0.28s ease;
        }

        .input-group input:focus,
        .input-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(91, 33, 182, 0.22);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 110px;
        }

        .checkbox-group {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            justify-content: center;
            margin: 1rem 0 1.8rem;
            transform: translateZ(25px);
        }

        .checkbox-group label {
            display: flex;
            align-items: center;
            font-size: 0.98rem;
            cursor: pointer;
            color: var(--text);
        }

        .checkbox-group input[type="checkbox"] {
            margin-right: 0.6rem;
            width: 1.2rem;
            height: 1.2rem;
            accent-color: var(--primary);
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
            margin-top: 1rem;
            transform: translateZ(30px);
        }

        .btn-submit:hover {
            transform: translateY(-3px) translateZ(45px) scale(1.02);
            box-shadow: 0 14px 32px rgba(91, 33, 182, 0.32);
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
        }

        .btn-submit i {
            margin-right: 0.6rem;
        }

        .success-msg {
            color: #15803d;
            font-size: 1rem;
            text-align: center;
            margin-top: 1.4rem;
            background: #dcfce7;
            padding: 0.9rem;
            border-radius: 1rem;
            transform: translateZ(20px);
        }

        .error-msg {
            color: #dc2626;
            font-size: 1rem;
            text-align: center;
            margin-top: 1.4rem;
            background: #fee2e2;
            padding: 0.9rem;
            border-radius: 1rem;
            transform: translateZ(20px);
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
        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1.2rem; }
            .nav-links { gap: 1.5rem; justify-content: center; }
            .hero { padding: 5rem 1.2rem; }
            .feedback-box { padding: 2.5rem 1.8rem; }
        }

        @media (max-width: 480px) {
            .feedback-box h2 { font-size: 2.2rem; }
            .checkbox-group { flex-direction: column; gap: 1rem; }
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
        <a href="Feedback.jsp" class="active"><i class="fa-solid fa-comment-dots"></i>Rate Us</a>
        <a href="ContactUs.jsp"><i class="fa-solid fa-phone-volume"></i>Ping Us</a>
        <a href="Loginn.jsp"><i class="fa-solid fa-user-graduate"></i>Senior2Junior</a>
    </div>
</div>

<!-- HERO + FEEDBACK FORM -->
<div class="hero">
    <div class="feedback-box">
        <h2><i class="fa-solid fa-comment-dots"></i> Share Your Feedback</h2>
        <p>We'd love to hear your thoughts and suggestions to improve the portal.</p>

        <form method="post">
            <div class="input-group">
                <label><i class="fa-solid fa-user"></i> Name</label>
                <input type="text" name="name" placeholder="Enter your name" required autocomplete="name">
            </div>

            <div class="input-group">
                <label><i class="fa-solid fa-envelope"></i> Email</label>
                <input type="email" name="email" placeholder="Enter your email" required autocomplete="email">
            </div>

            <div class="input-group">
                <label><i class="fa-solid fa-star"></i> How would you rate us?</label>
                <div class="checkbox-group">
                    <label><input type="checkbox" name="ex" value="Excellent"> Excellent</label>
                    <label><input type="checkbox" name="gd" value="Good"> Good</label>
                    <label><input type="checkbox" name="pr" value="Poor"> Poor</label>
                </div>
            </div>

            <button type="submit" name="btn" class="btn-submit">
                <i class="fa-solid fa-paper-plane"></i> Submit Feedback
            </button>
        </form>

        <%
        if (request.getParameter("btn") != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String ex = request.getParameter("ex");
            String gd = request.getParameter("gd");
            String pr = request.getParameter("pr");

            String rating = "";
            if (ex != null) rating += "Excellent ";
            if (gd != null) rating += "Good ";
            if (pr != null) rating += "Poor ";

            if (rating.trim().isEmpty()) {
                rating = "No rating selected";
            }

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/users_24jan26", "root", "abc123"
                );
                String sql = "INSERT INTO student (name, email, problem) VALUES (?, ?, ?)";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setString(1, name);
                pst.setString(2, email);
                pst.setString(3, rating.trim());
                pst.executeUpdate();
                con.close();
        %>
                <div class="success-msg">Thank you! Your feedback has been saved successfully.</div>
        <%
            } catch (Exception e) {
        %>
                <div class="error-msg">Error saving feedback: <%= e.getMessage() %></div>
        <%
            }
        }
        %>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <p>@2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>