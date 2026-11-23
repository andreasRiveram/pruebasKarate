package Auto;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ExamplesTest {
    @Test
    public void testParallel() {
        System.out.println(getClass() );
       //Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
        //Results results = Runner.path("classpath:users").parallel(2);
        Results results = Runner.path("classpath:Auto").outputCucumberJson(true).parallel(2);
        System.out.println("Ruta de los resultados: " + results.getReportDir());
        generateReport(results.getReportDir());
        // LÍNEA CLAVE: Si hay al menos 1 fallo, la prueba JUnit fallará y detendrá Maven con un exit code de error
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        File reportOutputDirectory = new File(karateOutputPath);
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        String projectName = "demoApi";
        Configuration config = new Configuration(reportOutputDirectory,projectName);
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
