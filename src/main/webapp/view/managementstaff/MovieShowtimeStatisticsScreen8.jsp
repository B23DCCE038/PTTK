<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Movie8" %>
<%@ page import="model.ShowtimeStatistics8" %>
<%@ page import="dao.ShowtimeStatisticsDAO8" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="/WEB-INF/jspf/_requireManagement8.jspf" %>
<%@ include file="/WEB-INF/jspf/common8.jspf" %>
<%
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

    Date startDate = parseIso8(request.getParameter("startDate"),
            parseIso8("2026-01-01", new Date()));
    Date endDate = parseIso8(request.getParameter("endDate"),
            parseIso8("2026-03-31", new Date()));

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

    request.setAttribute("movie", movie);
    request.setAttribute("startDate", startDate);
    request.setAttribute("endDate", endDate);
    request.setAttribute("listShowtimeStatistics", listShowtimeStatistics);
    request.setAttribute("outNotice", outNotice);
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
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
    <span>MovieShowtimeStatisticsScreen8.jsp</span>
</header>

<hr>

<main>
    <section>
        <h1>Thống kê suất chiếu của phim</h1>
        <p>Phim: <strong><c:out value="${movie.name}"/></strong></p>
        <fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" var="startIso"/>
        <fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="endIso"/>

        <c:if test="${not empty outNotice}">
        <div><c:out value="${outNotice}"/></div>
        </c:if>

        <c:if test="${not empty listShowtimeStatistics}">
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
            <c:forEach items="${listShowtimeStatistics}" var="selectedShowtime" varStatus="status">
                <fmt:formatDate value="${selectedShowtime.date}" pattern="yyyy-MM-dd" var="rowDateIso"/>
                <fmt:formatDate value="${selectedShowtime.startTime}" pattern="HH:mm" var="rowTime"/>
                <c:set var="roomId" value="${empty selectedShowtime.room ? 0 : selectedShowtime.room.id}"/>
                <c:url var="ticketSalesUrl"
                       value="/view/managementstaff/ShowtimeTicketSalesScreen8.jsp">
                    <c:param name="idShowtime" value="${selectedShowtime.id}"/>
                    <c:param name="showtimeDate" value="${rowDateIso}"/>
                    <c:param name="showtimeTime" value="${rowTime}"/>
                    <c:param name="roomId" value="${roomId}"/>
                    <c:param name="idMovie" value="${movie.id}"/>
                    <c:param name="movieName" value="${movie.name}"/>
                    <c:param name="startDate" value="${startIso}"/>
                    <c:param name="endDate" value="${endIso}"/>
                </c:url>
                <tr>
                    <td>${status.count}</td>
                    <td><fmt:formatDate value="${selectedShowtime.date}" pattern="dd/MM/yyyy"/></td>
                    <td>
                        <a id="subSelectShowtime" href="${fn:escapeXml(ticketSalesUrl)}">
                            <c:out value="${rowTime}"/>
                        </a>
                    </td>
                    <td>P.${roomId}</td>
                    <td>${selectedShowtime.ticketsSold}</td>
                    <td><fmt:formatNumber value="${selectedShowtime.revenue}" pattern="#,##0"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/view/managementstaff/MovieStatisticsScreen8.jsp">
            <input type="hidden" name="inStartDate" value="${startIso}">
            <input type="hidden" name="inEndDate" value="${endIso}">
            <button type="submit" name="subBack" value="1">Quay lại</button>
        </form>
    </section>
</main>
</body>
</html>
