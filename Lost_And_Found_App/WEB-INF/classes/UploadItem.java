import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@MultipartConfig

@WebServlet("/UploadItem")

public class UploadItem extends HttpServlet {

protected void doPost(HttpServletRequest request,HttpServletResponse response)
throws ServletException,IOException {

String item=request.getParameter("item");
String price=request.getParameter("price");
String seller=request.getParameter("seller");
String dept=request.getParameter("dept");
String phone=request.getParameter("phone");

Part filePart=request.getPart("image");
String fileName=filePart.getSubmittedFileName();

String uploadPath=getServletContext().getRealPath("")+"uploads";

File uploadDir=new File(uploadPath);

if(!uploadDir.exists())
uploadDir.mkdir();

filePart.write(uploadPath+File.separator+fileName);

try{

Class.forName("com.mysql.cj.jdbc.Driver");

Connection con=DriverManager.getConnection(
"jdbc:mysql://localhost:3306/marketplace","root","abc123"
);

PreparedStatement ps=con.prepareStatement(
"INSERT INTO market_items(item_name,price,image,seller_name,department,phone) VALUES(?,?,?,?,?,?)"
);

ps.setString(1,item);
ps.setString(2,price);
ps.setString(3,fileName);
ps.setString(4,seller);
ps.setString(5,dept);
ps.setString(6,phone);

ps.executeUpdate();

con.close();

}catch(Exception e){
System.out.println(e);
}

response.sendRedirect("Senior2Junior.jsp");

}
}