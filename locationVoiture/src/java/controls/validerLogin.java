package controls;

import dao.UtilConnexion;
import modele.Compte;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "validerLogin", value = "/validerLogin")
public class validerLogin extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String user=request.getParameter("user");
    String mdp=request.getParameter("mdp");
        try {
            Connection con= UtilConnexion.seConnecter();
            PreparedStatement ps=con.prepareStatement("select * from compte where user=? and mdp=?");
            ps.setString(1,user);
            ps.setString(2,mdp);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                request.getSession().setAttribute("compte",new Compte(rs.getInt("idCompte"),rs.getString("user"),rs.getString("mdp"),rs.getString("role")));
                response.sendRedirect("/locationVoiture/jsp/dashboard.jsp");
            }else {
                System.out.println("erreur mdp ou user invalide");
                request.setAttribute("message","connexion reussie");
                response.sendRedirect("/locationVoiture/index.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
