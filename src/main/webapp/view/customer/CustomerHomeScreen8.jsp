<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ khách hàng</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
    <span>CustomerHomeScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ khách hàng</h1>
        <c:if test="${not empty param.registered}">
        <div>Đăng ký thành công. Bạn đã có thể sử dụng các chức năng của khách hàng.</div>
        </c:if>
        <c:if test="${not empty sessionScope.member}">
        <c:set var="signedInName" value="${sessionScope.member.fullName.fullName}"/>
        <c:if test="${empty signedInName}">
            <c:set var="signedInName" value="${sessionScope.member.username}"/>
        </c:if>
        <p>Xin chào: <strong><c:out value="${signedInName}"/></strong></p>
        </c:if>
        <div>
            <div><button type="button" disabled>Tìm kiếm phim</button></div>
            <div><button type="button" disabled>Mua vé online</button></div>
            <div><button type="button" disabled>Mua vé tại quầy</button></div>
        </div>
        <p>
            <a href="${pageContext.request.contextPath}/view/member/doLogout8.jsp">Đăng xuất</a>
            <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
        </p>
    </section>
</main>
</body>
</html>
