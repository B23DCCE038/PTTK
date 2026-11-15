<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cinema Management System</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">Đề 16 · Phân tích và thiết kế hệ thống thông tin</span>
</header>

<main class="container">
    <div class="panel">
        <h1 class="panel-title">Quản lý rạp chiếu phim</h1>
        <div class="panel-body">
            <p>
                Bản dựng hai module chi tiết của báo cáo:
                <strong>Member registration 8</strong> và <strong>View movie statistics 8</strong>.
                Cơ sở dữ liệu, lớp thực thể, lớp DAO và các trang JSP bám theo
                các biểu đồ ở mục VIII–XII của báo cáo.
            </p>
            <p class="stat-note">
                Login 8 và các module còn lại không thuộc phạm vi bản dựng này.
                Trang nhân viên quản lý mở với tài khoản quản lý đã seed trong CSDL.
            </p>
        </div>
    </div>

    <div class="landing">
        <section class="panel">
            <h2 class="panel-title">Khách</h2>
            <div class="panel-body">
                <p>Khách chưa có tài khoản chỉ có chức năng đăng ký thành viên.</p>
                <a class="btn active" href="<%= ctx %>/view/guest/GuestMainScreen8.jsp">Vào module đăng ký</a>
            </div>
        </section>

        <section class="panel">
            <h2 class="panel-title">Nhân viên quản lý</h2>
            <div class="panel-body">
                <p>Xem thống kê phim, thống kê suất chiếu và thống kê bán vé.</p>
                <a class="btn active" href="<%= ctx %>/view/managementstaff/ManagementStaffMainScreen8.jsp">Vào module thống kê (demo)</a>
            </div>
        </section>
    </div>
</main>
</body>
</html>
