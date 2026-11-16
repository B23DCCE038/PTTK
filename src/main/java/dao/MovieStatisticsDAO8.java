package dao;

import model.MovieStatistics8;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/** Movie statistics for a period (report section X.3b). */
public class MovieStatisticsDAO8 extends DAO8 {

    public MovieStatisticsDAO8() {
        super();
    }

    /**
     * One row for every movie that has a showtime in the period. A movie with
     * showtimes but no paid ticket is still returned with ticketsSold = 0 and
     * revenue = 0. Only tickets of bookings whose status is 'Paid' are counted.
     */
    public MovieStatistics8[] getMovieStatistics8(Date startDate, Date endDate) {
        synchronized (DB_LOCK) {
            String sql =
                    "SELECT m.id, m.name, m.description, m.coverImage, m.length, m.price, "
                            + "       COUNT(t.id) AS ticketsSold, "
                            + "       COALESCE(SUM(t.price), 0) AS revenue "
                            + "FROM tblShowtime s "
                            + "JOIN tblMovie m ON m.id = s.tblMovieid "
                            + "LEFT JOIN tblBooking b ON b.tblShowtimeid = s.id AND b.status = 'Paid' "
                            + "LEFT JOIN tblTicket t ON t.tblBookingid = b.id AND t.tblShowtimeid = s.id "
                            + "WHERE s.date BETWEEN ? AND ? "
                            + "GROUP BY m.id, m.name, m.description, m.coverImage, m.length, m.price "
                            + "ORDER BY m.id";

            List<MovieStatistics8> result = new ArrayList<>();
            try (PreparedStatement ps = getCon().prepareStatement(sql)) {
                ps.setDate(1, toSqlDate(startDate));
                ps.setDate(2, toSqlDate(endDate));
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        MovieStatistics8 movie = new MovieStatistics8();
                        movie.setId(rs.getInt("id"));
                        movie.setName(rs.getString("name"));
                        movie.setDescription(rs.getString("description"));
                        movie.setCoverImage(rs.getString("coverImage"));
                        movie.setLength(rs.getInt("length"));
                        movie.setPrice(rs.getFloat("price"));
                        movie.setTicketsSold(rs.getInt("ticketsSold"));
                        movie.setRevenue(rs.getFloat("revenue"));
                        result.add(movie);
                    }
                }
            } catch (SQLException ex) {
                throw new IllegalStateException("Cannot load movie statistics", ex);
            }
            return result.toArray(new MovieStatistics8[0]);
        }
    }
}
