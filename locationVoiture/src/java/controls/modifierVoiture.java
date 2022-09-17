package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "modifierVoiture", value = "/modifierVoiture")
public class modifierVoiture extends HttpServlet {
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
            String sql = "update voiture set modele=?, annemodele=?, marque=?, carburant=?, status=? where matricule=?";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1,modele);
            ps.setInt(2,annemodele);
            ps.setString(3,marque);
            ps.setString(4,carburant);
            ps.setString(5,status);
            ps.setString(6,matricule);
            int i=ps.executeUpdate();
            if(i>0) {
                request.setAttribute("message","modifier avec succès");
                request.setAttribute("type","success");
                request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
            }
            else{
                request.setAttribute("type","danger");
                request.setAttribute("message","modification non effectué");
                request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
            }
            con.close();
        }catch (Exception e) {
            System.out.println("erreur au cours de la modification d'une voiture: "+e);
            request.setAttribute("type","danger");
            request.setAttribute("message","Ajout non effectué");
            request.getRequestDispatcher("/jsp/detailVoiture.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
