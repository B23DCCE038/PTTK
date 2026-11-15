package model;

import java.util.Date;

public class Booking8 {
    private int id;
    private String status;
    private Date createdAt;
    private Date expiresAt;
    private Showtime8 showtime;
    private Ticket8[] tickets;
    private Payment8 payment;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Showtime8 getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime8 showtime) {
        this.showtime = showtime;
    }

    public Ticket8[] getTickets() {
        return tickets;
    }

    public void setTickets(Ticket8[] tickets) {
        this.tickets = tickets;
    }

    public Payment8 getPayment() {
        return payment;
    }

    public void setPayment(Payment8 payment) {
        this.payment = payment;
    }
}
