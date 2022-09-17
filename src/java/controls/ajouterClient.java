package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "ajouterClient", value = "/ajouterClient")
public class ajouterClient extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cin = request.getParameter("cin");
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        try {
            Connection con= UtilConnexion.seConnecter();
            String sql = "INSERT INTO client (cin, nom, email, adresse, telephone) VALUES (?,?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1,cin);
            ps.setString(2,nom);
            ps.setString(3,email);
            ps.setString(4,adresse);
            ps.setString(5,telephone);

            int i=ps.executeUpdate();
            if(i>0) {
                request.setAttribute("message","Ajout effectué avec succès");
                request.setAttribute("type","success");
                request.getRequestDispatcher("/jsp/detailClients.jsp").forward(request,response);
            }
            else{
                request.setAttribute("type","danger");
                request.setAttribute("message","Ajout non effectué");
                request.getRequestDispatcher("/jsp/detailClients.jsp").forward(request,response);
            }
            con.close();
        }catch (Exception e) {
            System.out.println("erreur au cours de l'ajout d'une voiture: "+e);
            request.setAttribute("type","danger");
            request.setAttribute("message","Ajout non effectué");
            request.getRequestDispatcher("/jsp/detailClients.jsp").forward(request,response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
