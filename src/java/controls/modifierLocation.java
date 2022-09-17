package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLOutput;

@WebServlet(name = "modifierLocation", value = "/modifierLocation")
public class modifierLocation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String idcontrat = request.getParameter("idlocation");
    String cin = request.getParameter("cin");
    String matricule = request.getParameter("matricule");
    String dateDebut = request.getParameter("dateDebut");
    String dateFin = request.getParameter("datefin");
    String prix = request.getParameter("prix");
    String status = request.getParameter("status");
    try {
        Connection con= UtilConnexion.seConnecter();
        if(status=="libre"){
            PreparedStatement ps=con.prepareStatement("update voiture set status='libre' where matricule=?");
            ps.setString(1,matricule);
            ps.executeUpdate();
        }
        String sql = "update contrat set cin=?, matricule=?, date_debut=?, date_fin=?, prix=?, status=? where idcontrat=?";
        PreparedStatement ps=con.prepareStatement(sql);
        ps.setString(1,cin);
        ps.setString(2,matricule);
        ps.setString(3,dateDebut);
        ps.setString(4,dateFin);
        System.out.println(dateFin);
        System.out.println(status);
        ps.setString(5,prix);
        ps.setString(6,status);
        ps.setString(7,idcontrat);
        int i=ps.executeUpdate();
        if(i>0) {
            request.setAttribute("message","modification effectué avec succès");
            request.setAttribute("type","success");
            request.getRequestDispatcher("/jsp/detailLocation.jsp").forward(request,response);
        }
        else{
            request.setAttribute("type","danger");
            request.setAttribute("message","modification non effectué");
            request.getRequestDispatcher("/jsp/detailLocation.jsp").forward(request,response);
        }

    }catch (Exception e){
        System.out.println("erreur au cours de la modification d'une voiture: "+e);
        request.setAttribute("type","danger");
        request.setAttribute("message","Ajout non effectué");
        request.getRequestDispatcher("/jsp/detailLocation.jsp").forward(request,response);

    }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
