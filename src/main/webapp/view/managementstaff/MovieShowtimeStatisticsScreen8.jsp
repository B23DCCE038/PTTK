<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Movie8" %>
<%@ page import="model.ShowtimeStatistics8" %>
<%@ page import="dao.ShowtimeStatisticsDAO8" %>
<%@ page import="util.DateUtil8" %>
<%@ page import="util.Html8" %>
<%@ page import="util.Money8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String ctx = request.getContextPath();

    int idMovie = 0;
    try {
        idMovie = Integer.parseInt(request.getParameter("idMovie"));
    } catch (Exception ignored) {
        idMovie = 0;
    }

    String movieName = request.getParameter("movieName");
    if (movieName == null) {
        movieName = "";
    }

    Date startDate = DateUtil8.parseIso(request.getParameter("startDate"),
            DateUtil8.parseIso("2026-01-01", new Date()));
    Date endDate = DateUtil8.parseIso(request.getParameter("endDate"),
            DateUtil8.parseIso("2026-03-31", new Date()));

    Movie8 movie = new Movie8();
    movie.setId(idMovie);
    movie.setName(movieName);

    ShowtimeStatistics8[] listShowtimeStatistics = new ShowtimeStatistics8[0];
    String outNotice = null;

    if (idMovie > 0) {
        try {
            listShowtimeStatistics = new ShowtimeStatisticsDAO8()
                    .getShowtimeStatistics8(idMovie, startDate, endDate);
        } catch (RuntimeException ex) {
            outNotice = "Không thể tải thống kê suất chiếu. Vui lòng kiểm tra kết nối MySQL.";
            application.log("MovieShowtimeStatisticsScreen8 could not load data", ex);
        }
    }
    if (outNotice == null && listShowtimeStatistics.length == 0) {
        outNotice = "Không có suất chiếu trong kì.";
    }

    String startIso = DateUtil8.toIso(startDate);
    String endIso = DateUtil8.toIso(endDate);
    String movieNameEnc = URLEncoder.encode(movieName, "UTF-8");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thống kê suất chiếu của phim</title>
</head>
<body>
<header>
    <a href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span>MovieShowtimeStatisticsScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Thống kê suất chiếu của phim</h1>
        <p>Phim: <strong><%= Html8.escape(movieName) %></strong></p>

        <% if (outNotice != null) { %>
        <div><%= Html8.escape(outNotice) %></div>
        <% } %>

        <% if (listShowtimeStatistics.length > 0) { %>
        <table id="outShowtimeTable">
            <thead>
            <tr>
                <th>TT</th>
                <th>Ngày</th>
                <th>Giờ</th>
                <th>Phòng</th>
                <th>Vé bán</th>
                <th>Doanh thu</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (int i = 0; i < listShowtimeStatistics.length; i++) {
                    ShowtimeStatistics8 selectedShowtime = listShowtimeStatistics[i];
                    String rowDateIso = DateUtil8.toIso(selectedShowtime.getDate());
                    String rowTime = DateUtil8.formatTime(selectedShowtime.getStartTime());
                    String rowTimeEnc = URLEncoder.encode(rowTime, "UTF-8");
                    int roomId = selectedShowtime.getRoom() == null ? 0 : selectedShowtime.getRoom().getId();
            %>
            <tr>
                <td><%= i + 1 %></td>
                <td><%= DateUtil8.formatDmy(selectedShowtime.getDate()) %></td>
                <td>
                    <a href="<%= ctx %>/view/managementstaff/ShowtimeTicketSalesScreen8.jsp?idShowtime=<%= selectedShowtime.getId() %>&amp;showtimeDate=<%= rowDateIso %>&amp;showtimeTime=<%= rowTimeEnc %>&amp;roomId=<%= roomId %>&amp;idMovie=<%= idMovie %>&amp;movieName=<%= movieNameEnc %>&amp;startDate=<%= startIso %>&amp;endDate=<%= endIso %>">
                        <%= Html8.escape(rowTime) %>
                    </a>
                </td>
                <td>P.<%= roomId %></td>
                <td><%= selectedShowtime.getTicketsSold() %></td>
                <td><%= Money8.format(selectedShowtime.getRevenue()) %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>

        <form method="post" action="<%= ctx %>/view/managementstaff/MovieStatisticsScreen8.jsp">
            <input type="hidden" name="inStartDate" value="<%= startIso %>">
            <input type="hidden" name="inEndDate" value="<%= endIso %>">
            <button type="submit" name="subBack" value="1">Quay lại</button>
        </form>
    </section>
</main>
</body>
</html>
