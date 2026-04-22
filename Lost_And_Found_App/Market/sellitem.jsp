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
<title>Sell Item | Senior2Junior Marketplace</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
/* ===== GLOBAL ===== */
body {
    margin:0;
    font-family: 'Poppins', sans-serif;
    background:#f5f7fb;
    color:#1e293b;
}

/* ===== NAVBAR ===== */
.icon-navbar {
    background:white;
    padding:15px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 2px 10px rgba(0,0,0,0.05);
}

.icons {
    display:flex;
    gap:25px;
}

.icon-navbar a {
    text-decoration:none;
    color:#334155;
    font-size:13px;
    font-weight:500;
    display:flex;
    flex-direction:column;
    align-items:center;
    transition:0.3s;
}

.icon-navbar a i {
    font-size:18px;
    color:#6366f1;
}

.icon-navbar a:hover {
    color:#4f46e5;
    transform:translateY(-2px);
}

/* ===== PAGE HEADING ===== */
h2 {
    text-align:center;
    margin-top:30px;
    color:#4f46e5;
    font-size:28px;
}

/* ===== FORM ===== */
form {
    background:white;
    width:380px;
    margin:40px auto;
    padding:30px;
    border-radius:16px;
    box-shadow:0 8px 25px rgba(0,0,0,0.1);
    transition:transform 0.3s, box-shadow 0.3s;
}

form:hover {
    transform: translateY(-3px);
    box-shadow:0 12px 30px rgba(0,0,0,0.15);
}

form input[type="text"],
form input[type="file"] {
    width:100%;
    padding:10px 12px;
    margin-top:8px;
    margin-bottom:16px;
    border:1px solid #cbd5e1;
    border-radius:8px;
    font-size:14px;
    outline:none;
    transition:border 0.3s, box-shadow 0.3s;
}

form input[type="text"]:focus,
form input[type="file"]:focus {
    border-color:#6366f1;
    box-shadow:0 0 6px rgba(99,102,241,0.3);
}

/* ===== BUTTON ===== */
button {
    background:#6366f1;
    color:white;
    border:none;
    padding:12px;
    width:100%;
    border-radius:8px;
    font-size:16px;
    font-weight:500;
    cursor:pointer;
    transition:background 0.3s, transform 0.2s;
}

button:hover {
    background:#4f46e5;
    transform:translateY(-2px);
}

/* ===== SUCCESS / ERROR MESSAGES ===== */
.success {
    text-align:center;
    color:green;
    margin-top:15px;
    font-weight:500;
}

.error {
    text-align:center;
    color:red;
    margin-top:15px;
    font-weight:500;
}

/* ===== RESPONSIVE ===== */
@media(max-width:480px){
    form {
        width:90%;
        padding:20px;
    }
}
</style>
</head>

<body>

<!-- NAVBAR -->
<div class="icon-navbar">
    <div class="icons">
        <a href="home.jsp"><i class="fa-solid fa-house"></i><span>Home</span></a>
        <a href="Senior2Junior.jsp"><i class="fa-solid fa-cart-shopping"></i><span>Buy Item</span></a>
        <a href="sellitem.jsp"><i class="fa-solid fa-plus"></i><span>Sell Item</span></a>
    </div>
</div>

<h2>Sell Your Item</h2>

<form method="post" enctype="multipart/form-data">
    <label>Item Name</label>
    <input type="text" name="itemname" placeholder="Enter item name" required>

    <label>Price</label>
    <input type="text" name="price" placeholder="Enter price" required>

    <label>Seller Name</label>
    <input type="text" name="seller" placeholder="Enter your name" required>

    <label>Department</label>
    <input type="text" name="dept" placeholder="Enter department" required>

    <label>Phone</label>
    <input type="text" name="phone" placeholder="Enter phone number" required>

    <label>Image</label>
    <input type="file" name="image" required>

    <button type="submit">Post Item</button>
</form>

<%
String itemname="", price="", seller="", dept="", phone="", imagePath="";
try{
    if(ServletFileUpload.isMultipartContent(request)){
        DiskFileItemFactory factory=new DiskFileItemFactory();
        ServletFileUpload upload=new ServletFileUpload(factory);
        List<FileItem> items=upload.parseRequest(request);

        for(FileItem item:items){
            if(item.isFormField()){
                String field=item.getFieldName();
                if(field.equals("itemname")) itemname=item.getString();
                else if(field.equals("price")) price=item.getString();
                else if(field.equals("seller")) seller=item.getString();
                else if(field.equals("dept")) dept=item.getString();
                else if(field.equals("phone")) phone=item.getString();
            }else{
                String fileName=System.currentTimeMillis()+"_"+new File(item.getName()).getName();
                String uploadPath=application.getRealPath("/")+"uploads";
                File dir=new File(uploadPath);
                if(!dir.exists()) dir.mkdirs();
                File file=new File(uploadPath+File.separator+fileName);
                item.write(file);
                imagePath="uploads/"+fileName;
            }
        }

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/marketplace",
            "root",
            "abc123"
        );

        PreparedStatement ps=con.prepareStatement(
            "INSERT INTO market_items(item_name,price,seller_name,department,phone,image_path) VALUES(?,?,?,?,?,?)"
        );
        ps.setString(1,itemname);
        ps.setString(2,price);
        ps.setString(3,seller);
        ps.setString(4,dept);
        ps.setString(5,phone);
        ps.setString(6,imagePath);
        ps.executeUpdate();
        con.close();

        out.println("<div class='success'>Item Posted Successfully!</div>");
    }
}catch(Exception e){
    out.println("<div class='error'>Error: "+e+"</div>");
}
%>

</body>
</html>