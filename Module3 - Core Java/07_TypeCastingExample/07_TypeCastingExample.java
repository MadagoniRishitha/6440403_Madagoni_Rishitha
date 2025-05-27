public class TypeCastingExample {
    public static void main(String[] args) {
        double d = 9.78;
        int i = (int) d; // Explicit casting

        int j = 10;
        double dj = j; // Implicit casting

        System.out.println("Double to int: " + i);
        System.out.println("Int to double: " + dj);
    }
}