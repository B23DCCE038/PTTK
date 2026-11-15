package model;

public class Theater8 {
    private int id;
    private String name;
    private Address8 address;
    private ScreeningRoom8[] rooms;

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

    public Address8 getAddress() {
        return address;
    }

    public void setAddress(Address8 address) {
        this.address = address;
    }

    public ScreeningRoom8[] getRooms() {
        return rooms;
    }

    public void setRooms(ScreeningRoom8[] rooms) {
        this.rooms = rooms;
    }
}
