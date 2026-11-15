<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ khách</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">GuestMainScreen8.jsp</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Trang chủ khách</h1>
        <div class="panel-body">
            <p class="label">Chức năng:</p>
            <form method="post" action="<%= ctx %>/view/guest/MemberRegistrationScreen8.jsp">
                <button class="btn active" type="submit" name="subSelectRegistration" value="1">
                    Đăng ký thành viên
                </button>
            </form>
            <p class="stat-note" style="margin-top: 24px;">
                Khách chưa có tài khoản nên chỉ có chức năng đăng ký thành viên.
            </p>
        </div>
    </section>
</main>
</body>
</html>
