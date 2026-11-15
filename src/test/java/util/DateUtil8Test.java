package util;

import org.junit.jupiter.api.Test;

import java.sql.Time;
import java.util.Date;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;

class DateUtil8Test {

    @Test
    void parsesAndFormatsIsoDate() {
        Date date = DateUtil8.parseIso("2026-01-01", null);
        assertNotNull(date);
        assertEquals("2026-01-01", DateUtil8.toIso(date));
        assertEquals("01/01/2026", DateUtil8.formatDmy(date));
    }

    @Test
    void parsesDmyDate() {
        Date date = DateUtil8.parseDmy("31/03/2026", null);
        assertNotNull(date);
        assertEquals("2026-03-31", DateUtil8.toIso(date));
    }

    @Test
    void returnsFallbackForInvalidOrEmptyInput() {
        Date fallback = DateUtil8.parseIso("2026-01-01", null);
        assertSame(fallback, DateUtil8.parseIso("not-a-date", fallback));
        assertSame(fallback, DateUtil8.parseIso("", fallback));
        assertSame(fallback, DateUtil8.parseIso(null, fallback));
    }

    @Test
    void formatsSqlTimeAsHoursAndMinutes() {
        assertEquals("09:05", DateUtil8.formatTime(Time.valueOf("09:05:00")));
        assertEquals("", DateUtil8.formatTime(null));
    }
}
