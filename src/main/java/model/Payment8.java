package model;

import java.util.Date;

public class Payment8 {
    private int id;
    private float amount;
    private String method;
    private String status;
    private Date paidAt;
    private Booking8 booking;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPaidAt() {
        return paidAt;
    }

    public void setPaidAt(Date paidAt) {
        this.paidAt = paidAt;
    }

    public Booking8 getBooking() {
        return booking;
    }

    public void setBooking(Booking8 booking) {
        this.booking = booking;
    }
}
