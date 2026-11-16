<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    String outNotice = null;
    String err = request.getParameter("err");
    if ("fail".equals(err)) {
        outNotice = "Sai tên đăng nhập hoặc mật khẩu!";
    } else if ("timeout".equals(err)) {
        outNotice = "Hết phiên làm việc hoặc chưa đăng nhập. Vui lòng đăng nhập lại!";
    } else if ("db".equals(err)) {
        outNotice = "Không kết nối được cơ sở dữ liệu. Vui lòng kiểm tra MySQL và thử lại.";
    }
    request.setAttribute("outNotice", outNotice);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng nhập</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
</header>

<hr>

<main>
    <section>
        <h1>Đăng nhập</h1>
        <p>admin admin123</p>
        <c:if test="${not empty outNotice}">
        <div><c:out value="${outNotice}"/></div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/view/member/doLogin8.jsp">
            <p>
                <label for="inUsername">Tên đăng nhập:</label>
                <input type="text" id="inUsername" name="inUsername"
                       autocomplete="username" required>
            </p>
            <p>
                <label for="inPassword">Mật khẩu:</label>
                <input type="password" id="inPassword" name="inPassword"
                       autocomplete="current-password" required>
            </p>
            <p>
                <button type="submit" name="subLogin" value="1">Đăng nhập</button>
                <a href="${pageContext.request.contextPath}/view/member/MemberHomeScreen8.jsp">Quay lại</a>
            </p>
        </form>
    </section>
</main>
</body>
</html>
