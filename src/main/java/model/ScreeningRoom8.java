package model;

public class ScreeningRoom8 {
    private int id;
    private int seatCount;
    private Showtime8[] showtimes;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSeatCount() {
        return seatCount;
    }

    public void setSeatCount(int seatCount) {
        this.seatCount = seatCount;
    }

    public Showtime8[] getShowtimes() {
        return showtimes;
    }

    public void setShowtimes(Showtime8[] showtimes) {
        this.showtimes = showtimes;
    }
}
