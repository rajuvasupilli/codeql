package com.example;
import java.sql.*;
public class App {
  public static void main(String[] args) throws SQLException {
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/test", "user", "pass");
    Statement stmt = conn.createStatement();
    String query = "SELECT * FROM users WHERE id=" + args[0]; // SQL Injection risk
    ResultSet rs = stmt.executeQuery(query);
    while (rs.next()) {
      System.out.println(rs.getString("name"));
    }
  }
}
