package util;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class Html8Test {

    @Test
    void escapesMarkupAndQuotes() {
        assertEquals("&lt;a&gt;&amp;&quot;&#39;", Html8.escape("<a>&\"'"));
    }

    @Test
    void nullBecomesEmptyString() {
        assertEquals("", Html8.escape(null));
    }
}
