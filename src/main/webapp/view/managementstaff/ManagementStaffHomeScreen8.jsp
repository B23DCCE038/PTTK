<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/jspf/_requireManagement8.jspf" %>
<%
    String currentStaffName = "";
    if (currentStaff.getFullName() != null) {
        currentStaffName = currentStaff.getFullName().getFullName();
    }
    if (currentStaffName.isEmpty() && currentStaff.getUsername() != null) {
        currentStaffName = currentStaff.getUsername();
    }

    request.setAttribute("currentStaffName", currentStaffName);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ nhân viên quản lý</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ nhân viên quản lý</h1>
        <p>Xin chào: <strong><c:out value="${currentStaffName}"/></strong></p>
        <p>Chức năng:</p>
        <div>
            <div><button type="button" disabled>Quản lý phim</button></div>
            <div><button type="button" disabled>Xếp lịch chiếu</button></div>
            <form method="post" action="${pageContext.request.contextPath}/view/managementstaff/StatisticsTypeScreen8.jsp">
                <button type="submit" name="subSelectStatistics" value="1">Xem thống kê</button>
            </form>
        </div>
        <p><a href="${pageContext.request.contextPath}/view/member/doLogout8.jsp">Đăng xuất</a></p>
    </section>
</main>
</body>
</html>
