package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteLocation", value = "/deleteLocation")
public class deleteLocation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idlocation = request.getParameter("id");
        try {
            Connection con= UtilConnexion.seConnecter();
            PreparedStatement ps=con.prepareStatement("delete from contrat where idcontrat=?");
            ps.setString(1,idlocation);
            int i=ps.executeUpdate();
            if (i==0){
                System.out.println("location supprimer n'existe pas");
            }else{
                System.out.println("location supprimer avec succes "+
                        "avec le matricule: "+idlocation);
            }
    }catch (Exception e) {
        System.out.println("erreur au cours de la suppression d'une location: "+e);
    }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
