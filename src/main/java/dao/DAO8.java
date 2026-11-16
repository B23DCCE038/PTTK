package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public abstract class DAO8 {

    private static Connection con;

    /** Guards the shared connection and the transactions performed on it. */
    protected static final Object DB_LOCK = new Object();

    public DAO8() {
        getCon();
    }

    protected Connection getCon() {
        synchronized (DB_LOCK) {
            try {
                if (con != null && !con.isClosed()) {
                    return con;
                }
            } catch (SQLException ignored) {
                // stale connection: reopen below
            }
            con = openConnection();
            return con;
        }
    }

    private Connection openConnection() {
        try {
            Properties props = new Properties();
            try (InputStream in = DAO8.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (in == null) {
                    throw new IllegalStateException("db.properties was not found on the classpath");
                }
                props.load(in);
            }

            String url = props.getProperty("db.url");
            String user = props.getProperty("db.user");
            String password = props.getProperty("db.password");

            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (Exception ex) {
            throw new IllegalStateException(
                    "Cannot connect to MySQL. Check that the cinema database is running and that "
                            + "src/main/resources/db.properties matches your server.", ex);
        }
    }

    protected static java.sql.Date toSqlDate(java.util.Date date) {
        return date == null ? null : new java.sql.Date(date.getTime());
    }

    protected static int generatedId(java.sql.PreparedStatement ps) throws SQLException {
        try (java.sql.ResultSet keys = ps.getGeneratedKeys()) {
            if (keys.next()) {
                return keys.getInt(1);
            }
        }
        throw new SQLException("The database did not return a generated key");
    }
}
