package org.project.public_wifi_project.db;


import java.sql.*;

public class DbControl {


    public static void initDbConnection (){

        try {
            // SQLite JDBC
            Class.forName("org.sqlite.JDBC");
            System.out.println("success init dbConnect");
        } catch (ClassNotFoundException e) {
            System.out.println("Fail!!1" + e.getMessage());
        }

    }


    public static Connection dbConnect() {

        Connection connection = null;

        try {
            connection = DriverManager.getConnection(DbConst.DB_URL);

            System.out.println("success start dbConnection");

        } catch (SQLException e) {
            System.out.println("Fail!!2" + e.getMessage());
        }

        return connection;
    }

    public static void dbDisconnect(Connection connection, PreparedStatement preparedStatement, ResultSet resultSet) {

        try {
            if(preparedStatement != null && !preparedStatement.isClosed()) {
                preparedStatement.close();
                System.out.println("success close preparedStatement");
            }
        } catch (SQLException e) {
            System.out.println("Fail!!4" + e.getMessage());
        }

        try {
            if(connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("success close connection");
            }
        } catch (SQLException e) {
            System.out.println("Fail!!3" + e.getMessage());
        }

    }
}
