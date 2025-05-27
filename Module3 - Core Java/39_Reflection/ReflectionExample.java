import java.lang.reflect.*;

public class ReflectionExample {
    public void sayHello(String name) {
        System.out.println("Hello, " + name);
    }

    public static void main(String[] args) throws Exception {
        Class<?> clazz = Class.forName("ReflectionExample");
        Object obj = clazz.getDeclaredConstructor().newInstance();
        Method method = clazz.getMethod("sayHello", String.class);
        method.invoke(obj, "World");

        for (Method m : clazz.getDeclaredMethods()) {
            System.out.println(m.getName() + " Parameters: " + m.getParameterCount());
        }
    }
}
