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
</head>
<body>
<header>
    <a href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span>GuestMainScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ khách</h1>
        <p>Chức năng:</p>
        <form method="post" action="<%= ctx %>/view/guest/MemberRegistrationScreen8.jsp">
            <button type="submit" name="subSelectRegistration" value="1">
                Đăng ký thành viên
            </button>
        </form>
        <p>
            Khách chưa có tài khoản nên chỉ có chức năng đăng ký thành viên.
        </p>
    </section>
</main>
</body>
</html>
