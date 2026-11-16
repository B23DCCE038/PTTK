package dao;

import model.Customer8;
import model.FullName8;
import model.ManagementStaff8;
import model.Member8;
import model.Seller8;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Reads a member account for login and returns it as its concrete role.
 *
 * Passwords are stored as plain text, so the comparison is plain too.
 */
public class MemberDAO8 extends DAO8 {

    private static final String LOGIN =
            "SELECT m.id, m.username, m.phone, m.role, "
            + "f.id AS fullNameId, f.surname, f.middleName, f.givenName "
            + "FROM tblMember m "
            + "JOIN tblFullName f ON f.id = m.tblFullNameid "
            + "WHERE m.username = ? AND m.password = ?";

    public MemberDAO8() {
        super();
    }

    /**
     * Returns the concrete Member role (ManagementStaff8, Seller8 or Customer8)
     * built from tblMember and tblFullName, or null when the username/password
     * pair does not match or the role is not one of the three known values.
     */
    public Member8 login(String username, String password) {
        synchronized (DB_LOCK) {
            try (PreparedStatement ps = getCon().prepareStatement(LOGIN)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        return null;
                    }

                    String role = rs.getString("role");
                    Member8 member;
                    if ("Management staff".equalsIgnoreCase(role)) {
                        member = new ManagementStaff8();
                    } else if ("Seller".equalsIgnoreCase(role)) {
                        member = new Seller8();
                    } else if ("Customer".equalsIgnoreCase(role)) {
                        member = new Customer8();
                    } else {
                        return null;
                    }

                    member.setId(rs.getInt("id"));
                    member.setUsername(rs.getString("username"));
                    member.setPhone(rs.getString("phone"));
                    member.setRole(role);

                    FullName8 fullName = new FullName8();
                    fullName.setId(rs.getInt("fullNameId"));
                    fullName.setSurname(rs.getString("surname"));
                    fullName.setMiddleName(rs.getString("middleName"));
                    fullName.setGivenName(rs.getString("givenName"));
                    member.setFullName(fullName);

                    return member;
                }
            } catch (SQLException ex) {
                throw new IllegalStateException("Cannot log in as " + username, ex);
            }
        }
    }
}
