package model;

import java.util.Date;
import java.sql.Time;

public class Showtime8 {
    private int id;
    private Date date;
    private Time startTime;
    private Time endTime;
    private Movie8 movie;
    private ScreeningRoom8 room;
    private Ticket8[] tickets;
    private Booking8[] bookings;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public Movie8 getMovie() {
        return movie;
    }

    public void setMovie(Movie8 movie) {
        this.movie = movie;
    }

    public ScreeningRoom8 getRoom() {
        return room;
    }

    public void setRoom(ScreeningRoom8 room) {
        this.room = room;
    }

    public Ticket8[] getTickets() {
        return tickets;
    }

    public void setTickets(Ticket8[] tickets) {
        this.tickets = tickets;
    }

    public Booking8[] getBookings() {
        return bookings;
    }

    public void setBookings(Booking8[] bookings) {
        this.bookings = bookings;
    }
}
