package model;

import java.util.Date;

public class Membership8 {
    private int id;
    private Date issueDate;
    private Customer8 customer;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Customer8 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer8 customer) {
        this.customer = customer;
    }
}
