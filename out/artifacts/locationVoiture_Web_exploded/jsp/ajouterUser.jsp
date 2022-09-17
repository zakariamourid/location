<%@ page import="modele.Compte" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UtilConnexion" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: zakaria
  Date: 16/6/2022
  Time: 9:45 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:include page="entet.jsp"></jsp:include>
<%
    ArrayList<Compte> listeCompte = new ArrayList<Compte>();
    Connection con = UtilConnexion.seConnecter();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("select * from compte");
    while(rs.next()) {
        Compte c = new Compte(rs.getInt("idCompte"), rs.getString("user"), rs.getString("mdp"), rs.getString("role"));
        listeCompte.add(c);
    }
    Compte compte = (Compte) session.getAttribute("compte");
    String role = "guest";
    if (compte == null) {
        request.getRequestDispatcher("/locationVoiture/index.jsp").forward(request, response);
    } else {
        System.out.println("--------------------------" + compte.getRole());
        role = compte.getRole();
    }
    if (!role.equals("admin")) {
        response.sendRedirect("/locationVoiture/index.jsp");
    }
%>
<div id="wrapper">
    <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
        <div class="container-fluid d-flex flex-column p-0"><a
                class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0"
                href="dashboard.jsp">
            <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-car-side"></i></div>
            <div class="sidebar-brand-text mx-3"><span>MALOCATION</span></div>
        </a>
            <hr class="sidebar-divider my-0">
            <ul class="navbar-nav text-light" id="accordionSidebar">
                <li class="nav-item"><a class="nav-link " href="dashboard.jsp"><i
                        class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailVoiture.jsp"><i
                        class="fas fa-car-alt"></i><span>voiture</span></a></li>
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailClients.jsp"><i
                        class="far fa-user-circle"></i><span>client</span></a></li>
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailLocation.jsp"><i
                        class="fa-duotone fa-road"></i><span>locations</span></a></li>
                <li class="nav-item"><a class="nav-link active" href="/locationVoiture/jsp/ajouterUser.jsp"><i
                        class="fas fa-user-friends"></i><span>users</span></a></li>
            </ul>
        </div>
    </nav>
    <div class="d-flex flex-column" id="content-wrapper">
        <%

        %>
        <div id="content">
            <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                <div class="container-fluid">
                    <button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button"><i
                            class="fas fa-bars"></i></button>
                    <ul class="navbar-nav flex-nowrap ms-auto">
                        <li class="nav-item dropdown d-sm-none no-arrow"><a class="dropdown-toggle nav-link"
                                                                            aria-expanded="false"
                                                                            data-bs-toggle="dropdown" href="#"><i
                                class="fas fa-search"></i></a>
                            <div class="dropdown-menu dropdown-menu-end p-3 animated--grow-in"
                                 aria-labelledby="searchDropdown">
                                <form class="me-auto navbar-search w-100">
                                    <div class="input-group"><input class="bg-light form-control border-0 small"
                                                                    type="text" placeholder="Search for ...">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary py-0" type="button"><i
                                                    class="fas fa-search"></i></button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>
                        <li class="nav-item dropdown no-arrow mx-1"></li>
                        <li class="nav-item dropdown no-arrow mx-1">
                            <div class="shadow dropdown-list dropdown-menu dropdown-menu-end"
                                 aria-labelledby="alertsDropdown"></div>
                        </li>
                        <div class="d-none d-sm-block topbar-divider"></div>
                        <li class="nav-item dropdown no-arrow">
                            <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link"
                                                                       aria-expanded="false" data-bs-toggle="dropdown"
                                                                       href="#"><span
                                    class="d-none d-lg-inline me-2 text-gray-600 small">admin<i class="fas fa-user-tie"
                                                                                                style="font-size: 1.4rem;margin-left: 10px;"></i></span></a>
                                <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in">
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="/locationVoiture/logout2"><i
                                            class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="container-fluid">
                <%if (request.getAttribute("message") != null) {%>
                <div class="alert alert-<%=request.getAttribute("type")%>" role="alert">
                    <%=request.getAttribute("message")%>
                </div>
                <%}%>
                <div class="d-sm-flex justify-content-between align-items-center mb-4">
                    <h3 class="text-dark mb-0">Add A User</h3>
                </div>
                <div class="container col-6">
                    <form name="ajouter" action="/locationVoiture/ajouterUser" method="GET">
                        <div class="form-group">
                            <label for="user">User</label>
                            <input type="text" class="form-control" name="user" id="user" aria-describedby="emailHelp"
                                   placeholder="Enter votre username">
                        </div>
                        <div class="form-group">
                            <label for="mdp">Passwod</label>
                            <input type="password" class="form-control" name="mdp" id="mdp" aria-describedby="emailHelp"
                                   placeholder="Enter password">
                        </div>
                        <div class="form-group">
                            <label for="role">role:</label>
                            <select class="form-control" name="role" id="role">
                                <option value="admin">admin</option>
                                <option value="user">user</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <button type="button" onclick="submitForm()" style="margin-top:20px"
                                    class="btn btn-primary form-control" id="addUser">ADD
                            </button>
                        </div>
                    </form>
                </div>
                <table
                id="example"
                class="table table-striped table-bordered"
                cellspacing="0"
                width="100%"
                >
                <thead>
                <tr>
                    <th>idCompte</th>
                    <th>user</th>
                    <th>role</th>
                    <th>delete</th>
                </tr>
                </thead>
                <tbody>
                <% for (Compte c : listeCompte) { %>
                <tr>
                    <td><%=c.getIdCompte()%></td>
                    <td><%=c.getUser()%></td>
                    <td><%=c.getRole()%></td>
                    <td><a href="/locationVoiture/supprimerUser?idCompte=<%=c.getIdCompte()%>"><i class="fas fa-trash-alt"></i></a></td>
                </tr>
                <%
                    } %>
                </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
    function submitForm() {
        document.forms["ajouter"].submit();
    }
</script>
</body>
</html>
