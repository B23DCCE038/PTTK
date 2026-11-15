package model;

public class Movie8 {
    private int id;
    private String name;
    private String description;
    private String coverImage;
    private int length;
    private float price;
    private Showtime8[] showtimes;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Showtime8[] getShowtimes() {
        return showtimes;
    }

    public void setShowtimes(Showtime8[] showtimes) {
        this.showtimes = showtimes;
    }
}
