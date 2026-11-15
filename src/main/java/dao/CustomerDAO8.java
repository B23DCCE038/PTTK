package dao;

import model.Customer8;
import model.FullName8;
import model.Ticket8;
import util.NameParser8;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/** Data access for the member-registration module (report section X.3a). */
public class CustomerDAO8 extends DAO8 {

    public CustomerDAO8() {
        super();
    }

    /** Returns true when tblMember already contains the username. */
    public boolean checkUsernameExists8(String username) {
        synchronized (DB_LOCK) {
            String sql = "SELECT 1 FROM tblMember WHERE username = ?";
            try (PreparedStatement ps = getCon().prepareStatement(sql)) {
                ps.setString(1, username);
                try (ResultSet rs = ps.executeQuery()) {
                    return rs.next();
                }
            } catch (SQLException ex) {
                throw new IllegalStateException("Cannot check username " + username, ex);
            }
        }
    }

    /**
     * Inserts one row into tblFullName, tblMember and tblCustomer inside one
     * transaction and returns the saved Customer8. The full name string is
     * split into the three parts of FullName8 before it is written.
     */
    public Customer8 addCustomer8(String username, String password, String fullName, String phone) {
        synchronized (DB_LOCK) {
            Connection conn = getCon();
            boolean previousAutoCommit = true;
            try {
                previousAutoCommit = conn.getAutoCommit();
                conn.setAutoCommit(false);

                FullName8 fullName8 = NameParser8.parse(fullName);

                String sqlFullName = "INSERT INTO tblFullName (surname, middleName, givenName) VALUES (?, ?, ?)";
                int fullNameId;
                try (PreparedStatement ps = conn.prepareStatement(sqlFullName, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, fullName8.getSurname());
                    ps.setString(2, fullName8.getMiddleName());
                    ps.setString(3, fullName8.getGivenName());
                    ps.executeUpdate();
                    fullNameId = generatedId(ps);
                }
                fullName8.setId(fullNameId);

                String sqlMember = "INSERT INTO tblMember (username, password, phone, role, tblFullNameid) "
                        + "VALUES (?, ?, ?, ?, ?)";
                int memberId;
                try (PreparedStatement ps = conn.prepareStatement(sqlMember, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, phone);
                    ps.setString(4, "Customer");
                    ps.setInt(5, fullNameId);
                    ps.executeUpdate();
                    memberId = generatedId(ps);
                }

                String sqlCustomer = "INSERT INTO tblCustomer (tblMemberid) VALUES (?)";
                int customerId;
                try (PreparedStatement ps = conn.prepareStatement(sqlCustomer, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, memberId);
                    ps.executeUpdate();
                    customerId = generatedId(ps);
                }

                conn.commit();

                Customer8 customer = new Customer8();
                customer.setId(customerId);
                customer.setUsername(username);
                customer.setPassword(password);
                customer.setPhone(phone);
                customer.setRole("Customer");
                customer.setFullName(fullName8);
                customer.setTickets(new Ticket8[0]);
                return customer;
            } catch (Exception ex) {
                try {
                    conn.rollback();
                } catch (SQLException ignored) {
                    // the original exception is more useful
                }
                throw new IllegalStateException("Cannot add customer " + username, ex);
            } finally {
                try {
                    conn.setAutoCommit(previousAutoCommit);
                } catch (SQLException ignored) {
                    // nothing else can be done here
                }
            }
        }
    }
}
