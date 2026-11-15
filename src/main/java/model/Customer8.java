package model;

public class Customer8 extends Member8 {
    private Ticket8[] tickets;
    private Membership8 membership;

    public Ticket8[] getTickets() {
        return tickets;
    }

    public void setTickets(Ticket8[] tickets) {
        this.tickets = tickets;
    }

    public Membership8 getMembership() {
        return membership;
    }

    public void setMembership(Membership8 membership) {
        this.membership = membership;
    }
}
