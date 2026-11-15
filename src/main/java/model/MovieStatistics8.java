package model;

public class MovieStatistics8 extends Movie8 {
    private int ticketsSold;
    private float revenue;

    public MovieStatistics8() {
        super();
    }

    public MovieStatistics8(Movie8 movie, int ticketsSold, float revenue) {
        if (movie != null) {
            setId(movie.getId());
            setName(movie.getName());
            setDescription(movie.getDescription());
            setCoverImage(movie.getCoverImage());
            setLength(movie.getLength());
            setPrice(movie.getPrice());
            setShowtimes(movie.getShowtimes());
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
