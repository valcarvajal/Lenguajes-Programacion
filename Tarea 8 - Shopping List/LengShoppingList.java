/**
 * Nombre del Proyecto: Actividad de estudio de caso: Lista de Compras.
 *
 * Miembros del Grupo:
 * - Valery Mishel Carvajal Oreamuno
 * - Anthony Josué Rojas Fuentes
 *
 * Curso: Lenguajes de Programación.
 * Universidad: Instituto Tecnológico de Costa Rica (ITCR)
 * Fecha: 31 / 08 / 2023
 * II Semestre 2023
 */

import java.util.ArrayList;
import java.util.List;

interface Product {
    double calculateTotalPrice();
    int getPurchasedAmount();
    void buyProduct(int amount);
}

interface PurchasableProduct extends Product {
    int getPurchasedAmount();
    void buyProduct(int amount);
}

abstract class AbstractProduct implements Product {
    protected int code;
    protected String name;
    protected double price;
    protected int quantityStock;
    protected double offer;
    protected int purchasedAmount;

    public AbstractProduct(int code, String name, double price, int quantityStock, double offer) {
        this.code = code;
        this.name = name;
        this.price = price;
        this.quantityStock = quantityStock;
        this.offer = offer;
        this.purchasedAmount = 0;
    }

    public void buyProduct(int amount) {
        if (amount <= quantityStock) {
            purchasedAmount += amount;
            quantityStock -= amount;
        } else {
            System.out.println("No hay suficiente stock disponible.");
        }
    }

    @Override
    public double calculateTotalPrice() {
        return purchasedAmount * price * (1 - offer);
    }
}

class ShoeProduct extends AbstractProduct {
    public ShoeProduct(int code, String name, double price, int quantityStock, double offer) {
        super(code, name, price, quantityStock, offer);
    }
    
    @Override
    public int getPurchasedAmount() {
        return purchasedAmount;
    }
    
    @Override
    public void buyProduct(int amount) {
        super.buyProduct(amount);
    }
}

class ElectronicProduct extends AbstractProduct {
    public ElectronicProduct(int code, String name, double price, int quantityStock, double offer) {
        super(code, name, price, quantityStock, offer);
    }
    
    @Override
    public int getPurchasedAmount() {
        return purchasedAmount;
    }
    
    @Override
    public void buyProduct(int amount) {
        super.buyProduct(amount);
    }
}

class ClothesProduct extends AbstractProduct {
    public ClothesProduct(int code, String name, double price, int quantityStock, double offer) {
        super(code, name, price, quantityStock, offer);
    }

    @Override
    public int getPurchasedAmount() {
        return purchasedAmount;
    }

    @Override
    public void buyProduct(int amount) {
        super.buyProduct(amount);
    }
}

class GameProduct extends AbstractProduct {
    public GameProduct(int code, String name, double price, int quantityStock, double offer) {
        super(code, name, price, quantityStock, offer);
    }

    @Override
    public int getPurchasedAmount() {
        return purchasedAmount;
    }

    @Override
    public void buyProduct(int amount) {
        super.buyProduct(amount);
    }
}

interface Client {
    String toString();
}

class LengClient implements Client {
    private static int nextId = 1;
    private int id;
    String firstName;
    String lastName;
    private String address;

    // Constructor
    public LengClient(String firstName, String lastName, String address) {
        this.id = nextId++;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Cliente: " + firstName + " " + lastName + "\nID: " + id + "\nDirección: " + address;
    }
}

class LengShoppingList {
    private LengClient client;
    private List<Product> products;

    public LengShoppingList(LengClient client) {
        this.client = client;
        this.products = new ArrayList<>();
    }

    public void addProduct(Product product) {
        products.add(product);
    }

    public boolean empty() {
        return products.isEmpty();
    }

    public int countProducts() {
        return products.size();
    }

    public double totalPurchased() {
        double total = 0;
        for (Product product : products) {
            total += product.calculateTotalPrice();
        }
        return total;
    }

    public void displayList() {
        System.out.println("Lista de compras para " + client.toString() + ":");
        System.out.println("--------------------------------------------------");
        for (Product product : products) {
            System.out.println("Producto: " + product.toString());
            System.out.println("Nombre del producto: " + ((AbstractProduct) product).name);
            System.out.println("Cantidad en existencia: " + ((AbstractProduct) product).quantityStock);
            System.out.println("Porcentaje de oferta: " + ((AbstractProduct) product).offer * 100 + "%");

            if (product instanceof PurchasableProduct) {
                PurchasableProduct purchasableProduct = (PurchasableProduct) product;
                System.out.println("Cantidad a comprar: " + purchasableProduct.getPurchasedAmount());
                purchasableProduct.buyProduct(2);
            }

            System.out.println("Total: $" + product.calculateTotalPrice());
            System.out.println("--------------------------------------------------");
        }
    }
}

