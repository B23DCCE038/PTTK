package model;

public class FullName8 {
    private int id;
    private String surname;
    private String middleName;
    private String givenName;

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
