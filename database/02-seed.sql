-- Demo data for the two detailed modules.
-- Period used by the default statistics filter: 01/01/2026 - 31/03/2026.
-- Expected paid-only result:
--   Tâm Cám  5 tickets / 450,000
--   Mắt Biếc 2 tickets / 170,000
--   Bố Già   5 tickets / 400,000
--   Dune     0 tickets /       0
--   total   12 tickets /1,020,000
-- The pending, cancelled and expired bookings below must not be counted.

USE cinema;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO tblFullName (id, surname, middleName, givenName) VALUES
    (1, 'Trần', 'Thị', 'B'),
    (2, 'Nguyễn', 'Văn', 'S'),
    (3, 'Nguyễn', 'Văn', 'A'),
    (4, 'Trần', 'Văn', 'C'),
    (5, 'Lê', 'Thị', 'H');

INSERT INTO tblMember (id, username, password, phone, role, tblFullNameid) VALUES
    (1, 'admin', 'admin123', '0900000001', 'Management staff', 1),
    (2, 'seller1', 'seller123', '0900000002', 'Seller', 2),
    (3, 'anv', '123456', '0912345678', 'Customer', 3),
    (4, 'tvc', '123456', '0912345679', 'Customer', 4),
    (5, 'lth', '123456', '0912345680', 'Customer', 5);

INSERT INTO tblManagementStaff (id, tblMemberid) VALUES (1, 1);
INSERT INTO tblSeller (id, tblMemberid) VALUES (1, 2);
INSERT INTO tblCustomer (id, tblMemberid) VALUES
    (1, 3),
    (2, 4),
    (3, 5);

INSERT INTO tblAddress (id, houseNumber, street, ward, district, city) VALUES
    (1, '72', 'Lê Thanh Nghị', 'Bách Khoa', 'Hai Bà Trưng', 'Hà Nội');

INSERT INTO tblTheater (id, name, tblAddressid) VALUES
    (1, 'CGV Vincom Center', 1);

INSERT INTO tblScreeningRoom (id, seatCount, tblTheaterid) VALUES
    (1, 120, 1),
    (2, 100, 1),
    (3, 80, 1);

INSERT INTO tblMovie (id, name, description, coverImage, length, price) VALUES
    (1, 'Tâm Cám', 'Phim kinh dị Việt Nam', '', 120, 90000),
    (2, 'Mắt Biếc', 'Phim tình cảm', '', 117, 85000),
    (3, 'Bố Già', 'Phim gia đình', '', 128, 80000),
    (4, 'Dune: Hành Tinh Cát', 'Phim khoa học viễn tưởng', '', 155, 95000);

INSERT INTO tblShowtime (id, date, startTime, endTime, tblMovieid, tblScreeningRoomid) VALUES
    (1, '2026-01-01', '09:00:00', '11:15:00', 1, 1),
    (2, '2026-01-01', '14:00:00', '16:15:00', 1, 2),
    (3, '2026-01-02', '10:00:00', '12:12:00', 2, 1),
    (4, '2026-01-03', '18:00:00', '20:23:00', 3, 1),
    (5, '2026-01-03', '20:30:00', '22:53:00', 3, 2),
    (6, '2026-01-04', '20:00:00', '22:50:00', 4, 3);

INSERT INTO tblBooking (id, status, createdAt, expiresAt, tblShowtimeid) VALUES
    (1, 'Paid',      '2025-12-30 10:00:00', '2025-12-30 10:15:00', 1),
    (2, 'Paid',      '2025-12-31 09:00:00', '2025-12-31 09:15:00', 2),
    (3, 'Pending',   '2026-01-01 11:00:00', '2026-01-01 11:15:00', 3),
    (4, 'Paid',      '2026-01-01 11:20:00', '2026-01-01 11:35:00', 3),
    (5, 'Cancelled', '2026-01-02 08:00:00', '2026-01-02 08:15:00', 4),
    (6, 'Paid',      '2026-01-02 08:30:00', '2026-01-02 08:45:00', 4),
    (7, 'Paid',      '2026-01-03 09:00:00', '2026-01-03 09:15:00', 5),
    (8, 'Expired',   '2026-01-03 10:00:00', '2026-01-03 10:15:00', 5);

INSERT INTO tblPayment (id, amount, method, status, paidAt, tblBookingid) VALUES
    (1, 270000, 'Card', 'Paid',      '2025-12-30 10:05:00', 1),
    (2, 180000, 'Cash', 'Paid',      '2025-12-31 09:05:00', 2),
    (3, 170000, 'Card', 'Pending',   NULL,                  3),
    (4, 170000, 'Card', 'Paid',      '2026-01-01 11:25:00', 4),
    (5, 160000, 'Cash', 'Cancelled', NULL,                  5),
    (6, 240000, 'Cash', 'Paid',      '2026-01-02 08:35:00', 6),
    (7, 160000, 'Card', 'Paid',      '2026-01-03 09:05:00', 7),
    (8,  80000, 'Card', 'Cancelled', NULL,                  8);

INSERT INTO tblTicket
    (id, price, purchasePlace, seat, tblShowtimeid, tblBookingid, tblCustomerid, tblSellerid) VALUES
    (1,  90000, 'Online',  'A1', 1, 1, 1,    NULL),
    (2,  90000, 'Online',  'A2', 1, 1, 2,    NULL),
    (3,  90000, 'Counter', 'A3', 1, 1, NULL, 1),
    (4,  90000, 'Online',  'B1', 2, 2, 1,    NULL),
    (5,  90000, 'Online',  'B2', 2, 2, 3,    NULL),
    (6,  85000, 'Online',  'C1', 3, 3, 2,    NULL),
    (7,  85000, 'Online',  'C2', 3, 3, 2,    NULL),
    (8,  85000, 'Online',  'C3', 3, 4, 3,    NULL),
    (9,  85000, 'Counter', 'C4', 3, 4, NULL, 1),
    (10, 80000, 'Online',  'D1', 4, 5, 1,    NULL),
    (11, 80000, 'Online',  'D2', 4, 5, 1,    NULL),
    (12, 80000, 'Online',  'D3', 4, 6, 2,    NULL),
    (13, 80000, 'Online',  'D4', 4, 6, 3,    NULL),
    (14, 80000, 'Counter', 'D5', 4, 6, NULL, 1),
    (15, 80000, 'Online',  'E1', 5, 7, 1,    NULL),
    (16, 80000, 'Online',  'E2', 5, 7, 2,    NULL),
    (17, 80000, 'Online',  'F1', 5, 8, 3,    NULL);

INSERT INTO tblMembership (id, issueDate, tblCustomerid) VALUES
    (1, '2025-12-01', 1);
