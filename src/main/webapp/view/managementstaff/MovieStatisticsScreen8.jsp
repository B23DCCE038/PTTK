<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.MovieStatistics8" %>
<%@ page import="dao.MovieStatisticsDAO8" %>
<%@ page import="util.DateUtil8" %>
<%@ page import="util.Html8" %>
<%@ page import="util.Money8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.net.URLEncoder" %>
<%
    String ctx = request.getContextPath();

    Date defaultStart = DateUtil8.parseIso("2026-01-01", new Date());
    Date defaultEnd = DateUtil8.parseIso("2026-03-31", new Date());
    Date inStartDate = DateUtil8.parseIso(request.getParameter("inStartDate"), defaultStart);
    Date inEndDate = DateUtil8.parseIso(request.getParameter("inEndDate"), defaultEnd);

    MovieStatistics8[] listMovieStatistics = new MovieStatistics8[0];
    String outNotice = null;
    boolean noticeIsError = false;

    try {
        listMovieStatistics = new MovieStatisticsDAO8().getMovieStatistics8(inStartDate, inEndDate);
    } catch (RuntimeException ex) {
        outNotice = "Không thể tải dữ liệu thống kê. Vui lòng kiểm tra kết nối MySQL.";
        noticeIsError = true;
        application.log("MovieStatisticsScreen8 could not load data", ex);
    }
    if (outNotice == null && listMovieStatistics.length == 0) {
        outNotice = "Không có dữ liệu trong kì.";
    }

    String startIso = DateUtil8.toIso(inStartDate);
    String endIso = DateUtil8.toIso(inEndDate);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thống kê phim</title>
    <link rel="stylesheet" href="<%= ctx %>/css/style.css">
</head>
<body>
<header class="topbar">
    <a class="brand" href="<%= ctx %>/index.jsp">Cinema Management System</a>
    <span class="meta">MovieStatisticsScreen8.jsp</span>
</header>

<main class="container">
    <section class="panel">
        <h1 class="panel-title">Thống kê phim</h1>
        <div class="panel-body">
            <form class="filter" method="get" action="<%= ctx %>/view/managementstaff/MovieStatisticsScreen8.jsp">
                <label for="inStartDate">Kì thống kê:</label>
                <input class="input" type="date" id="inStartDate" name="inStartDate"
                       value="<%= startIso %>">
                <span class="label">đến</span>
                <input class="input" type="date" id="inEndDate" name="inEndDate"
                       value="<%= endIso %>">
                <button class="btn" type="submit" name="subFilter" value="1">Lọc</button>
            </form>

            <% if (outNotice != null) { %>
            <div class="alert <%= noticeIsError ? "error" : "" %>"><%= Html8.escape(outNotice) %></div>
            <% } %>

            <% if (listMovieStatistics.length > 0) { %>
            <table class="table" id="outMovieTable">
                <thead>
                <tr>
                    <th style="width: 60px;">TT</th>
                    <th style="width: 110px;">Mã phim</th>
                    <th>Tên phim</th>
                    <th style="width: 150px;">Tổng vé bán</th>
                    <th style="width: 190px;">Doanh thu (đồng)</th>
                </tr>
                </thead>
                <tbody>
                <%
                    long totalTickets = 0L;
                    float totalRevenue = 0f;
                    for (int i = 0; i < listMovieStatistics.length; i++) {
                        MovieStatistics8 selectedMovie = listMovieStatistics[i];
                        totalTickets += selectedMovie.getTicketsSold();
                        totalRevenue += selectedMovie.getRevenue();
                        String movieNameEnc = URLEncoder.encode(
                                selectedMovie.getName() == null ? "" : selectedMovie.getName(), "UTF-8");
                %>
                <tr>
                    <td><%= i + 1 %></td>
                    <td><%= selectedMovie.getId() %></td>
                    <td>
                        <a href="<%= ctx %>/view/managementstaff/MovieShowtimeStatisticsScreen8.jsp?idMovie=<%= selectedMovie.getId() %>&amp;movieName=<%= movieNameEnc %>&amp;startDate=<%= startIso %>&amp;endDate=<%= endIso %>">
                            <%= Html8.escape(selectedMovie.getName()) %>
                        </a>
                    </td>
                    <td class="num"><%= selectedMovie.getTicketsSold() %></td>
                    <td class="num"><%= Money8.format(selectedMovie.getRevenue()) %></td>
                </tr>
                <% } %>
                <tr class="total">
                    <td>—</td>
                    <td>—</td>
                    <td>Tổng cả kì</td>
                    <td class="num"><%= totalTickets %></td>
                    <td class="num"><%= Money8.format(totalRevenue) %></td>
                </tr>
                </tbody>
            </table>
            <% } %>

            <form method="post" action="<%= ctx %>/view/managementstaff/StatisticsTypeScreen8.jsp" class="actions">
                <button class="btn" type="submit" name="subBack" value="1">Quay lại</button>
            </form>
        </div>
    </section>
</main>
</body>
</html>
