package util;

import java.text.NumberFormat;
import java.util.Locale;

/** Formats the money columns of the statistics screens with Vietnamese grouping. */
public final class Money8 {

    private static final Locale VI = new Locale("vi", "VN");

    private Money8() {
    }

    public static String format(float amount) {
        NumberFormat nf = NumberFormat.getNumberInstance(VI);
        nf.setMinimumFractionDigits(0);
        nf.setMaximumFractionDigits(0);
        return nf.format(amount);
    }
}
