package model;

public class ShowtimeStatistics8 extends Showtime8 {
    private int ticketsSold;
    private float revenue;

    public ShowtimeStatistics8() {
        super();
    }

    public ShowtimeStatistics8(Showtime8 showtime, int ticketsSold, float revenue) {
        if (showtime != null) {
            setId(showtime.getId());
            setDate(showtime.getDate());
            setStartTime(showtime.getStartTime());
            setEndTime(showtime.getEndTime());
            setMovie(showtime.getMovie());
            setRoom(showtime.getRoom());
            setTickets(showtime.getTickets());
            setBookings(showtime.getBookings());
        }
        this.ticketsSold = ticketsSold;
        this.revenue = revenue;
    }

    public int getTicketsSold() {
        return ticketsSold;
    }

    public void setTicketsSold(int ticketsSold) {
        this.ticketsSold = ticketsSold;
    }

    public float getRevenue() {
        return revenue;
    }

    public void setRevenue(float revenue) {
        this.revenue = revenue;
    }
}
