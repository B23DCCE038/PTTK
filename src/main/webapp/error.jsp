<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%
    String ctx = request.getContextPath();
    Object status = request.getAttribute("jakarta.servlet.error.status_code");
    if (exception != null) {
        application.log("Unhandled error on the cinema application", exception);
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Có lỗi xảy ra</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">Đề 16</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Có lỗi xảy ra</h1>
        <div class="panel-body">
            <div class="alert error">
                Không thể xử lý yêu cầu<%= status == null ? "" : " (mã " + status + ")" %>.
                Hãy kiểm tra kết nối MySQL và cấu hình <code>db.properties</code>.
            </div>
            <p class="muted">
                Nếu ứng dụng vừa được khởi động, hãy chắc chắn container MySQL đã sẵn sàng
                và script <code>database/01-schema.sql</code>, <code>database/02-seed.sql</code>
                đã chạy.
            </p>
            <div class="actions">
                <a class="btn" href="<%= ctx %>/index.jsp">Về trang chủ</a>
            </div>
        </div>
    </section>
</main>
</body>
</html>
