# Cinema Management System — source code (đề 16)

Bản dựng Java web của hai module được thiết kế chi tiết trong báo cáo:

| Report module | Source |
| --- | --- |
| `Member registration 8` | `view/guest/GuestMainScreen8.jsp`, `view/guest/MemberRegistrationScreen8.jsp`, `CustomerDAO8` |
| `View movie statistics 8` | five JSPs under `view/managementstaff/`, `MovieStatisticsDAO8`, `ShowtimeStatisticsDAO8`, `TicketDAO8` |

The source follows the design class diagrams in report sections VIII–XII:

- `model/`: the 18 entity classes of `uml/EntityClassDiagramDesign.puml`
- `dao/`: `DAO8` plus the four designed DAO classes, with the designed method signatures
- `view/`: JSP boundary classes with the designed `in` / `out` / `sub` component names
- `database/`: the 14 tables of `uml/DatabaseDiagram.puml`

`Login 8` is intentionally not implemented. The management module opens from a
demo entry and uses a seeded Management-staff object matching
`database/02-seed.sql` (`admin` / “Trần Thị B”). See “Scope and design notes”
below.

## Requirements

- JDK 17 or newer
- Maven 3.9+
- Docker Desktop, for the MySQL 8.0 container

The project was built and tested with JDK 25, Maven 3.9.11, Docker 29.7 and
Tomcat 10.1.34. Tomcat 10.1 is a Jakarta EE 10 container; the WAR also deploys
to a separately installed Tomcat 10.1+.

## Quick start

```
# 1. MySQL 8.0 + schema + seed (first start runs database/*.sql)
docker compose up -d

# 2. Build
mvn package

# 3. Run Tomcat 10.1 with the WAR at /cinema
mvn cargo:run
```

Open <http://localhost:8080/cinema/>.

The same three steps are wrapped by `start-db.bat`, `build.bat` and
`start.bat`.

The first `mvn cargo:run` downloads Tomcat 10.1.34 into `target/cargo/`.
If port 8080 is busy:

```powershell
mvn cargo:run -Dcargo.servlet.port=8081
```

To use an existing Tomcat instead, copy `target/cinema.war` into its
`webapps/` directory and start Tomcat 10.1+.

### Docker database

`docker-compose.yml` starts MySQL 8.0 on host port 3306 with:

- database `cinema`
- user `cinema` / password `cinema`
- root password `root`
- `utf8mb4` / `utf8mb4_unicode_ci`
- automatic execution of `database/01-schema.sql` and `database/02-seed.sql`

To reset the database and re-run the seed scripts:

```powershell
docker compose down -v
docker compose up -d
```

## Demo walkthrough

### Module 1 — Member registration

1. Open the home page and choose **Khách → Vào module đăng ký**.
2. Click **Đăng ký thành viên**.
3. Submit with a blank field: the error notice “Vui lòng nhập đầy đủ bốn thông tin…” appears.
4. Submit with `anv` (already seeded): the error notice “Tên đăng nhập đã tồn tại…” appears.
5. Submit a new username, for example `sv038`, password `123456`,
   full name `Nguyễn Văn Bình`, phone `0912345670`: the success notice appears.
6. Click **OK** to open the customer home.
7. Verify the new `tblMember`, `tblCustomer` and `tblFullName` rows with SQL.

The full name is split into surname / middle name / given name by
`NameParser8`; for example `Nguyễn Văn Bình` becomes
`Nguyễn` / `Văn` / `Bình`.

### Module 2 — Movie statistics

1. Open the home page and choose **Nhân viên quản lý → Vào module thống kê (demo)**.
2. The main screen shows “Xin chào: Trần Thị B”.
3. Choose **Xem thống kê**.
4. Choose **Thống kê phim**. The default period is `01/01/2026–31/03/2026`.
5. The movie table should show:

| Mã phim | Tên phim | Tổng vé bán | Doanh thu (đồng) |
| ---: | --- | ---: | ---: |
| 1 | Tâm Cám | 5 | 450.000 |
| 2 | Mắt Biếc | 2 | 170.000 |
| 3 | Bố Già | 5 | 400.000 |
| 4 | Dune: Hành Tinh Cát | 0 | 0 |
| — | **Tổng cả kì** | **12** | **1.020.000** |

6. Click **Tâm Cám** to see its two showtimes and their paid-ticket totals.
7. Click the time of showtime 1 (`09:00`) to see the three paid tickets.
   Ticket `A3` was sold at the counter without a customer account, so its
   “Khách hàng” cell is empty.
8. Use **Quay lại** three times to return to the movie table, then **Quay lại**
   to the report-type screen and **Đóng** to end the module.

