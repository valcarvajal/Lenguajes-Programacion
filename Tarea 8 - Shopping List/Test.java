public class Test {
    public static void main(String[] args) {
        LengClient client = new LengClient("Heinz", "Doofenshmirtz", "123 Calle Principal, Gimmelshtump");
        LengShoppingList shoppingList = new LengShoppingList(client);

        AbstractProduct shoe = new ShoeProduct(101, "Tennis", 50.0, 10, 0.1);
        AbstractProduct electronic = new ElectronicProduct(201, "Celular", 300.0, 5, 0.05);
        AbstractProduct clothes = new ClothesProduct(301, "Camiseta", 20.0, 15, 0.2);
        AbstractProduct game = new GameProduct(401, "Video juego", 40.0, 8, 0.15);

        shoppingList.addProduct(shoe);
        shoppingList.addProduct(electronic);
        shoppingList.addProduct(clothes);
        shoppingList.addProduct(game);

        shoe.buyProduct(2);
        electronic.buyProduct(1);
        clothes.buyProduct(3);
        game.buyProduct(2);
        
        // Lista
        System.out.println("**************************************************");
        if (shoppingList.empty()) {
            System.out.println("La lista de " + client.firstName + client.lastName + " está vacía.");
        } else {
            shoppingList.displayList();
            System.out.println("Cantidad de productos en la lista: " + shoppingList.countProducts());
            System.out.println("Total a pagar: $" + shoppingList.totalPurchased());
            System.out.println("**************************************************");
        }
    }
}

