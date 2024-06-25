import org.jpl7.*;

public class Main {
    public static void main(String[] args) {
        // Inicializar el ambiente de Prolog
        Query q1 = new Query("consult", new Term[] { new Atom("proyecto.pl") });
        System.out.println((q1.hasSolution() ? "Archivo Prolog cargado" : "Error al cargar el archivo Prolog"));

        // Hacer una consulta
        Query consulta = new Query("resultado_real", new Term[] {
                new Atom("momento_correcto"),
                new Atom("tipo_correcto"),
                new Atom("ejecucion_correcto")
        });

        // Verificar si hay soluciones a la consulta
        if (consulta.hasSolution()) {
            System.out.println("La persona tiene un resultado positivo para COVID-19.");
        } else {
            System.out.println("La persona tiene un resultado negativo para COVID-19.");
        }

        // Cerrar la conexión con Prolog
        q1.close();
    }
}