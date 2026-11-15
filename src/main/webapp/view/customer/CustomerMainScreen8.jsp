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
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">CustomerMainScreen8.jsp</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Trang chủ khách hàng</h1>
        <div class="panel-body">
            <% if (registered) { %>
            <div class="alert success">Đăng ký thành công. Bạn đã có thể sử dụng các chức năng của khách hàng.</div>
            <% } %>
            <p class="label">Chức năng:</p>
            <div class="actions" style="flex-direction: column; align-items: stretch; max-width: 420px;">
                <button class="btn" type="button" disabled>Tìm kiếm phim</button>
                <button class="btn" type="button" disabled>Mua vé online</button>
                <button class="btn" type="button" disabled>Mua vé tại quầy</button>
            </div>
            <p class="stat-note" style="margin-top: 22px;">
                Giao diện này thuộc module khách hàng. Ba chức năng trên nằm ngoài
                hai module được thiết kế chi tiết trong báo cáo nên chỉ hiển thị để
                chỉ đích đến sau khi đăng ký thành công.
            </p>
            <div class="actions">
                <a class="btn" href="<%= ctx %>/index.jsp">Về trang chủ</a>
            </div>
        </div>
    </section>
</main>
</body>
</html>
