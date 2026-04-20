<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/users_10jan26",
"root",
"abc123"
);

if(request.getMethod().equals("POST")){

    String returnedTo = request.getParameter("returned_to");

    PreparedStatement ps = con.prepareStatement(
    "UPDATE items SET status='returned', collect_from=? WHERE id=?"
    );

    ps.setString(1, returnedTo);
    ps.setInt(2, Integer.parseInt(id));

    ps.executeUpdate();

    response.sendRedirect("index.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Return Item</title>

<style>

body{
font-family:Arial;
background:#f4f4f4;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
}

.box{
background:white;
padding:30px;
border-radius:10px;
box-shadow:0 4px 10px rgba(0,0,0,0.2);
width:300px;
}

input{
width:100%;
padding:10px;
margin-top:10px;
border:1px solid #ccc;
border-radius:5px;
}

button{
margin-top:15px;
padding:10px;
width:100%;
background:#28a745;
border:none;
color:white;
font-size:16px;
border-radius:5px;
cursor:pointer;
}

</style>
</head>

<body>

<div class="box">

<h2>Return Item</h2>

<form method="post">

<label>Returned To</label>

<input type="text" name="returned_to" placeholder="Enter name (e.g. Jaya Gupta)" required>

<button type="submit">Confirm Return</button>

</form>

</div>

</body>
</html>