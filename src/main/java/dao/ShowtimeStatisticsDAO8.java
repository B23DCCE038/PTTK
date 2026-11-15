package dao;

import model.Movie8;
import model.ScreeningRoom8;
import model.Showtime8;
import model.ShowtimeStatistics8;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/** Showtime statistics of one movie in a period (report section X.3b). */
public class ShowtimeStatisticsDAO8 extends DAO8 {

    public ShowtimeStatisticsDAO8() {
        super();
    }

    /**
     * One row for every showtime of the movie in the period, including
     * showtimes with no paid ticket (ticketsSold = 0, revenue = 0).
     */
    public ShowtimeStatistics8[] getShowtimeStatistics8(int idMovie, Date startDate, Date endDate) {
        synchronized (DB_LOCK) {
            String sql =
                    "SELECT s.id, s.date AS showDate, s.startTime, s.endTime, "
                            + "       r.id AS roomId, r.seatCount, "
                            + "       m.id AS movieId, m.name AS movieName, "
                            + "       COUNT(t.id) AS ticketsSold, "
                            + "       COALESCE(SUM(t.price), 0) AS revenue "
                            + "FROM tblShowtime s "
                            + "JOIN tblScreeningRoom r ON r.id = s.tblScreeningRoomid "
                            + "JOIN tblMovie m ON m.id = s.tblMovieid "
                            + "LEFT JOIN tblBooking b ON b.tblShowtimeid = s.id AND b.status = 'Paid' "
                            + "LEFT JOIN tblTicket t ON t.tblBookingid = b.id AND t.tblShowtimeid = s.id "
                            + "WHERE s.tblMovieid = ? AND s.date BETWEEN ? AND ? "
                            + "GROUP BY s.id, s.date, s.startTime, s.endTime, r.id, r.seatCount, m.id, m.name "
                            + "ORDER BY s.date, s.startTime";

            List<ShowtimeStatistics8> result = new ArrayList<>();
            try (PreparedStatement ps = getCon().prepareStatement(sql)) {
                ps.setInt(1, idMovie);
                ps.setDate(2, startOrMin(startDate));
                ps.setDate(3, endOrMax(endDate));
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Movie8 movie = new Movie8();
                        movie.setId(rs.getInt("movieId"));
                        movie.setName(rs.getString("movieName"));

                        ScreeningRoom8 room = new ScreeningRoom8();
                        room.setId(rs.getInt("roomId"));
                        room.setSeatCount(rs.getInt("seatCount"));

                        Showtime8 showtime = new Showtime8();
                        showtime.setId(rs.getInt("id"));
                        showtime.setDate(rs.getDate("showDate"));
                        showtime.setStartTime(rs.getTime("startTime"));
                        showtime.setEndTime(rs.getTime("endTime"));
                        showtime.setMovie(movie);
                        showtime.setRoom(room);

                        result.add(new ShowtimeStatistics8(
                                showtime,
                                rs.getInt("ticketsSold"),
                                rs.getFloat("revenue")));
                    }
                }
            } catch (SQLException ex) {
                throw new IllegalStateException("Cannot load showtime statistics", ex);
            }
            return result.toArray(new ShowtimeStatistics8[0]);
        }
    }
}
