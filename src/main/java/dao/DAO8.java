package dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Abstract DAO base. The design keeps one shared Connection for the whole
 * system (report section X.3), so the connection is opened once and reused.
 *
 * The shared connection is guarded by DB_LOCK because a single JDBC
 * Connection is not thread-safe. In a production application this would be a
 * connection pool; that is recorded as a known limitation in the report.
 */
public abstract class DAO8 {

    private static Connection con;

    /** Guards the shared connection and the transactions performed on it. */
    protected static final Object DB_LOCK = new Object();

    public DAO8() {
        getCon();
    }

    protected Connection getCon() {
        if (con == null) {
            synchronized (DB_LOCK) {
                if (con == null) {
                    con = openConnection();
                }
            }
        }
        return con;
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

            String url = env("CINEMA_DB_URL", props.getProperty("db.url"));
            String user = env("CINEMA_DB_USER", props.getProperty("db.user"));
            String password = env("CINEMA_DB_PASSWORD", props.getProperty("db.password"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(url, user, password);
        } catch (Exception ex) {
            throw new IllegalStateException(
                    "Cannot connect to MySQL. Check that the cinema database is running and that "
                            + "src/main/resources/db.properties matches your server.", ex);
        }
    }

    private static String env(String key, String fallback) {
        String value = System.getenv(key);
        return (value == null || value.trim().isEmpty()) ? fallback : value;
    }

    protected static java.sql.Date toSqlDate(java.util.Date date) {
        return date == null ? null : new java.sql.Date(date.getTime());
    }

    protected static java.sql.Date startOrMin(java.util.Date date) {
        return date == null ? java.sql.Date.valueOf("1970-01-01") : toSqlDate(date);
    }

    protected static java.sql.Date endOrMax(java.util.Date date) {
        return date == null ? java.sql.Date.valueOf("9999-12-31") : toSqlDate(date);
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
