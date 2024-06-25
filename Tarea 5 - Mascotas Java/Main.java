public class Main {
    public static void main(String[] args) {
        Mascota.setMsjMascotas("Bienvenido al mundo de las mascotas!!");
        Mascota.mostrarMsjMascotas();
        
        Gallo gallo = new Gallo("Gallito", 2);
        Gato gato = new Gato("Michi", 3);
        Sapo sapo = new Sapo("Croc", 1);
        Serpiente serpiente = new Serpiente("Zzzara", 5);
        Abeja abeja = new Abeja("Beeee", 0);
        Tarantula tarantula = new Tarantula("Tarantulita", 4);

        Mascota[] mascotas = {gallo, gato, sapo, serpiente, abeja, tarantula};

        for (Mascota mascota : mascotas) {
            System.out.println("========================================");
            System.out.println("Nombre: " + mascota.getNombre());
            System.out.println("Edad: " + mascota.getEdad() + " años");
            mascota.imprimirSonido();
            System.out.println("========================================");
        }
    }
}
