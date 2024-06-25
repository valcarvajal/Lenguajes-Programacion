package sistema_consultas;

import org.jpl7.*;

import java.util.InputMismatchException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Query.hasSolution("consult('base_conocimientos.pl')");
        Scanner scanner = new Scanner(System.in);
        int opcion;

        do {
            System.out.println("\n");
            System.out.println("\nBienvenido al Sistema de Consultas!");
            System.out.println("1. Contagiados por");
            System.out.println("2. Diagnóstico de");
            System.out.println("3. Salir del Sistema de Consultas");

            try {
                System.out.print("Ingrese su opción: ");
                opcion = scanner.nextInt();
            } catch (InputMismatchException e) {
                scanner.next();
                opcion = 0;
            }

            switch (opcion) {
                case 1:
                    System.out.print("Ingrese el nombre para consultar contagiados por: ");
                    String nombreContagio = scanner.next();
                    consultarContagiados(nombreContagio);
                    break;
                case 2:
                    System.out.print("Ingrese el nombre para consultar diagnóstico de: ");
                    String nombreDiagnostico = scanner.next();
                    System.out.println("\n");
                    if (consultarDiagnostico(nombreDiagnostico)) {
                        System.out.println("Diagnóstico: positivo");
                    } else {
                        System.out.println("Diagnóstico: negativo");
                    }
                    break;
                case 3:
                    System.out.println("Saliendo del sistema de consultas.");
                    break;
                default:
                    System.out.println("\n");
                    System.out.println("\nError:");
                    System.out.println("Opción no válida. Por favor, ingrese una opción válida.");
                    break;
            }
        } while (opcion != 3);
    }

    private static void consultarContagiados(String nombre) {
        String consulta = "spread_disease(" + nombre + ", Contagiados).";
        Query query = new Query(consulta);

        if (query.hasSolution()) {
            System.out.println("\n");
            System.out.println("Personas contagiadas por " + nombre + ":");
            while (query.hasMoreSolutions()) {
                java.util.Map<String, Term> solution = query.nextSolution();
                Term contagiado = solution.get("Contagiados");
                System.out.println(contagiado);
            }
        } else {
             System.out.println("\n");
            System.out.println("No se encontraron personas contagiadas por " + nombre + ".");
        }
    }

    private static boolean consultarDiagnostico(String nombre) {
        String consulta = "diagnostico(" + nombre + ", positivo).";
        Query query = new Query(consulta);
        return query.hasSolution();
    }
}


