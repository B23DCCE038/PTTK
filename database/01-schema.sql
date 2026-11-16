DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE cinema;

CREATE TABLE tblFullName (
    id INT AUTO_INCREMENT PRIMARY KEY,
    surname VARCHAR(255) NOT NULL,
    middleName VARCHAR(255) NOT NULL DEFAULT '',
    givenName VARCHAR(255) NOT NULL
);

CREATE TABLE tblMember (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    tblFullNameid INT NOT NULL,
    UNIQUE KEY uk_member_username (username),
    UNIQUE KEY uk_member_fullname (tblFullNameid),
    CONSTRAINT fk_member_fullname FOREIGN KEY (tblFullNameid)
        REFERENCES tblFullName (id)
);

CREATE TABLE tblCustomer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tblMemberid INT NOT NULL,
    UNIQUE KEY uk_customer_member (tblMemberid),
    CONSTRAINT fk_customer_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
);

CREATE TABLE tblSeller (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tblMemberid INT NOT NULL,
    UNIQUE KEY uk_seller_member (tblMemberid),
    CONSTRAINT fk_seller_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
);

CREATE TABLE tblManagementStaff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tblMemberid INT NOT NULL,
    UNIQUE KEY uk_staff_member (tblMemberid),
    CONSTRAINT fk_staff_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
);

CREATE TABLE tblAddress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    houseNumber VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    ward VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

CREATE TABLE tblTheater (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    tblAddressid INT NOT NULL,
    UNIQUE KEY uk_theater_address (tblAddressid),
    CONSTRAINT fk_theater_address FOREIGN KEY (tblAddressid)
        REFERENCES tblAddress (id)
);

CREATE TABLE tblScreeningRoom (
    id INT AUTO_INCREMENT PRIMARY KEY,
    seatCount INT NOT NULL,
    tblTheaterid INT NOT NULL,
    CONSTRAINT fk_room_theater FOREIGN KEY (tblTheaterid)
        REFERENCES tblTheater (id)
);

CREATE TABLE tblMovie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL DEFAULT '',
    coverImage VARCHAR(255) NOT NULL DEFAULT '',
    length INT NOT NULL,
    price FLOAT NOT NULL
);

CREATE TABLE tblShowtime (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    tblMovieid INT NOT NULL,
    tblScreeningRoomid INT NOT NULL,
    CONSTRAINT fk_showtime_movie FOREIGN KEY (tblMovieid)
        REFERENCES tblMovie (id),
    CONSTRAINT fk_showtime_room FOREIGN KEY (tblScreeningRoomid)
        REFERENCES tblScreeningRoom (id)
);

CREATE TABLE tblBooking (
    id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(255) NOT NULL,
    createdAt DATETIME NOT NULL,
    expiresAt DATETIME NOT NULL,
    tblShowtimeid INT NOT NULL,
    CONSTRAINT fk_booking_showtime FOREIGN KEY (tblShowtimeid)
        REFERENCES tblShowtime (id)
);

CREATE TABLE tblPayment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount FLOAT NOT NULL,
    method VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    paidAt DATETIME NULL,
    tblBookingid INT NOT NULL,
    UNIQUE KEY uk_payment_booking (tblBookingid),
    CONSTRAINT fk_payment_booking FOREIGN KEY (tblBookingid)
        REFERENCES tblBooking (id)
);

CREATE TABLE tblMembership (
    id INT AUTO_INCREMENT PRIMARY KEY,
    issueDate DATE NOT NULL,
    tblCustomerid INT NOT NULL,
    UNIQUE KEY uk_membership_customer (tblCustomerid),
    CONSTRAINT fk_membership_customer FOREIGN KEY (tblCustomerid)
        REFERENCES tblCustomer (id)
);

CREATE TABLE tblTicket (
    id INT AUTO_INCREMENT PRIMARY KEY,
    price FLOAT NOT NULL,
    purchasePlace VARCHAR(255) NOT NULL,
    seat VARCHAR(255) NOT NULL,
    tblShowtimeid INT NOT NULL,
    tblBookingid INT NOT NULL,
    tblCustomerid INT NULL,
    tblSellerid INT NULL,
    UNIQUE KEY uk_ticket_showtime_seat (tblShowtimeid, seat),
    CONSTRAINT fk_ticket_showtime FOREIGN KEY (tblShowtimeid)
        REFERENCES tblShowtime (id),
    CONSTRAINT fk_ticket_booking FOREIGN KEY (tblBookingid)
        REFERENCES tblBooking (id),
    CONSTRAINT fk_ticket_customer FOREIGN KEY (tblCustomerid)
        REFERENCES tblCustomer (id),
    CONSTRAINT fk_ticket_seller FOREIGN KEY (tblSellerid)
        REFERENCES tblSeller (id)
);
