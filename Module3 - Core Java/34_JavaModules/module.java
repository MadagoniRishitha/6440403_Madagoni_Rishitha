module com.utils {
    exports com.utils;
}
package com.utils;

public class Utils {
    public static void greet(String name) {
        System.out.println("Hello, " + name);
    }
}
module com.greetings {
    requires com.utils;
}
package com.greetings;

import com.utils.Utils;

public class Main {
    public static void main(String[] args) {
        Utils.greet("World");
    }
}
