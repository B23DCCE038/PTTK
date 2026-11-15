<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
    boolean registered = request.getParameter("registered") != null;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ khách hàng</title>
</head>
<body>
<header>
    <a href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span>CustomerMainScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ khách hàng</h1>
        <% if (registered) { %>
        <div>Đăng ký thành công. Bạn đã có thể sử dụng các chức năng của khách hàng.</div>
        <% } %>
        <p>Chức năng:</p>
        <div>
            <div><button type="button" disabled>Tìm kiếm phim</button></div>
            <div><button type="button" disabled>Mua vé online</button></div>
            <div><button type="button" disabled>Mua vé tại quầy</button></div>
        </div>
        <p>
            Giao diện này thuộc module khách hàng. Ba chức năng trên nằm ngoài
            hai module được thiết kế chi tiết trong báo cáo nên chỉ hiển thị để
            chỉ đích đến sau khi đăng ký thành công.
        </p>
        <p><a href="<%= ctx %>/index.jsp">Về trang chủ</a></p>
    </section>
</main>
</body>
</html>
