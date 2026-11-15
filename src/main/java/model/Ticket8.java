package model;

public class Ticket8 {
    private int id;
    private float price;
    private String purchasePlace;
    private String seat;
    private Showtime8 showtime;
    private Booking8 booking;
    private Customer8 customer;
    private Seller8 seller;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getPurchasePlace() {
        return purchasePlace;
    }

    public void setPurchasePlace(String purchasePlace) {
        this.purchasePlace = purchasePlace;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public Showtime8 getShowtime() {
        return showtime;
    }

    public void setShowtime(Showtime8 showtime) {
        this.showtime = showtime;
    }

    public Booking8 getBooking() {
        return booking;
    }

    public void setBooking(Booking8 booking) {
        this.booking = booking;
    }

    public Customer8 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer8 customer) {
        this.customer = customer;
    }

    public Seller8 getSeller() {
        return seller;
    }

    public void setSeller(Seller8 seller) {
        this.seller = seller;
    }
}
