import java.util.ArrayList;
import java.util.Scanner;

public class ArrayListExample {
    public static void main(String[] args) {
        ArrayList<String> names = new ArrayList<>();
        Scanner sc = new Scanner(System.in);
        String input;

        System.out.println("Enter student names (type 'exit' to stop):");
        while (true) {
            input = sc.nextLine();
            if (input.equalsIgnoreCase("exit")) break;
            names.add(input);
        }

        System.out.println("Student Names:");
        for (String name : names) {
            System.out.println(name);
        }
        sc.close();
    }
}
