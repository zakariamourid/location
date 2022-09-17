package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteVoiture", value = "/deleteVoiture")
public class deleteVoiture extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try  {
            Connection con= UtilConnexion.seConnecter();
            PreparedStatement ps=con.prepareStatement("delete from voiture where matricule=?");
            ps.setString(1,id);
            int i=ps.executeUpdate();
            if (i==0){
                System.out.println("voiture supprimer n'existe pas");
            }else{
                System.out.println("voiture supprimer avec succes "+
                        "avec le matricule: "+id);
            }
        }catch (Exception e){
            System.out.println("erreur au cours de la suppression d'une voiture: "+e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String id = request.getParameter("idToDelete");
        try  {
            Connection con= UtilConnexion.seConnecter();
            PreparedStatement ps=con.prepareStatement("delete from voiture where matricule=?");
            ps.setString(1,id);
            ps.executeUpdate();
            System.out.println("voiture supprimer avec succes");
        }catch (Exception e){
            System.out.println("erreur au cours de la suppression d'une voiture: "+e);
        }
    }
}
