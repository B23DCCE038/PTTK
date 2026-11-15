-- Sanity checks for the statistics module. Run after 01-schema.sql + 02-seed.sql.
USE cinema;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Expected: Tâm Cám 5/450000, Mắt Biếc 2/170000, Bố Già 5/400000, Dune 0/0.
SELECT m.id, m.name,
       COUNT(t.id) AS ticketsSold,
       COALESCE(SUM(t.price), 0) AS revenue
FROM tblShowtime s
JOIN tblMovie m ON m.id = s.tblMovieid
LEFT JOIN tblBooking b ON b.tblShowtimeid = s.id AND b.status = 'Paid'
LEFT JOIN tblTicket t ON t.tblBookingid = b.id AND t.tblShowtimeid = s.id
WHERE s.date BETWEEN '2026-01-01' AND '2026-03-31'
GROUP BY m.id, m.name, m.description, m.coverImage, m.length, m.price
ORDER BY m.id;

-- Expected: Paid 12, Pending 2, Cancelled 2, Expired 1.
SELECT b.status, COUNT(*) AS tickets
FROM tblTicket t
JOIN tblBooking b ON b.id = t.tblBookingid
GROUP BY b.status
ORDER BY b.status;

-- Expected: one row for showtime 1, three tickets (A1, A2, A3).
SELECT t.id, t.seat, t.price, t.purchasePlace,
       m.username, f.surname, f.middleName, f.givenName
FROM tblTicket t
JOIN tblBooking b ON b.id = t.tblBookingid AND b.status = 'Paid'
LEFT JOIN tblCustomer c ON c.id = t.tblCustomerid
LEFT JOIN tblMember m ON m.id = c.tblMemberid
LEFT JOIN tblFullName f ON f.id = m.tblFullNameid
WHERE t.tblShowtimeid = 1
ORDER BY t.seat;
