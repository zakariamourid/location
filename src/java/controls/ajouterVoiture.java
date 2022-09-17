package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "ajouterVoiture", value = "/ajouterVoiture")
public class ajouterVoiture extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String matricule = request.getParameter("matricule");
    String modele = request.getParameter("modele");
    int annemodele = Integer.parseInt(request.getParameter("annemodele"));
    String marque = request.getParameter("marque");
    String carburant = request.getParameter("carburant");
    String status = request.getParameter("status");
        try {
            Connection con= UtilConnexion.seConnecter();
            String sql = "INSERT INTO voiture (matricule, modele, annemodele, marque, carburant, status) VALUES (?,?,?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1,matricule);
            ps.setString(2,modele);
            ps.setInt(3,annemodele);
            ps.setString(4,marque);
            ps.setString(5,carburant);
            ps.setString(6,status);
            int i=ps.executeUpdate();
            if(i>0) {
                request.setAttribute("message","Ajout effectué avec succès");
                request.setAttribute("type","success");
                request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
            }
            else{
                request.setAttribute("type","danger");
                request.setAttribute("message","Ajout non effectué");
                request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
            }
            con.close();
        }catch (Exception e) {
            System.out.println("erreur au cours de l'ajout d'une voiture: "+e);
            request.setAttribute("type","danger");
            request.setAttribute("message","Ajout non effectué");
            request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
        }



    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
