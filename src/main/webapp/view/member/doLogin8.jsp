<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MemberDAO8" %>
<%@ page import="model.ManagementStaff8" %>
<%@ page import="model.Member8" %>
<%
    String ctx = request.getContextPath();
    if (!"POST".equalsIgnoreCase(request.getMethod())
            || request.getParameter("subLogin") == null) {
        response.sendRedirect(ctx + "/view/member/LoginScreen8.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");

    String inUsername = request.getParameter("inUsername");
    String inPassword = request.getParameter("inPassword");
    String username = inUsername == null ? "" : inUsername;
    String password = inPassword == null ? "" : inPassword;

    Member8 member = null;
    if (!username.isEmpty() && !password.isEmpty()) {
        try {
            member = new MemberDAO8().login(username, password);
        } catch (RuntimeException ex) {
            application.log("Login failed for " + username, ex);
            response.sendRedirect(ctx + "/view/member/LoginScreen8.jsp?err=db");
            return;
        }
    }

    if (member == null) {
        response.sendRedirect(ctx + "/view/member/LoginScreen8.jsp?err=fail");
        return;
    }

    session.setAttribute("member", member);
    if (member instanceof ManagementStaff8) {
        response.sendRedirect(ctx + "/view/managementstaff/ManagementStaffHomeScreen8.jsp");
    } else {
        response.sendRedirect(ctx + "/view/customer/CustomerHomeScreen8.jsp");
    }
%>
