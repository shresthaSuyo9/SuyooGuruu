package com.SuyooGuruu.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {
    // Database credentials (ideally loaded from environment variables or config files)
	private static final String URL = "jdbc:mysql://localhost:3306/suyooguruu";
    private static final String USER = "root"; 
    private static final String PASSWORD = ""; 
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    private static Connection connection = null;

    // Private constructor to prevent instantiation
    private DBConfig() {}

    // Get a database connection (singleton pattern)
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                // Load MySQL JDBC driver
                Class.forName(DRIVER);
                // Establish the connection
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Database connected successfully!");
            } catch (ClassNotFoundException e) {
                System.out.println("MySQL Driver not found: " + e.getMessage());
                throw new SQLException("MySQL Driver not found: " + e.getMessage());
            } catch (SQLException e) {
                System.out.println("Failed to connect to database: " + e.getMessage());
                throw new SQLException("Failed to connect to database: " + e.getMessage());
            }
        }
        return connection;
    }

    // Close the connection
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed.");
            } catch (SQLException e) {
                System.out.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
