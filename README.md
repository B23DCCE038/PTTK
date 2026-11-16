# Cinema Management System (đề 16)

Bản dựng Java web của hai module được thiết kế chi tiết trong báo cáo:

| Report module | Source |
| --- | --- |
| `Member registration 8` | `view/member/MemberHomeScreen8.jsp`, `view/member/MemberRegistrationScreen8.jsp`, `CustomerDAO8` |
| `View movie statistics 8` | five JSPs under `view/managementstaff/`, `MovieStatisticsDAO8`, `ShowtimeStatisticsDAO8`, `TicketDAO8` |

## Requirements

- JDK 17 or newer
- Maven 3.9+
- Docker Desktop, for the MySQL 8.0 container

The project was built and tested with JDK 25, Maven 3.9.11, Docker 29.7 and
Tomcat 10.1.34. Tomcat 10.1 is a Jakarta EE 10 container; the WAR also deploys
to a separately installed Tomcat 10.1+.

### Docker database

To reset the database and re-run the seed scripts:

```powershell
docker compose down -v
docker compose up -d
```

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
