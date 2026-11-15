package util;

import model.FullName8;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class NameParser8Test {

    @Test
    void splitsThreePartVietnameseName() {
        FullName8 name = NameParser8.parse("Nguyễn Văn A");
        assertEquals("Nguyễn", name.getSurname());
        assertEquals("Văn", name.getMiddleName());
        assertEquals("A", name.getGivenName());
        assertEquals("Nguyễn Văn A", name.getFullName());
    }

    @Test
    void keepsSeveralMiddleTokens() {
        FullName8 name = NameParser8.parse("Nguyễn Thị Thu Hà");
        assertEquals("Nguyễn", name.getSurname());
        assertEquals("Thị Thu", name.getMiddleName());
        assertEquals("Hà", name.getGivenName());
    }

    @Test
    void handlesTwoPartAndOnePartNames() {
        FullName8 two = NameParser8.parse("Trần B");
        assertEquals("Trần", two.getSurname());
        assertEquals("", two.getMiddleName());
        assertEquals("B", two.getGivenName());

        FullName8 one = NameParser8.parse("An");
        assertEquals("", one.getSurname());
        assertEquals("", one.getMiddleName());
        assertEquals("An", one.getGivenName());
    }

    @Test
    void normalizesWhitespaceAndNull() {
        FullName8 spaced = NameParser8.parse("  Trần   Thị   B  ");
        assertEquals("Trần", spaced.getSurname());
        assertEquals("Thị", spaced.getMiddleName());
        assertEquals("B", spaced.getGivenName());

        FullName8 empty = NameParser8.parse(null);
        assertEquals("", empty.getFullName());
    }
}
