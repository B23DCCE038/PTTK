package util;

import model.FullName8;

/**
 * Splits the full-name string entered on the registration form into the three
 * parts of FullName8: surname, middle name and given name.
 *
 * Examples:
 *   "Nguyễn Văn A"    -> Nguyễn / Văn / A
 *   "Trần Thị B"      -> Trần / Thị / B
 *   "An"              -> "" / "" / An
 */
public final class NameParser8 {

    private NameParser8() {
    }

    public static FullName8 parse(String fullName) {
        FullName8 result = new FullName8();
        if (fullName == null) {
            result.setSurname("");
            result.setMiddleName("");
            result.setGivenName("");
            return result;
        }

        String normalized = fullName.trim().replaceAll("\\s+", " ");
        if (normalized.isEmpty()) {
            result.setSurname("");
            result.setMiddleName("");
            result.setGivenName("");
            return result;
        }

        String[] parts = normalized.split(" ");
        if (parts.length == 1) {
            result.setSurname("");
            result.setMiddleName("");
            result.setGivenName(parts[0]);
            return result;
        }
        if (parts.length == 2) {
            result.setSurname(parts[0]);
            result.setMiddleName("");
            result.setGivenName(parts[1]);
            return result;
        }

        result.setSurname(parts[0]);
        result.setGivenName(parts[parts.length - 1]);
        StringBuilder middle = new StringBuilder();
        for (int i = 1; i < parts.length - 1; i++) {
            if (middle.length() > 0) {
                middle.append(' ');
            }
            middle.append(parts[i]);
        }
        result.setMiddleName(middle.toString());
        return result;
    }
}
