-- Cinema Management System (đề 16) - 14 tables from uml/DatabaseDiagram.puml
-- MySQL 8.0, utf8mb4. Run before 02-seed.sql.

CREATE DATABASE IF NOT EXISTS cinema
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE cinema;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS tblTicket;
DROP TABLE IF EXISTS tblMembership;
DROP TABLE IF EXISTS tblPayment;
DROP TABLE IF EXISTS tblBooking;
DROP TABLE IF EXISTS tblShowtime;
DROP TABLE IF EXISTS tblScreeningRoom;
DROP TABLE IF EXISTS tblMovie;
DROP TABLE IF EXISTS tblTheater;
DROP TABLE IF EXISTS tblAddress;
DROP TABLE IF EXISTS tblCustomer;
DROP TABLE IF EXISTS tblSeller;
DROP TABLE IF EXISTS tblManagementStaff;
DROP TABLE IF EXISTS tblMember;
DROP TABLE IF EXISTS tblFullName;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE tblFullName (
    id INT NOT NULL AUTO_INCREMENT,
    surname VARCHAR(255) NOT NULL,
    middleName VARCHAR(255) NOT NULL DEFAULT '',
    givenName VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblMember (
    id INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL,
    tblFullNameid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_member_username (username),
    UNIQUE KEY uk_member_fullname (tblFullNameid),
    CONSTRAINT fk_member_fullname FOREIGN KEY (tblFullNameid)
        REFERENCES tblFullName (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblCustomer (
    id INT NOT NULL AUTO_INCREMENT,
    tblMemberid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_customer_member (tblMemberid),
    CONSTRAINT fk_customer_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblSeller (
    id INT NOT NULL AUTO_INCREMENT,
    tblMemberid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_seller_member (tblMemberid),
    CONSTRAINT fk_seller_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblManagementStaff (
    id INT NOT NULL AUTO_INCREMENT,
    tblMemberid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_staff_member (tblMemberid),
    CONSTRAINT fk_staff_member FOREIGN KEY (tblMemberid)
        REFERENCES tblMember (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblAddress (
    id INT NOT NULL AUTO_INCREMENT,
    houseNumber VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    ward VARCHAR(255) NOT NULL,
    district VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblTheater (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    tblAddressid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_theater_address (tblAddressid),
    CONSTRAINT fk_theater_address FOREIGN KEY (tblAddressid)
        REFERENCES tblAddress (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblScreeningRoom (
    id INT NOT NULL AUTO_INCREMENT,
    seatCount INT NOT NULL,
    tblTheaterid INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_room_theater FOREIGN KEY (tblTheaterid)
        REFERENCES tblTheater (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblMovie (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL DEFAULT '',
    coverImage VARCHAR(255) NOT NULL DEFAULT '',
    length INT NOT NULL,
    price FLOAT NOT NULL,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblShowtime (
    id INT NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    tblMovieid INT NOT NULL,
    tblScreeningRoomid INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_showtime_movie FOREIGN KEY (tblMovieid)
        REFERENCES tblMovie (id),
    CONSTRAINT fk_showtime_room FOREIGN KEY (tblScreeningRoomid)
        REFERENCES tblScreeningRoom (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblBooking (
    id INT NOT NULL AUTO_INCREMENT,
    status VARCHAR(255) NOT NULL,
    createdAt DATETIME NOT NULL,
    expiresAt DATETIME NOT NULL,
    tblShowtimeid INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_booking_showtime FOREIGN KEY (tblShowtimeid)
        REFERENCES tblShowtime (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblPayment (
    id INT NOT NULL AUTO_INCREMENT,
    amount FLOAT NOT NULL,
    method VARCHAR(255) NOT NULL,
    status VARCHAR(255) NOT NULL,
    paidAt DATETIME NULL,
    tblBookingid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_payment_booking (tblBookingid),
    CONSTRAINT fk_payment_booking FOREIGN KEY (tblBookingid)
        REFERENCES tblBooking (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblMembership (
    id INT NOT NULL AUTO_INCREMENT,
    issueDate DATE NOT NULL,
    tblCustomerid INT NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_membership_customer (tblCustomerid),
    CONSTRAINT fk_membership_customer FOREIGN KEY (tblCustomerid)
        REFERENCES tblCustomer (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE tblTicket (
    id INT NOT NULL AUTO_INCREMENT,
    price FLOAT NOT NULL,
    purchasePlace VARCHAR(255) NOT NULL,
    seat VARCHAR(255) NOT NULL,
    tblShowtimeid INT NOT NULL,
    tblBookingid INT NOT NULL,
    tblCustomerid INT NULL,
    tblSellerid INT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_ticket_showtime_seat (tblShowtimeid, seat),
    CONSTRAINT fk_ticket_showtime FOREIGN KEY (tblShowtimeid)
        REFERENCES tblShowtime (id),
    CONSTRAINT fk_ticket_booking FOREIGN KEY (tblBookingid)
        REFERENCES tblBooking (id),
    CONSTRAINT fk_ticket_customer FOREIGN KEY (tblCustomerid)
        REFERENCES tblCustomer (id),
    CONSTRAINT fk_ticket_seller FOREIGN KEY (tblSellerid)
        REFERENCES tblSeller (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
