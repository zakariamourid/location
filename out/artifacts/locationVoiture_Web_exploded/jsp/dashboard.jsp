<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UtilConnexion" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Voiture" %>
<%@ page import="modele.Client" %>
<%@ page import="modele.Compte" %>
<!DOCTYPE html>
<html>

<head>
</head>

<body id="page-top">
<jsp:include page="entet.jsp"></jsp:include>
<%
    Compte compte= (Compte)session.getAttribute("compte");
    String role="guest";
    if(compte==null){
        response.sendRedirect("/locationVoiture/index.jsp");
    }else {
        System.out.println("--------------------------"+compte.getRole());
        role=compte.getRole();
    }
    ArrayList<Voiture> v = new ArrayList<Voiture>();
    ArrayList<Client> c = new ArrayList<Client>();
    Connection con = UtilConnexion.seConnecter();
    String sql = "SELECT * FROM voiture";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while(rs.next()){
        Voiture v1=new Voiture(rs.getString("matricule"),rs.getString("modele"),rs.getInt("annemodele"),rs.getString("marque"),rs.getString("carburant"),rs.getString("status"));
        v.add(v1);
    }
    rs.close();
    rs=stmt.executeQuery("select * from client");
    while(rs.next()){
        Client c1=new Client(rs.getString("cin"),rs.getString("nom"),rs.getString("adresse"),rs.getString("email"),rs.getString("telephone"));
        c.add(c1);
    }
    rs.close();
    rs=stmt.executeQuery("SELECT COUNT(*),SUM(prix) FROM contrat where status='finished'");
    int nbContrat = 0;
    int sommeTotal = 0;
    if(rs.next()){
        nbContrat = rs.getInt(1);
        sommeTotal = rs.getInt(2);
        System.out.println("nbContrat : "+nbContrat);
        System.out.println("SUM(prix) : "+rs.getInt(2));
    }
    rs.close();
%>
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
            <div class="container-fluid d-flex flex-column p-0"><a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="dashboard.jsp">
                    <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-car-side"></i></div>
                    <div class="sidebar-brand-text mx-3"><span>MALOCATION</span></div>
                </a>
                <hr class="sidebar-divider my-0">
                <ul class="navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link active" href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                    <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailVoiture.jsp"><i class="fas fa-car-alt"></i><span>voiture</span></a></li>
                    <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailClients.jsp"><i class="far fa-user-circle"></i><span>client</span></a></li>
                    <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailLocation.jsp"><i class="fa-duotone fa-road"></i><span>locations</span></a></li>
                    <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/ajouterUser.jsp"><i class="fas fa-user-friends"></i><span>users</span></a></li>
                </ul>
            </div>
        </nav>
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
                        <ul class="navbar-nav flex-nowrap ms-auto">
                            <li class="nav-item dropdown d-sm-none no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><i class="fas fa-search"></i></a>
                                <div class="dropdown-menu dropdown-menu-end p-3 animated--grow-in" aria-labelledby="searchDropdown">
                                    <form class="me-auto navbar-search w-100">
                                        <div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for ...">
                                            <div class="input-group-append"><button class="btn btn-primary py-0" type="button"><i class="fas fa-search"></i></button></div>
                                        </div>
                                    </form>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1"></li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                            </li>
                            <div class="d-none d-sm-block topbar-divider"></div>
                            <li class="nav-item dropdown no-arrow">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small"><%=role%><i class="fas fa-user-tie" style="font-size: 1.4rem;margin-left: 10px;"></i></span></a>
                                    <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in">
                                        <%if(role.equals("admin")){%><a class="dropdown-item" href="/locationVoiture/jsp/ajouterUser.jsp"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;users</a><%}%>
                                      <a class="dropdown-item" href="/locationVoiture/logout"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-fluid">
                    <div class="d-sm-flex justify-content-between align-items-center mb-4">
                        <h3 class="text-dark mb-0">Dashboard</h3><%if(role.equals("admin")){%><button class="btn btn-primary btn-sm d-none d-sm-inline-block " data-bs-toggle="modal" data-bs-target="#ajouterModal" data-bs-whatever="@mdo" role="button" href="#">&nbsp;ajoute une location</button><%}%>

                    </div>
                    <div class="row">
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-start-primary py-2">
                                <div class="card-body">
                                    <div class="row align-items-center no-gutters">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-primary fw-bold text-xs mb-1"><span>avaible cars</span></div>
                                            <div class="text-dark fw-bold h5 mb-0"><span><%= v.size() %></span></div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-car-side fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-start-success py-2">
                                <div class="card-body">
                                    <div class="row align-items-center no-gutters">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-success fw-bold text-xs mb-1"><span>revenus (this month)</span></div>
                                            <div class="text-dark fw-bold h5 mb-0"><span><%=sommeTotal%>DH</span></div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-dollar-sign fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-start-info py-2">
                                <div class="card-body">
                                    <div class="row align-items-center no-gutters">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-info fw-bold text-xs mb-1"><span>completed rentals</span></div>
                                            <div class="row g-0 align-items-center">
                                                <div class="col-auto">
                                                    <div class="text-dark fw-bold h5 mb-0 me-3"><span><%=nbContrat%></span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-check fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 col-xl-3 mb-4">
                            <div class="card shadow border-start-warning py-2">
                                <div class="card-body">
                                    <div class="row align-items-center no-gutters">
                                        <div class="col me-2">
                                            <div class="text-uppercase text-primary fw-bold text-xs mb-1"><span>Clients</span></div>
                                            <div class="text-dark fw-bold h5 mb-0"><span><%= c.size() %></span></div>
                                        </div>
                                        <div class="col-auto"><i class="fas fa-user-circle fa-2x text-gray-300"></i></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <table
  id="example"
  class="table table-striped table-bordered"
  cellspacing="0"
  width="100%"
