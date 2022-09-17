package dao;


import java.sql.Connection;
import java.sql.DriverManager;
public class UtilConnexion {
    public static Connection seConnecter() throws Exception {
        String url = "jdbc:mysql://localhost:3306/car";
        String user = "root";
        String mdp = "123456";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("driver charger avec succes");
            Connection con = DriverManager.getConnection(url, user, mdp);
            System.out.println("connexion etablir avec succes");
            return con;
        } catch (Exception e) {
            throw new Exception("une erreur est survenue: " + e.getMessage());
        }

    }


}
