<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.ScreeningRoom8, model.Ticket8, model.Showtime8" %>
<%@ page import="dao.TicketDAO8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="/WEB-INF/jspf/_requireManagement8.jspf" %>
<%@ include file="/WEB-INF/jspf/common8.jspf" %>
<%
    int idShowtime = 0;
    try {
        idShowtime = Integer.parseInt(request.getParameter("idShowtime"));
    } catch (Exception ignored) {
        idShowtime = 0;
    }

    String showtimeDate = request.getParameter("showtimeDate");
    if (showtimeDate == null) showtimeDate = "";
    String showtimeTime = request.getParameter("showtimeTime");
    if (showtimeTime == null) showtimeTime = "";
    String roomId = request.getParameter("roomId");
    if (roomId == null) roomId = "";
    String idMovie = request.getParameter("idMovie");
    if (idMovie == null) idMovie = "0";
    String movieName = request.getParameter("movieName");
    if (movieName == null) movieName = "";
    String startDate = request.getParameter("startDate");
    if (startDate == null) startDate = "2026-01-01";
    String endDate = request.getParameter("endDate");
    if (endDate == null) endDate = "2026-03-31";

    Showtime8 showtime = new Showtime8();
    showtime.setId(idShowtime);
    showtime.setDate(parseIso8(showtimeDate, null));
    if (!showtimeTime.isEmpty()) {
        try {
            String timeValue = showtimeTime.length() == 5 ? showtimeTime + ":00" : showtimeTime;
            showtime.setStartTime(java.sql.Time.valueOf(timeValue));
        } catch (IllegalArgumentException ignored) {
            // malformed value: leave the field empty
        }
    }
    if (!roomId.isEmpty()) {
        try {
            ScreeningRoom8 room = new ScreeningRoom8();
            room.setId(Integer.parseInt(roomId));
            showtime.setRoom(room);
        } catch (NumberFormatException ignored) {
            // malformed value: leave the field empty
        }
    }

    Ticket8[] listTicketSales = new Ticket8[0];
    String outNotice = null;

    if (idShowtime > 0) {
        try {
            listTicketSales = new TicketDAO8().getTicketSales8(idShowtime);
        } catch (RuntimeException ex) {
            outNotice = "Không thể tải danh sách vé. Vui lòng kiểm tra kết nối MySQL.";
            application.log("ShowtimeTicketSalesScreen8 could not load data", ex);
        }
    }
    if (outNotice == null && listTicketSales.length == 0) {
        outNotice = "Không có vé nào được bán cho suất chiếu này.";
    }

    request.setAttribute("showtime", showtime);
    request.setAttribute("idMovie", idMovie);
    request.setAttribute("movieName", movieName);
    request.setAttribute("startDate", startDate);
    request.setAttribute("endDate", endDate);
    request.setAttribute("listTicketSales", listTicketSales);
    request.setAttribute("outNotice", outNotice);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thống kê bán vé của suất chiếu</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
</header>

<hr>

<main>
    <section>
        <h1>Thống kê bán vé của suất chiếu</h1>
        <p>
            Suất chiếu: <strong><fmt:formatDate value="${showtime.startTime}" pattern="HH:mm"/></strong>,
            phòng <strong><c:out value="${showtime.room.id}"/></strong>
            <c:if test="${not empty showtime.date}">
            — ngày <strong><fmt:formatDate value="${showtime.date}" pattern="dd/MM/yyyy"/></strong>
            </c:if>
        </p>

        <c:if test="${not empty outNotice}">
        <div><c:out value="${outNotice}"/></div>
        </c:if>

        <c:if test="${not empty listTicketSales}">
        <table id="outTicketTable">
            <thead>
            <tr>
                <th>TT</th>
                <th>Mã vé</th>
                <th>Ghế</th>
                <th>Giá vé</th>
                <th>Khách hàng</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${listTicketSales}" var="selectedTicket" varStatus="status">
                <tr>
                    <td>${status.count}</td>
                    <td>${selectedTicket.id}</td>
                    <td><c:out value="${selectedTicket.seat}"/></td>
                    <td><fmt:formatNumber value="${selectedTicket.price}" pattern="#,##0"/></td>
                    <td><c:out value="${selectedTicket.customer.fullName.fullName}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/view/managementstaff/MovieShowtimeStatisticsScreen8.jsp">
            <input type="hidden" name="idMovie" value="${fn:escapeXml(idMovie)}">
            <input type="hidden" name="movieName" value="${fn:escapeXml(movieName)}">
            <input type="hidden" name="startDate" value="${fn:escapeXml(startDate)}">
            <input type="hidden" name="endDate" value="${fn:escapeXml(endDate)}">
            <button type="submit" name="subBack" value="1">Quay lại</button>
        </form>
    </section>
</main>
</body>
</html>