>
  <thead>
    <tr>
      <th>Matricule</th>
      <th>modele</th>
      <th>anne modele</th>
      <th>marque</th>
      <th>carburant</th>
      <th>status</th>
    </tr>
  </thead>
  <tbody>
  <% for (Voiture voiture : v){
  %>
    <tr>
        <td><%= voiture.getMatricule() %></td>
        <td><%= voiture.getModele() %></td>
        <td><%= voiture.getAnnemodele() %></td>
        <td><%= voiture.getMarque() %></td>
        <td><%= voiture.getCarburant() %></td>
        <td class="bg-gradient-<%= (voiture.getStatus().equals("loue")) ? "danger" : "success" %> text-black "><%= voiture.getStatus() %></td
    </tr>
    <%
  } %>
  </tbody>
</table>

            </div>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright © zakaira mourid 2022</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
<div class="modal fade" id="ajouterModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">ajouter une location</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form name="ajouter" class="form-control" method="get" action="/locationVoiture/ajouterLocation">
                    <div class="mb-3">
                        <label for="cin" class="col-form-label">cin:</label>
                        <select id="cin" name="cin" class="form-control">
                            <option value="1">--cin--</option>
                            <%
                                for (Client client : c){
                            %>
                            <option value="<%=client.getCin()%>"><%=client.getCin()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="matricule" class="col-form-label">voiture:</label>
                        <select id="matricule" name="matricule" class="form-control">
                            <option value="1">--cin--</option>
                            <%
                                for (Voiture voiture : v){
                            %>
                            <option value="<%=voiture.getMatricule()%>"><%=voiture.getMatricule()+" "+voiture.getModele()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="dateDebut" class="col-form-label">dateDebut:</label>
                        <input type="date" name="dateDebut" class="form-control" id="dateDebut"  >
                    </div>
                    <div class="mb-3">
                        <label for="datefin" class="col-form-label">dateFin:</label>
                        <input type="date" name="datefin" class="form-control" id="datefin"  >
                    </div>
                    <div class="mb-3">
                        <label for="prix" class="col-form-label">prix:</label>
                        <input type="number" name="prix" class="form-control" id="prix"  >
                    </div>
                    <div class="mb-3">
                        <label for="status" class="col-form-label">status:</label>
                        <select id="status" name="status" class="form-control" required>
                            <option value="1">--status--</option>
                            <option value="pending">pending</option>
                            <option value="finished">finished</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" onclick="submitForm()" class="btn btn-primary">submit</button>
            </div>
        </div>
    </div>
</div>
    <script src="../assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
    <script src="../assets/js/theme.js"></script>
<script>
    function submitForm() {
        document.forms["ajouter"].submit();
    }
</script>
</body>

</html>