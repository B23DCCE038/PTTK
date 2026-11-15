package util;

import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/** Date helpers used by the JSP boundary classes and the DAO layer. */
public final class DateUtil8 {

    private DateUtil8() {
    }

    public static Date parseIso(String value, Date fallback) {
        return parse(value, "yyyy-MM-dd", fallback);
    }

    public static Date parseDmy(String value, Date fallback) {
        return parse(value, "dd/MM/yyyy", fallback);
    }

    public static String toIso(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat("yyyy-MM-dd").format(date);
    }

    public static String formatDmy(Date date) {
        if (date == null) {
            return "";
        }
        return new SimpleDateFormat("dd/MM/yyyy").format(date);
    }

    public static String formatTime(Time time) {
        if (time == null) {
            return "";
        }
        return new SimpleDateFormat("HH:mm").format(time);
    }

    private static Date parse(String value, String pattern, Date fallback) {
        if (value == null || value.trim().isEmpty()) {
            return fallback;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        sdf.setLenient(false);
        try {
            return sdf.parse(value.trim());
        } catch (ParseException ex) {
            return fallback;
        }
    }
}
