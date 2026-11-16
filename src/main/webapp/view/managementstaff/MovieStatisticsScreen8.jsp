<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.MovieStatistics8" %>
<%@ page import="dao.MovieStatisticsDAO8" %>
<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ include file="/WEB-INF/jspf/_requireManagement8.jspf" %>
<%@ include file="/WEB-INF/jspf/common8.jspf" %>
<%
    Date defaultStart = parseIso8("2026-01-01", new Date());
    Date defaultEnd = parseIso8("2026-03-31", new Date());
    Date inStartDate = parseIso8(request.getParameter("inStartDate"), defaultStart);
    Date inEndDate = parseIso8(request.getParameter("inEndDate"), defaultEnd);

    MovieStatistics8[] listMovieStatistics = new MovieStatistics8[0];
    String outNotice = null;

    try {
        listMovieStatistics = new MovieStatisticsDAO8().getMovieStatistics8(inStartDate, inEndDate);
    } catch (RuntimeException ex) {
        outNotice = "Không thể tải dữ liệu thống kê. Vui lòng kiểm tra kết nối MySQL.";
        application.log("MovieStatisticsScreen8 could not load data", ex);
    }
    if (outNotice == null && listMovieStatistics.length == 0) {
        outNotice = "Không có dữ liệu trong kì.";
    }

    request.setAttribute("inStartDate", inStartDate);
    request.setAttribute("inEndDate", inEndDate);
    request.setAttribute("listMovieStatistics", listMovieStatistics);
    request.setAttribute("outNotice", outNotice);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Thống kê phim</title>
</head>
<body>
<header>
    <a href="${pageContext.request.contextPath}/index.jsp">Cinema Management System</a>
</header>

<hr>

<main>
    <section>
        <h1>Thống kê phim</h1>
        <fmt:formatDate value="${inStartDate}" pattern="yyyy-MM-dd" var="startIso"/>
        <fmt:formatDate value="${inEndDate}" pattern="yyyy-MM-dd" var="endIso"/>

        <form method="get" action="${pageContext.request.contextPath}/view/managementstaff/MovieStatisticsScreen8.jsp">
            <label for="inStartDate">Kì thống kê:</label>
            <input type="date" id="inStartDate" name="inStartDate"
                   value="${startIso}">
            <span>đến</span>
            <input type="date" id="inEndDate" name="inEndDate"
                   value="${endIso}">
            <button type="submit" name="subFilter" value="1">Lọc</button>
        </form>

        <c:if test="${not empty outNotice}">
        <div><c:out value="${outNotice}"/></div>
        </c:if>

        <c:if test="${not empty listMovieStatistics}">
        <table id="outMovieTable">
            <thead>
            <tr>
                <th>TT</th>
                <th>Mã phim</th>
                <th>Tên phim</th>
                <th>Tổng vé bán</th>
                <th>Doanh thu (đồng)</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="totalTickets" value="${0}"/>
            <c:set var="totalRevenue" value="${0}"/>
            <c:forEach items="${listMovieStatistics}" var="selectedMovie" varStatus="status">
                <c:set var="totalTickets" value="${totalTickets + selectedMovie.ticketsSold}"/>
                <c:set var="totalRevenue" value="${totalRevenue + selectedMovie.revenue}"/>
                <c:url var="showtimeStatisticsUrl"
                       value="/view/managementstaff/MovieShowtimeStatisticsScreen8.jsp">
                    <c:param name="idMovie" value="${selectedMovie.id}"/>
                    <c:param name="movieName" value="${selectedMovie.name}"/>
                    <c:param name="startDate" value="${startIso}"/>
                    <c:param name="endDate" value="${endIso}"/>
                </c:url>
                <tr>
                    <td>${status.count}</td>
                    <td>${selectedMovie.id}</td>
                    <td>
                        <a id="subSelectMovie" href="${fn:escapeXml(showtimeStatisticsUrl)}">
                            <c:out value="${selectedMovie.name}"/>
                        </a>
                    </td>
                    <td>${selectedMovie.ticketsSold}</td>
                    <td><fmt:formatNumber value="${selectedMovie.revenue}" pattern="#,##0"/></td>
                </tr>
            </c:forEach>
            <tr>
                <td>—</td>
                <td>—</td>
                <td>Tổng cả kì</td>
                <td>${totalTickets}</td>
                <td><fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/></td>
            </tr>
            </tbody>
        </table>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/view/managementstaff/StatisticsTypeScreen8.jsp">
            <button type="submit" name="subBack" value="1">Quay lại</button>
        </form>
    </section>
</main>
</body>
</html>
