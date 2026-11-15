<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="util.Html8" %>
<%
    String ctx = request.getContextPath();
%>
<%@ include file="/WEB-INF/jspf/demoManagementStaff8.jspf" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Trang chủ nhân viên quản lý</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">ManagementStaffMainScreen8.jsp</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Trang chủ nhân viên quản lý</h1>
        <div class="panel-body">
            <p>Xin chào: <strong><%= Html8.escape(currentStaff.getFullName().getFullName()) %></strong></p>
            <p class="label">Chức năng:</p>
            <div class="actions" style="flex-direction: column; align-items: stretch; max-width: 460px;">
                <button class="btn" type="button" disabled>Quản lý phim</button>
                <button class="btn" type="button" disabled>Xếp lịch chiếu</button>
                <form method="post" action="<%= ctx %>/view/managementstaff/StatisticsTypeScreen8.jsp">
                    <button class="btn active" type="submit" name="subSelectStatistics" value="1"
                            style="width: 100%;">Xem thống kê</button>
                </form>
            </div>
            <p class="stat-note" style="margin-top: 22px;">
                Bản dựng không có Login 8. Trang này mở với tài khoản quản lý đã seed
                trong CSDL (admin / Trần Thị B); hai chức năng còn lại thuộc các module
                không được thiết kế chi tiết trong báo cáo.
            </p>
        </div>
    </section>
</main>
</body>
</html>
