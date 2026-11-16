<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ khách</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
    <span>MemberHomeScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ khách</h1>
        <form method="post" action="${pageContext.request.contextPath}/view/member/MemberRegistrationScreen8.jsp">
            <button type="submit" name="subSelectRegistration">
                Đăng ký thành viên
            </button>
        </form>
        <p>
            <a href="${pageContext.request.contextPath}/view/member/LoginScreen8.jsp">Đăng nhập</a>
        </p>
    </section>
</main>
</body>
</html>
