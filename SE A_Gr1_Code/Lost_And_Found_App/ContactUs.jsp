<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It Contact Us</title>
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

        /* ==================== CONTACT SECTION ==================== */
        .contact-section {
            padding: 6rem 1.5rem 7rem;
            max-width: 1280px;
            margin: 0 auto;
            perspective: 1400px;
        }

        .contact-section h2 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 4rem;
            color: var(--primary-dark);
            position: relative;
            transform: translateZ(30px);
        }

        .contact-section h2::after {
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

        .contact-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2.5rem;
            max-width: 1100px;
            margin: 0 auto;
        }

        .contact-info,
        .contact-form {
            background: var(--card-bg);
            backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 1.8rem;
            padding: 2.5rem 2.2rem;
            box-shadow: var(--shadow);
            transition: all 0.55s cubic-bezier(0.34, 1.56, 0.64, 1);
            transform-style: preserve-3d;
            opacity: 0;
            transform: translateY(40px) translateZ(-80px);
            animation: cardEntrance 0.9s forwards;
        }

        .contact-info { animation-delay: 0.2s; }
        .contact-form  { animation-delay: 0.35s; }

        @keyframes cardEntrance {
            to {
                opacity: 1;
                transform: translateY(0) translateZ(0);
            }
        }

        .contact-info:hover,
        .contact-form:hover {
            transform: translateY(-16px) translateZ(55px) rotateX(5deg) rotateY(6deg);
            box-shadow: var(--shadow-hover);
        }

        .contact-info p {
            font-size: 1.05rem;
            margin: 1.4rem 0;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 1rem;
            transform: translateZ(25px);
        }

        .contact-info i {
            font-size: 1.6rem;
            color: var(--primary);
            min-width: 40px;
        }

        /* FORM STYLING */
        .contact-form input,
        .contact-form textarea {
            width: 100%;
            padding: 1rem 1.2rem;
            margin: 0.8rem 0 1.6rem;
            border: 1px solid var(--border);
            border-radius: 1rem;
            background: rgba(255,255,255,0.5);
            font-size: 0.98rem;
            color: var(--text);
            transition: all 0.28s ease;
            transform: translateZ(25px);
        }

        .contact-form input:focus,
        .contact-form textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(91, 33, 182, 0.22);
            transform: translateY(-1px) translateZ(30px);
        }

        .contact-form textarea {
            resize: vertical;
            min-height: 140px;
        }

        .contact-form button {
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
            margin-top: 1.2rem;
            transform: translateZ(30px);
        }

        .contact-form button:hover {
            transform: translateY(-3px) translateZ(45px) scale(1.02);
            box-shadow: 0 14px 32px rgba(91, 33, 182, 0.32);
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
        }

        .contact-form button i {
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
        @media (max-width: 1024px) {
            .contact-container {
                grid-template-columns: 1fr;
                max-width: 600px;
            }
        }

        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1.2rem; }
            .nav-links { gap: 1.5rem; justify-content: center; }
            .hero { padding: 6rem 1.5rem 5rem; }
            .contact-section { padding: 5rem 1.2rem 6rem; }
            .contact-section h2 { font-size: 2.6rem; }
        }

        @media (max-width: 480px) {
            .hero h1 { font-size: 2.8rem; }
            .contact-info p { font-size: 1rem; }
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
        <a href="ContactUs.jsp" class="active"><i class="fa-solid fa-phone-volume"></i>Ping Us</a>
        <a href="Loginn.jsp"><i class="fa-solid fa-user-graduate"></i>Senior2Junior</a>
    </div>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Contact Us</h1>
    <p>We're here to help reach out anytime.</p>
</div>

<!-- CONTACT SECTION -->
<section class="contact-section">
    <h2>Get in Touch</h2>
    <div class="contact-container">

        <!-- Contact Info -->
        <div class="contact-info">
            <p><i class="fa-solid fa-location-dot"></i> AP Shah Institute, Thane, Maharashtra</p>
            <p><i class="fa-solid fa-phone-volume"></i> +91 93243 45357</p>
            <p><i class="fa-solid fa-envelope"></i> apshahinstitute@gmail.com</p>
        </div>

        <!-- Contact Form -->
        <div class="contact-form">
            <form method="post">
                <input type="text" name="name" placeholder="Your Name" required autocomplete="name">
                <input type="email" name="email" placeholder="Your Email" required autocomplete="email">
                <textarea name="message" placeholder="Your Message" required></textarea>
                <button type="submit" name="btn">
                    <i class="fa-solid fa-paper-plane"></i> Send Message
                </button>
            </form>

            <%
            if (request.getParameter("btn") != null) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String message = request.getParameter("message");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/users_12feb26", "root", "abc123"
                    );
                    String sql = "INSERT INTO contact_us (name, email, message) VALUES (?, ?, ?)";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, name);
                    pst.setString(2, email);
                    pst.setString(3, message);
                    pst.executeUpdate();
                    con.close();
            %>
                    <div class="success-msg">Message sent successfully! We'll get back to you soon.</div>
            <%
                } catch (Exception e) {
            %>
                    <div class="error-msg">Error: <%= e.getMessage() %></div>
            <%
                }
            }
            %>
        </div>

    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>@ 2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

</body>
</html>