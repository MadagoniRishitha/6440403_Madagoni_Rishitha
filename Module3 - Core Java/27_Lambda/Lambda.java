import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class LambdaSorting {
    public static void main(String[] args) {
        List<String> list = new ArrayList<>();
        list.add("Banana");
        list.add("Apple");
        list.add("Orange");
        list.add("Mango");

        Collections.sort(list, (a, b) -> a.compareToIgnoreCase(b));

        System.out.println("Sorted list: " + list);
    }
}
