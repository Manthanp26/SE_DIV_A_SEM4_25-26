<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APSiT Found It - Register</title>
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
            --border: rgba(226, 232, 240, 0.75);
            --shadow: 0 10px 30px -10px rgba(91, 33, 182, 0.14);
            --shadow-hover: 0 20px 45px -12px rgba(91, 33, 182, 0.26);
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
            background: rgba(255, 255, 255, 0.82);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            padding: 1rem 2.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.65rem;
            font-weight: 700;
            color: var(--primary);
            letter-spacing: -0.4px;
        }

        .nav-links {
            display: flex;
            gap: 2.2rem;
        }

        .nav-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.96rem;
            display: flex;
            align-items: center;
            gap: 0.55rem;
            transition: all 0.25s ease;
        }

        .nav-links a:hover {
            color: var(--primary);
            transform: translateY(-1px);
        }

        .nav-links i {
            font-size: 1.25rem;
        }

        /* ==================== HERO ==================== */
        .hero {
            background: linear-gradient(135deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            text-align: center;
            padding: 6.5rem 1.5rem 5rem;
            position: relative;
            overflow: hidden;
            border-bottom-left-radius: 3.5rem;
            border-bottom-right-radius: 3.5rem;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at 25% 75%, rgba(255,255,255,0.16) 0%, transparent 65%);
            pointer-events: none;
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.6rem, 7.5vw, 4.8rem);
            font-weight: 700;
            margin-bottom: 0.9rem;
            letter-spacing: -1px;
            text-shadow: 0 4px 18px rgba(0,0,0,0.3);
        }

        .hero p {
            font-size: clamp(1.05rem, 2.8vw, 1.28rem);
            max-width: 640px;
            margin: 0 auto;
            opacity: 0.93;
        }

        /* ==================== REGISTER SECTION ==================== */
        .register-section {
            padding: 2rem 1.5rem 5rem;
            max-width: 460px;
            margin: -90px auto 40px;
            position: relative;
            z-index: 10;
        }

        .register-card {
            background: var(--card-bg);
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            border: 1px solid var(--border);
            border-radius: 1.8rem;
            padding: 2.5rem 2.2rem 2.8rem;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
        }

        .register-card:hover {
            box-shadow: var(--shadow-hover);
        }

        .register-card h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.1rem;
            font-weight: 700;
            color: var(--primary-dark);
            text-align: center;
            margin-bottom: 1.8rem;
        }

        .register-card .switch-link {
            text-align: center;
            margin-bottom: 1.8rem;
            font-size: 0.95rem;
        }

        .register-card .switch-link a {
            color: var(--primary);
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s;
        }

        .register-card .switch-link a:hover {
            text-decoration: underline;
            color: var(--primary-light);
        }

        .form-group {
            margin-bottom: 1.4rem;
            position: relative;
        }

        .form-group input {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 1px solid var(--border);
            border-radius: 1rem;
            background: rgba(255,255,255,0.5);
            font-size: 0.98rem;
            color: var(--text);
            transition: all 0.25s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(91, 33, 182, 0.18);
        }

        .form-group input::placeholder {
            color: #94a3b8;
        }

        .btn-submit {
            width: 100%;
            padding: 1.05rem;
            background: linear-gradient(135deg, var(--primary), var(--primary-light));
            border: none;
            color: white;
            font-size: 1.05rem;
            font-weight: 600;
            border-radius: 1rem;
            cursor: pointer;
            transition: all 0.28s ease;
            margin-top: 0.8rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 28px rgba(91, 33, 182, 0.28);
        }

        .success-msg,
        .error-msg {
            font-size: 0.92rem;
            text-align: center;
            margin-top: 1.2rem;
            padding: 0.9rem;
            border-radius: 1rem;
        }

        .success-msg {
            color: #15803d;
            background: #dcfce7;
        }

        .error-msg {
            color: #dc2626;
            background: #fee2e2;
        }

        .error-msg.domain-error {
            background: #fef3c7;
            color: #92400e;
            border-left: 4px solid #d97706;
        }

        /* ==================== FOOTER ==================== */
        footer {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #cbd5e1;
            text-align: center;
            padding: 3.5rem 1.5rem 2.5rem;
            margin-top: 4rem;
            font-size: 0.97rem;
        }

        footer .highlight {
            color: var(--accent);
            font-weight: 600;
        }

        footer a {
            color: #94a3b8;
            text-decoration: none;
        }

        footer a:hover {
            color: #cbd5e1;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .navbar { padding: 1rem 1.5rem; flex-wrap: wrap; gap: 1rem; }
            .nav-links { gap: 1.5rem; justify-content: center; flex-wrap: wrap; }
            .hero { padding: 5rem 1.2rem 4rem; }
            .register-section { padding-top: 1.5rem; margin-top: -70px; }
        }

        @media (max-width: 480px) {
            .hero h1 { font-size: 2.8rem; }
            .register-card { padding: 2rem 1.6rem; }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="nav-brand">APSiT Found It</div>
    <div class="nav-links">
        <a href="index.jsp"><i class="fa-solid fa-house"></i>Home</a>
        <a href="Loginn.jsp"><i class="fa-solid fa-right-to-bracket"></i>Login</a>
        <a href="register.jsp" style="color:var(--primary);"><i class="fa-solid fa-user-plus"></i>Register</a>
    </div>
</div>

<!-- HERO -->
<div class="hero">
    <h1>Register</h1>
    <p>Find what you lost. Return what you found.</p>
</div>

<!-- REGISTER FORM -->
<section class="register-section">
    <div class="register-card">
        <h2>Create Account</h2>
        <div class="switch-link">
            Already have an account? <a href="Loginn.jsp">Sign in</a>
        </div>

        <form method="POST" onsubmit="return validateEmail()">
            <div class="form-group">
                <input type="email"
                       name="un"
                       id="emailInput"
                       placeholder="Institute Email (@apsit.edu.in)"
                       required
                       autocomplete="email">
            </div>
            <div class="form-group">
                <input type="password" name="pw" placeholder="Password" required autocomplete="new-password">
            </div>
            <div class="form-group">
                <input type="password" name="cpw" placeholder="Confirm Password" required autocomplete="new-password">
            </div>
            <button type="submit" name="btn" class="btn-submit">Create Account</button>
        </form>

        <%
        String message = "";
        String msgClass = "";

        if (request.getParameter("btn") != null) {
            String un = request.getParameter("un").trim();
            String pw  = request.getParameter("pw");
            String cpw = request.getParameter("cpw");

            // Server-side validation
            if (!pw.equals(cpw)) {
                message = "Passwords do not match";
                msgClass = "error-msg";
            }
            else if (!un.toLowerCase().endsWith("@apsit.edu.in")) {
                message = "Only @apsit.edu.in institute emails are allowed to register";
                msgClass = "error-msg domain-error";
            }
            else {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/users_17jan26", "root", "abc123"
                    );

                    String sql = "INSERT INTO users (un, pw) VALUES (?, MD5(?))";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setString(1, un);
                    pst.setString(2, pw);
                    pst.executeUpdate();

                    message = "Registration successful! You can now <a href='Loginn.jsp'>log in</a>.";
                    msgClass = "success-msg";

                    con.close();
                }
                catch (SQLIntegrityConstraintViolationException e) {
                    message = "This email is already registered";
                    msgClass = "error-msg";
                }
                catch (Exception e) {
                    message = "Error: " + e.getMessage();
                    msgClass = "error-msg";
                }
            }

            if (!message.isEmpty()) {
        %>
                <div class="<%= msgClass %>"><%= message %></div>
        <%
            }
        }
        %>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>© 2026 <span class="highlight">Manthan Prathmesh Yathath Vedant</span><br>
    APSIT Community Lost & Found Portal</p>
</footer>

<script>
function validateEmail() {
    const email = document.getElementById("emailInput").value.trim().toLowerCase();
    const allowedDomain = "@apsit.edu.in";

    if (!email.endsWith(allowedDomain)) {
        alert("Registration is only allowed with institute email ending in @apsit.edu.in");
        document.getElementById("emailInput").focus();
        return false;
    }

    // Basic email format check
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        alert("Please enter a valid email address");
        return false;
    }

    return true;
}
</script>

</body>
</html>