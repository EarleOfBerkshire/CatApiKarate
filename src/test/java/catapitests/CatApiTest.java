package catapitests;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class CatApiTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:catapitests")
                .parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
