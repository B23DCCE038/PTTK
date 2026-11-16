package model;

public class FullName8 {
    private int id;
    private String surname;
    private String middleName;
    private String givenName;

    /**
     * Splits the full-name string entered on the registration form into the
     * three parts of this class.
     *
     * Examples:
     *   "Nguyễn Văn A"    -> Nguyễn / Văn / A
     *   "Trần Thị B"      -> Trần / Thị / B
     *   "An"              -> "" / "" / An
     */
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

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getMiddleName() {
        return middleName;
    }

    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    public String getGivenName() {
        return givenName;
    }

    public void setGivenName(String givenName) {
        this.givenName = givenName;
    }

    /** Convenience for the screens: joins the three parts into one display name. */
    public String getFullName() {
        StringBuilder sb = new StringBuilder();
        if (surname != null && !surname.trim().isEmpty()) {
            sb.append(surname.trim());
        }
        if (middleName != null && !middleName.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(' ');
            sb.append(middleName.trim());
        }
        if (givenName != null && !givenName.trim().isEmpty()) {
            if (sb.length() > 0) sb.append(' ');
            sb.append(givenName.trim());
        }
        return sb.toString();
    }
}
