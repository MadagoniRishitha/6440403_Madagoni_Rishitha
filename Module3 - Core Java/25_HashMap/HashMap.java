import java.util.HashMap;
import java.util.Scanner;

public class HashMapExample {
    public static void main(String[] args) {
        HashMap<Integer, String> students = new HashMap<>();
        Scanner sc = new Scanner(System.in);
        String input;

        System.out.println("Add student entries (ID and Name). Type 'done' to stop:");

        while (true) {
            System.out.print("Enter student ID: ");
            if (!sc.hasNextInt()) break;
            int id = sc.nextInt();
            sc.nextLine(); // consume newline

            System.out.print("Enter student name: ");
            String name = sc.nextLine();

            students.put(id, name);
            System.out.println("Entry added. Type 'done' to finish or press Enter to continue.");
            input = sc.nextLine();
            if (input.equalsIgnoreCase("done")) break;
        }

        System.out.print("Enter student ID to search: ");
        int searchId = sc.nextInt();
        String studentName = students.get(searchId);

        if (studentName != null) {
            System.out.println("Student name: " + studentName);
        } else {
            System.out.println("No student found with ID " + searchId);
        }
        sc.close();
    }
}
