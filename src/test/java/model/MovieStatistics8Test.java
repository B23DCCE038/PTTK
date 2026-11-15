package model;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertInstanceOf;

class MovieStatistics8Test {

    @Test
    void isAMovieAndCarriesTheAggregateNumbers() {
        Movie8 movie = new Movie8();
        movie.setId(1);
        movie.setName("Tâm Cám");
        movie.setPrice(90000f);

        MovieStatistics8 statistics = new MovieStatistics8(movie, 5, 450000f);

        assertInstanceOf(Movie8.class, statistics);
        assertEquals(1, statistics.getId());
        assertEquals("Tâm Cám", statistics.getName());
        assertEquals(90000f, statistics.getPrice());
        assertEquals(5, statistics.getTicketsSold());
        assertEquals(450000f, statistics.getRevenue());
    }
}
