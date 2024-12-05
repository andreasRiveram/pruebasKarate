package examples.Runner;

/*import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;*/

//import com.intuit.karate.junit5.Karate;
import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.Test;
import com.intuit.karate.Runner;
import com.intuit.karate.Results;
import org.apache.commons.io.FileUtils;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

//@KarateOptions(features = {"classpath:examples/users/users.feature"})

class UsersRunner {
    @Karate.Test
    Karate testAll() {
     /*   // Ejecutar las pruebas en paralelo
        Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");

        generateReport(results.getReportDir());

        // Puedes agregar más lógica si es necesario
        return Karate.run("classpath:examples/users/users.feature").outputCucumberJson(true)
                .reportDir("target/surefire-reports");

        // Llamar al método generateReport después de ejecutar las pruebas*/
        // Ejecutar las pruebas en paralelo y generar los reportes
        Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");

        // Imprimir la ruta de los resultados generados
        System.out.println("Ruta de los resultados: " + results.getReportDir());

        // Llamar a la función generateReport para procesar los archivos JSON generados por Karate
        generateReport(results.getReportDir());

        // Verificar que no haya fallos
        assertEquals(0, results.getFailCount(), results.getErrorMessages());

        // Retornar el resultado de Karate, habilitando la salida en JSON
        return Karate.run("classpath:examples/users/users.feature")
                .outputCucumberJson(true)  // Genera el reporte JSON de Cucumber
                .reportDir("target/karate-reports"); // Directorio de los reportes generados



    }

    @Test
    public void testParallel() {
       /* System.out.println(getClass() );
        Results results = Runner.parallel(getClass(), 1, "target/surefire-reports");
       // Results results = Runner.path("target/surefire-reports").outputCucumberJson(true).parallel(1);
        System.out.println("Ruta de los resultados: " + results.getReportDir());
        generateReport(results.getReportDir());*/


    }
/*
    public static void generateReport(String karateOutputPath) {
        File reportOutputDirectory = new File(karateOutputPath);
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        String projectName = "demoApi";
        Configuration config = new Configuration(reportOutputDirectory,projectName);
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }*/


        // Método que genera el reporte a partir de los archivos JSON generados por Karate
        public static void generateReport(String karateOutputPath) {
            // Crear la ruta del directorio de salida para los reportes
            File reportOutputDirectory = new File(karateOutputPath);

            // Buscar los archivos .json generados en la ruta karateOutputPath
            Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
            List<String> jsonPaths = new ArrayList<>(jsonFiles.size());

            // Agregar las rutas de los archivos JSON a la lista jsonPaths
            jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));

            // Configurar el nombre del proyecto y el directorio de salida del reporte
            String projectName = "demoApi"; // Cambia esto según el nombre de tu proyecto
            Configuration config = new Configuration(reportOutputDirectory, projectName);

            // Crear el generador de reportes de Cucumber
            ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);

            // Generar el reporte
            reportBuilder.generateReports();
        }



}