The seeded pending (`Pending`), cancelled (`Cancelled`) and expired (`Expired`)
bookings are excluded from every statistics screen. `Dune` is scheduled in the
period but has no ticket, so it appears with 0 tickets and 0 revenue rather
than disappearing.

## Class / database mapping

| Design | Source |
| --- | --- |
| `Member8`, `Customer8`, `Seller8`, `ManagementStaff8` | `model/*.java` |
| `FullName8`, `Address8`, `Theater8`, `ScreeningRoom8` | `model/*.java` |
| `Movie8`, `Showtime8`, `Ticket8`, `Booking8`, `Payment8`, `Membership8` | `model/*.java` |
| `MovieStatistics8`, `ShowtimeStatistics8`, `CustomerStatistics8`, `RevenueStatistics8` | `model/*.java` |
| `DAO8`, `CustomerDAO8`, `MovieStatisticsDAO8`, `ShowtimeStatisticsDAO8`, `TicketDAO8` | `dao/*.java` |
| `GuestMainScreen8.jsp`, `MemberRegistrationScreen8.jsp` | `view/guest/` |
| `CustomerMainScreen8.jsp` | `view/customer/` (destination of module 1, customer module) |
| five management screens | `view/managementstaff/` |
| 14 tables | `database/01-schema.sql` |

The boundary classes keep the designed component names in the HTML:

- `inUsername`, `inPassword`, `inFullName`, `inPhone`, `outNotice`, `subRegister`
- `subSelectRegistration`, `subSelectStatistics`
- `subMovieStatistics`, `subCustomerStatistics`, `subRevenueStatistics`, `subClose`
- `inStartDate`, `inEndDate`, `subFilter`, `outMovieTable`, `subSelectMovie`, `subBack`
- `outShowtimeTable`, `subSelectShowtime`, `subBack`
- `outTicketTable`, `subBack`

## Statistics queries

- `MovieStatisticsDAO8` starts from `tblShowtime` in the period, joins
  `tblMovie`, then `LEFT JOIN`s paid bookings and their tickets. This keeps a
  scheduled movie with zero tickets in the result.
- `ShowtimeStatisticsDAO8` does the same for the showtimes of one movie.
- `TicketDAO8` starts from `tblTicket`, joins `tblBooking` with
  `status = 'Paid'`, then `LEFT JOIN`s `tblCustomer`, `tblMember` and
  `tblFullName`, so a counter ticket without an account is still returned.
- Every statistics query filters `tblBooking.status = 'Paid'`.
- The period filters on `tblShowtime.date`, not on a purchase date (the
  `Ticket` model has no purchase timestamp). This is the report’s decision.

## Scope and design notes

- **Plain passwords.** The report stores `password` as a plain `String`;
  this build does the same. A real application must hash passwords.
- **Support code.** `index.jsp`, `error.jsp` and `util/` are infrastructure
  classes, not part of the two module class diagrams. They are documented here
  so the class-diagram comparison remains clear.

## Build commands

```powershell
mvn package              # target/cinema.war
mvn cargo:run            # Tomcat 10.1 on port 8080
mvn cargo:stop           # stop the Cargo Tomcat
```

Windows helper scripts:

| Script | Does |
| --- | --- |
| `build.bat` | `mvn package` → `target/cinema.war` |
| `start-db.bat` | `docker compose up -d`, waits for the `cinema-mysql` healthcheck |
| `start.bat` | launches `mvn cargo:run` in a separate **Cinema Tomcat** window, waits for `http://localhost:8080/cinema/`, opens it |

On Windows, run `mvn cargo:stop` before `mvn clean`: the running
Tomcat is inside `target/cargo`, so `clean` cannot delete locked files.

```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-21.0.12.8-hotspot"
mvn cargo:run
```

## Troubleshooting

- **Schema/seed did not run**: MySQL only runs `docker-entrypoint-initdb.d` scripts when the data volume is empty. Run `docker compose down -v` then
  `docker compose up -d`.
- **Port 3306 already in use**: stop the local MySQL service or change the host port in `docker-compose.yml` and `db.properties`.
- **Port 8080 already in use**: `mvn cargo:run -Dcargo.servlet.port=8081`.
- **A file you deleted still shows up in the WAR**: `mvn package` reuses `target/`. Run `mvn clean package` after removing, renaming or moving anything under `src/main/webapp`, otherwise the old file stays inside `cinema.war` and in the Cargo deployment.
- **Tomcat starts but a JSP reports an error**: check `target/cargo/configurations/tomcat10x/logs/` and the Maven console. The custom `error.jsp` also shows a short diagnostic message.
