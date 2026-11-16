<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer8" %>
<%@ page import="dao.CustomerDAO8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%
    request.setCharacterEncoding("UTF-8");
    String ctx = request.getContextPath();

    String inUsername = "";
    String inPassword = "";
    String inFullName = "";
    String inPhone = "";
    String outNotice = null;
    boolean success = false;
    Customer8 customer = null;

    boolean submitted = request.getParameter("subRegister") != null;
    if (submitted) {
        String rawUsername = request.getParameter("inUsername");
        String rawPassword = request.getParameter("inPassword");
        String rawFullName = request.getParameter("inFullName");
        String rawPhone = request.getParameter("inPhone");

        inUsername = rawUsername == null ? "" : rawUsername.trim();
        inPassword = rawPassword == null ? "" : rawPassword;
        inFullName = rawFullName == null ? "" : rawFullName.trim();
        inPhone = rawPhone == null ? "" : rawPhone.trim();

        if (inUsername.isEmpty() || inPassword.isEmpty() || inFullName.isEmpty() || inPhone.isEmpty()) {
            outNotice = "Vui lòng nhập đầy đủ bốn thông tin bắt buộc: tài khoản, mật khẩu, họ tên, số điện thoại.";
        } else {
            try {
                CustomerDAO8 customerDAO8 = new CustomerDAO8();
                if (customerDAO8.checkUsernameExists8(inUsername)) {
                    outNotice = "Tên đăng nhập \"" + inUsername + "\" đã tồn tại. Vui lòng chọn tên khác.";
                } else {
                    customer = customerDAO8.addCustomer8(inUsername, inPassword, inFullName, inPhone);
                    outNotice = "Đăng ký thành công. Tài khoản \"" + customer.getUsername()
                            + "\" đã được lưu với vai trò Customer.";
                    success = true;
                }
            } catch (RuntimeException ex) {
                outNotice = "Không thể kết nối cơ sở dữ liệu để đăng ký. Vui lòng kiểm tra MySQL và thử lại.";
                application.log("Member registration failed", ex);
            }
        }
    }

    request.setAttribute("inUsername", inUsername);
    request.setAttribute("inFullName", inFullName);
    request.setAttribute("inPhone", inPhone);
    request.setAttribute("outNotice", outNotice);
    request.setAttribute("success", success);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Đăng ký thành viên</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
</header>

<hr>

<main>
    <section>
        <h1>Đăng ký thành viên</h1>
        <c:if test="${not empty outNotice}">
        <div>
            <c:out value="${outNotice}"/>
        </div>
        </c:if>

        <c:choose>
            <c:when test="${success}">
                <p>Nhấn OK để mở trang chủ khách hàng.</p>
                <p>
                    <a href="${pageContext.request.contextPath}/view/customer/CustomerHomeScreen8.jsp?registered=1">OK</a>
                </p>
            </c:when>
            <c:otherwise>
                <p>Cả bốn thông tin dưới đây đều bắt buộc.</p>
                <form method="post" action="${pageContext.request.contextPath}/view/member/MemberRegistrationScreen8.jsp">
                    <p>
                        <label for="inUsername">Tài khoản:</label>
                        <input type="text" id="inUsername" name="inUsername"
                               value="${fn:escapeXml(inUsername)}" autocomplete="username" required>
                    </p>
                    <p>
                        <label for="inPassword">Mật khẩu:</label>
                        <input type="password" id="inPassword" name="inPassword"
                               value="" autocomplete="new-password" required>
                    </p>
                    <p>
                        <label for="inFullName">Họ tên:</label>
                        <input type="text" id="inFullName" name="inFullName"
                               value="${fn:escapeXml(inFullName)}" autocomplete="name" required>
                    </p>
                    <p>
                        <label for="inPhone">Số điện thoại:</label>
                        <input type="tel" id="inPhone" name="inPhone"
                               value="${fn:escapeXml(inPhone)}" autocomplete="tel" required>
                    </p>
                    <p>
                        <button type="submit" name="subRegister" value="1">Đăng ký</button>
                        <a href="${pageContext.request.contextPath}/view/member/MemberHomeScreen8.jsp">Quay lại</a>
                    </p>
                </form>
            </c:otherwise>
        </c:choose>
    </section>
</main>
</body>
</html>
