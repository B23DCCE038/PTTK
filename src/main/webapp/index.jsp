<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Customer8" %>
<%@ page import="model.ManagementStaff8" %>
<%@ page import="model.Seller8" %>
<%
    String ctx = request.getContextPath();
    Object member = session.getAttribute("member");
    if (member instanceof ManagementStaff8) {
        response.sendRedirect(ctx + "/view/managementstaff/ManagementStaffHomeScreen8.jsp");
    } else if (member instanceof Customer8 || member instanceof Seller8) {
        response.sendRedirect(ctx + "/view/customer/CustomerHomeScreen8.jsp");
    } else {
        response.sendRedirect(ctx + "/view/member/MemberHomeScreen8.jsp");
    }
%>
