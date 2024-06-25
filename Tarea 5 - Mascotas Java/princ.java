abstract class Mascota {
    private String nombre;
    private int edad;
    private static String msjMascotas;

    public static void setMsjMascotas(String msjMascotas) {
        Mascota.msjMascotas = msjMascotas;
    }

    public static void mostrarMsjMascotas() {
        System.out.println(msjMascotas);
    }

    public Mascota(String nombre, int edad) {
        this.nombre = nombre;
        this.edad = edad;
    }

    public String getNombre() {
        return nombre;
    }

    public int getEdad() {
        return edad;
    }

     public int mostrarDatosMascota(int edad) {
        System.out.println("Edad de la mascota: " + edad + " años");
        return edad;
    }

    public String mostrarDatosMascota(String nombre) {
        System.out.println("Nombre de la mascota: " + nombre);
        return nombre;
    }

    public void mostrarDatosMascota() {
        System.out.println("Nombre de la mascota: " + nombre);
        System.out.println("Edad de la mascota: " + edad + " años");
    }

    public static void mostrarMsjMascotas(String msj) {
        msjMascotas = msj;
        System.out.println(msjMascotas);
    }

    public abstract void imprimirSonido();
}

class Vertebrado extends Mascota {
    private static String datosVertebrados = "Vertebrado";

    public Vertebrado(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Características: " + datosVertebrados);
    }
}

class Gallo extends Vertebrado {
    public Gallo(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Cacareo");
    }
}

class Gato extends Vertebrado {
    public Gato(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Maullido");
    }
}

class Anfibio extends Mascota {
    private static String datosAnfibios = "Anfibio";

    public Anfibio(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Características: " + datosAnfibios);
    }
}

class Sapo extends Anfibio {
    public Sapo(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Croar");
    }
}

class Reptil extends Mascota {
    private static String datosReptiles = "Réptil";

    public Reptil(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Características: " + datosReptiles);
    }
}

class Serpiente extends Reptil {
    public Serpiente(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Siseo");
    }
}

class Insecto extends Mascota {
    private static String datosInsectos = "Insecto";

    public Insecto(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Características: " + datosInsectos);
    }
}

class Abeja extends Insecto {
    public Abeja(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Zumbido");
    }
}

class Mosca extends Insecto {
    public Mosca(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Zumbido");
    }
}

class Arana extends Mascota {
    private static String datosArana = "Araña";

    public Arana(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Características: " + datosArana);
    }
}

class Tarantula extends Arana {
    public Tarantula(String nombre, int edad) {
        super(nombre, edad);
    }

    public void imprimirSonido() {
        System.out.println("Sonido que emite: Chasquido");
    }
}

