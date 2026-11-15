package util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class Money8Test {

    @Test
    void usesVietnameseThousandsSeparator() {
        assertEquals("450.000", Money8.format(450000f));
        assertEquals("1.020.000", Money8.format(1020000f));
    }

    @Test
    void formatsZero() {
        assertEquals("0", Money8.format(0f));
    }
}
