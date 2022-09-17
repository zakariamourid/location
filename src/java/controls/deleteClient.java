package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "deleteClient", value = "/deleteClient")
public class deleteClient extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cin = request.getParameter("id");
        try  {
            Connection con= UtilConnexion.seConnecter();
            PreparedStatement ps=con.prepareStatement("delete from client where cin=?");
            ps.setString(1,cin);
            int i=ps.executeUpdate();
            if (i==0){
                System.out.println("client supprimer n'existe pas");
            }else{
                System.out.println("client supprimer avec succes "+
                        "avec le matricule: "+cin);
            }
        }catch (Exception e){
            System.out.println("erreur au cours de la suppression du client: "+e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
