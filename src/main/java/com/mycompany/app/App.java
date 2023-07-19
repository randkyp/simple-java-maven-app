package com.mycompany.app;

import static spark.Spark.*;

public class App {

    private static final String MESSAGE = "Hello World!";

    public static void main(String[] args) {
        // Define the port for the web server
        port(8080);
        ipAddress("0.0.0.0");

        // Define the route that serves the "Hello World!" text
        get("/", (req, res) -> MESSAGE);
    }

    public String getMessage() {
        return MESSAGE;
    }
}
