package dao;

import model.Customer8;
import model.FullName8;
import model.Showtime8;
import model.Ticket8;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/** Ticket-sales detail of one showtime (report section X.3b). */
public class TicketDAO8 extends DAO8 {

    public TicketDAO8() {
        super();
    }

    /**
     * Returns the paid tickets of one showtime. The LEFT JOINs keep a ticket
     * sold at the counter without a customer account; its customer field is
     * null and the screen shows an empty buyer cell.
     */
    public Ticket8[] getTicketSales8(int idShowtime) {
        synchronized (DB_LOCK) {
            String sql =
                    "SELECT t.id, t.price, t.purchasePlace, t.seat, "
                            + "       c.id AS customerId, "
                            + "       m.id AS memberId, m.username, m.phone, "
                            + "       f.id AS fullNameId, f.surname, f.middleName, f.givenName "
                            + "FROM tblTicket t "
                            + "JOIN tblBooking b ON b.id = t.tblBookingid AND b.status = 'Paid' "
                            + "LEFT JOIN tblCustomer c ON c.id = t.tblCustomerid "
                            + "LEFT JOIN tblMember m ON m.id = c.tblMemberid "
                            + "LEFT JOIN tblFullName f ON f.id = m.tblFullNameid "
                            + "WHERE t.tblShowtimeid = ? "
                            + "ORDER BY t.seat";

            List<Ticket8> result = new ArrayList<>();
            try (PreparedStatement ps = getCon().prepareStatement(sql)) {
                ps.setInt(1, idShowtime);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Ticket8 ticket = new Ticket8();
                        ticket.setId(rs.getInt("id"));
                        ticket.setPrice(rs.getFloat("price"));
                        ticket.setPurchasePlace(rs.getString("purchasePlace"));
                        ticket.setSeat(rs.getString("seat"));

                        Showtime8 showtime = new Showtime8();
                        showtime.setId(idShowtime);
                        ticket.setShowtime(showtime);

                        int customerId = rs.getInt("customerId");
                        if (!rs.wasNull()) {
                            Customer8 customer = new Customer8();
                            customer.setId(customerId);
                            customer.setUsername(rs.getString("username"));
                            customer.setPhone(rs.getString("phone"));
                            customer.setRole("Customer");

                            int fullNameId = rs.getInt("fullNameId");
                            if (!rs.wasNull()) {
                                FullName8 fullName = new FullName8();
                                fullName.setId(fullNameId);
                                fullName.setSurname(rs.getString("surname"));
                                fullName.setMiddleName(rs.getString("middleName"));
                                fullName.setGivenName(rs.getString("givenName"));
                                customer.setFullName(fullName);
                            }
                            ticket.setCustomer(customer);
                        }
                        result.add(ticket);
                    }
                }
            } catch (SQLException ex) {
                throw new IllegalStateException("Cannot load ticket sales of showtime " + idShowtime, ex);
            }
            return result.toArray(new Ticket8[0]);
        }
    }
}
