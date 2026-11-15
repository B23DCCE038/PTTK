<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.*" %>
<%@ page import="util.Html8" %>
<%
    String ctx = request.getContextPath();

    // Demo identity for the no-login build: the report's boundary class
    // ManagementStaffMainScreen8 has -currentStaff : ManagementStaff8, and this
    // screen creates the same seeded account that database/02-seed.sql stores
    // (id 1, username "admin", full name Tran Thi B). No authentication and no
    // session guard is implemented (Login 8 is outside the two modules).
    ManagementStaff8 currentStaff = new ManagementStaff8();
    currentStaff.setId(1);
    currentStaff.setUsername("admin");
    currentStaff.setRole("Management staff");

    FullName8 currentStaffName = new FullName8();
    currentStaffName.setId(1);
    currentStaffName.setSurname("Trần");
    currentStaffName.setMiddleName("Thị");
    currentStaffName.setGivenName("B");
    currentStaff.setFullName(currentStaffName);
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
    <a href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span>ManagementStaffMainScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Trang chủ nhân viên quản lý</h1>
        <p>Xin chào: <strong><%= Html8.escape(currentStaff.getFullName().getFullName()) %></strong></p>
        <p>Chức năng:</p>
        <div>
            <div><button type="button" disabled>Quản lý phim</button></div>
            <div><button type="button" disabled>Xếp lịch chiếu</button></div>
            <form method="post" action="<%= ctx %>/view/managementstaff/StatisticsTypeScreen8.jsp">
                <button type="submit" name="subSelectStatistics" value="1">Xem thống kê</button>
            </form>
        </div>
        <p>
            Bản dựng không có Login 8. Trang này mở với tài khoản quản lý đã seed
            trong CSDL (admin / Trần Thị B); hai chức năng còn lại thuộc các module
            không được thiết kế chi tiết trong báo cáo.
        </p>
    </section>
</main>
</body>
</html>
