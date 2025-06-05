package examples;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;

import com.intuit.karate.junit5.Karate;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@KarateOptions(features = {"classpath:examples/users/users.feature"})
public class ExamplesTest {
    @Test
    public void testParallel() {
        System.out.println(getClass() );
       //Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
        //Results results = Runner.path("classpath:users").parallel(2);
        Results results = Runner.path("classpath:examples/users").outputCucumberJson(true).parallel(2);
        System.out.println("Ruta de los resultados: " + results.getReportDir());
        generateReport(results.getReportDir());
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
