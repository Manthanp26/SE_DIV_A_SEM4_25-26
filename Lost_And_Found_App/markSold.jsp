<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
String id = request.getParameter("id");
String currentUser = (String) session.getAttribute("un");

if(currentUser == null){
    response.sendRedirect("login.jsp");
}

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/marketplace","root","abc123");

    // Only allow seller to mark sold
    PreparedStatement ps1 = con.prepareStatement("SELECT seller_name FROM market_items WHERE id=?");
    ps1.setInt(1, Integer.parseInt(id));
    ResultSet rs = ps1.executeQuery();

    if(rs.next() && currentUser.equals(rs.getString("seller_name"))){
        PreparedStatement ps = con.prepareStatement("UPDATE market_items SET status='sold' WHERE id=?");
        ps.setInt(1, Integer.parseInt(id));
        ps.executeUpdate();
    }

    con.close();
    response.sendRedirect("Senior2Junior.jsp");
}catch(Exception e){
    out.println("Error: "+e);
}
%>