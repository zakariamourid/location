package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "ajouterUser", value = "/ajouterUser")
public class ajouterUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String user = request.getParameter("user");
    String password = request.getParameter("mdp");
    String role = request.getParameter("role");
try {
        Connection con= UtilConnexion.seConnecter();
        PreparedStatement ps=con.prepareStatement("insert into compte values(null,?,?,?)");
        ps.setString(1,user);
        ps.setString(2,password);
        ps.setString(3,role);
        int i=ps.executeUpdate();
        if (i==0){
            System.out.println("user non ajouter");
            request.setAttribute("type","danger");
            request.setAttribute("message","user non ajouter");
            request.getRequestDispatcher("/locationVoiture/jsp/ajouterUser.jsp").forward(request, response);
    }else{
        System.out.println("user ajouter avec succes "+
                "avec le matricule: "+user);
request.setAttribute("type","success");
        request.setAttribute("message","user ajouter avec succes");
        request.getRequestDispatcher("/locationVoiture/jsp/ajouterUser.jsp").forward(request, response);
        }
}catch (Exception e) {
    System.out.println("erreur au cours de l'ajout d'un user: "+e);}
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
