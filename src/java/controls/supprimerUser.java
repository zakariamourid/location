package controls;

import dao.UtilConnexion;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "supprimerUser", value = "/supprimerUser")
public class supprimerUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        try {
            Connection con = UtilConnexion.seConnecter();
            PreparedStatement ps = con.prepareStatement("delete from compte where idCompte=?");
            ps.setString(1, id);
            int i = ps.executeUpdate();
            if (i == 0) {
                System.out.println("user non supprimer");
                request.setAttribute("type", "danger");
                request.setAttribute("message", "user non supprimer");
                request.getRequestDispatcher("/locationVoiture/jsp/ajouterUser.jsp").forward(request, response);
            } else {
                System.out.println("user supprimer avec succes " +
                        "avec le matricule: " + id);
                request.getRequestDispatcher("/locationVoiture/jsp/ajouterUser.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.out.println("erreur au cours de la suppression d'un user: " + e);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}
