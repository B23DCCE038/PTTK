<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="util.Html8" %>
<%
    String ctx = request.getContextPath();
    String notice = null;

    if (request.getParameter("subMovieStatistics") != null) {
        response.sendRedirect(ctx + "/view/managementstaff/MovieStatisticsScreen8.jsp");
        return;
    }
    if (request.getParameter("subCustomerStatistics") != null) {
        notice = "Thống kê khách hàng thuộc hệ thống nhưng không được thiết kế chi tiết trong tài liệu này.";
    }
    if (request.getParameter("subRevenueStatistics") != null) {
        notice = "Thống kê doanh thu thuộc hệ thống nhưng không được thiết kế chi tiết trong tài liệu này.";
    }
    if (request.getParameter("subClose") != null) {
        response.sendRedirect(ctx + "/view/managementstaff/ManagementStaffMainScreen8.jsp");
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
    <a href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span>StatisticsTypeScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Chọn loại thống kê</h1>
        <% if (notice != null) { %>
        <div><%= Html8.escape(notice) %></div>
        <% } %>

        <form method="post" action="<%= ctx %>/view/managementstaff/StatisticsTypeScreen8.jsp">
            <div>
                <div><button type="submit" name="subMovieStatistics" value="1">Thống kê phim</button></div>
                <div><button type="submit" name="subCustomerStatistics" value="1">Thống kê khách hàng</button></div>
                <div><button type="submit" name="subRevenueStatistics" value="1">Thống kê doanh thu</button></div>
            </div>
            <div>
                <button type="submit" name="subClose" value="1">Đóng</button>
            </div>
        </form>

        <p>
            Module chi tiết của báo cáo là <strong>View movie statistics 8</strong>.
            Hai loại thống kê còn lại có trong biểu đồ use case tổng quan nhưng
            không được thiết kế chi tiết.
        </p>
    </section>
</main>
</body>
</html>
