<%@ page import="java.sql.*" %>

<%
String id = request.getParameter("id");

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con = DriverManager.getConnection(
"jdbc:mysql://localhost:3306/users_10jan26",
"root",
"abc123"
);

PreparedStatement ps = con.prepareStatement(
"DELETE FROM items WHERE id=?"
);

ps.setInt(1,Integer.parseInt(id));

ps.executeUpdate();

con.close();

response.sendRedirect("index.jsp");
%>