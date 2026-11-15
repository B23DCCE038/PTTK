<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Showtime8" %>
<%@ page import="model.ScreeningRoom8" %>
<%@ page import="model.Ticket8" %>
<%@ page import="dao.TicketDAO8" %>
<%@ page import="util.DateUtil8" %>
<%@ page import="util.Html8" %>
<%@ page import="util.Money8" %>
<%
    String ctx = request.getContextPath();

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
    showtime.setDate(DateUtil8.parseIso(showtimeDate, null));
    if (!showtimeTime.isEmpty()) {
        try {
            String timeValue = showtimeTime.length() == 5 ? showtimeTime + ":00" : showtimeTime;
            showtime.setStartTime(java.sql.Time.valueOf(timeValue));
        } catch (IllegalArgumentException ignored) {
            // the display still uses the raw query parameter
        }
    }
    if (!roomId.isEmpty()) {
        try {
            ScreeningRoom8 room = new ScreeningRoom8();
            room.setId(Integer.parseInt(roomId));
            showtime.setRoom(room);
        } catch (NumberFormatException ignored) {
            // the display still uses the raw query parameter
        }
    }

    Ticket8[] listTicketSales = new Ticket8[0];
    String outNotice = null;
    boolean noticeIsError = false;

    if (idShowtime > 0) {
        try {
            listTicketSales = new TicketDAO8().getTicketSales8(idShowtime);
        } catch (RuntimeException ex) {
            outNotice = "Không thể tải danh sách vé. Vui lòng kiểm tra kết nối MySQL.";
            noticeIsError = true;
            application.log("ShowtimeTicketSalesScreen8 could not load data", ex);
        }
    }
    if (outNotice == null && listTicketSales.length == 0) {
        outNotice = "Không có vé nào được bán cho suất chiếu này.";
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thống kê bán vé của suất chiếu</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">ShowtimeTicketSalesScreen8.jsp</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Thống kê bán vé của suất chiếu</h1>
        <div class="panel-body">
            <p>
                Suất chiếu: <strong><%= Html8.escape(showtimeTime) %></strong>,
                phòng <strong><%= Html8.escape(roomId) %></strong>
                <% if (!showtimeDate.isEmpty()) { %>
                — ngày <strong><%= Html8.escape(DateUtil8.formatDmy(showtime.getDate())) %></strong>
                <% } %>
            </p>

            <% if (outNotice != null) { %>
            <div class="alert <%= noticeIsError ? "error" : "" %>"><%= Html8.escape(outNotice) %></div>
            <% } %>

            <% if (listTicketSales.length > 0) { %>
            <table class="table" id="outTicketTable">
                <thead>
                <tr>
                    <th style="width: 60px;">TT</th>
                    <th style="width: 100px;">Mã vé</th>
                    <th style="width: 100px;">Ghế</th>
                    <th style="width: 130px;">Giá vé</th>
                    <th>Khách hàng</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (int i = 0; i < listTicketSales.length; i++) {
                        Ticket8 selectedTicket = listTicketSales[i];
                        String buyer = "";
                        if (selectedTicket.getCustomer() != null
                                && selectedTicket.getCustomer().getFullName() != null) {
                            buyer = selectedTicket.getCustomer().getFullName().getFullName();
                        }
                %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= selectedTicket.getId() %></td>
                    <td><%= Html8.escape(selectedTicket.getSeat()) %></td>
                    <td class="num"><%= Money8.format(selectedTicket.getPrice()) %></td>
                    <td><%= Html8.escape(buyer) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <% } %>

            <form method="post" action="<%= ctx %>/view/managementstaff/MovieShowtimeStatisticsScreen8.jsp" class="actions">
                <input type="hidden" name="idMovie" value="<%= Html8.escape(idMovie) %>">
                <input type="hidden" name="movieName" value="<%= Html8.escape(movieName) %>">
                <input type="hidden" name="startDate" value="<%= Html8.escape(startDate) %>">
                <input type="hidden" name="endDate" value="<%= Html8.escape(endDate) %>">
                <button class="btn" type="submit" name="subBack" value="1">Quay lại</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
