<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/_requireManagement8.jspf" %>
<%
    String ctx = request.getContextPath();
    if (request.getParameter("subMovieStatistics") != null) {
        response.sendRedirect(ctx + "/view/managementstaff/MovieStatisticsScreen8.jsp");
        return;
    }
    if (request.getParameter("subClose") != null) {
        response.sendRedirect(ctx + "/view/managementstaff/ManagementStaffHomeScreen8.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chọn loại thống kê</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
    <span>StatisticsTypeScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Chọn loại thống kê</h1>
        <form method="post" action="${pageContext.request.contextPath}/view/managementstaff/StatisticsTypeScreen8.jsp">
            <div>
                <div><button type="submit" name="subMovieStatistics" value="1">Thống kê phim</button></div>
                <div><button type="submit" name="subCustomerStatistics" value="1" disabled>Thống kê khách hàng</button></div>
                <div><button type="submit" name="subRevenueStatistics" value="1" disabled>Thống kê doanh thu</button></div>
            </div>
            <div>
                <button type="submit" name="subClose" value="1">Đóng</button>
            </div>
        </form>
    </section>
</main>
</body>
</html>
