package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "ajouterLocation", value = "/ajouterLocation")
public class ajouterLocation extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cin = request.getParameter("cin");
        String matricule = request.getParameter("matricule");
        String dateDebut = request.getParameter("dateDebut");
        String dateFin = request.getParameter("datefin");
        String prix = request.getParameter("prix");
        String status = request.getParameter("status");
        try {
            Connection con= UtilConnexion.seConnecter();
            String sql = "insert into contrat values(null,?,?,?,?,?,?)";
            PreparedStatement ps=con.prepareStatement(sql);
            ps.setString(1,cin);
            ps.setString(2,matricule);
            ps.setString(3,dateDebut);
            ps.setString(4,dateFin);
            ps.setString(5,prix);
            ps.setString(6,status);
            int i=ps.executeUpdate();
            ps.close();
            if(i>0) {
                sql="update voiture set status='loue' where matricule=?";
                ps= con.prepareStatement(sql);
                ps.setString(1,matricule);
                ps.executeUpdate();
                request.setAttribute("message","Ajout effectué avec succès");
                request.setAttribute("type","success");
                request.getRequestDispatcher("/jsp/detailLocation.jsp").forward(request,response);
            }
            else{
                request.setAttribute("type","danger");
                request.setAttribute("message","Ajout non effectué");
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
