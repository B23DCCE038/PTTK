<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
    session.invalidate();
    response.sendRedirect(ctx + "/view/member/MemberHomeScreen8.jsp");
%>
