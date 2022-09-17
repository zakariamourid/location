<%--
  Created by IntelliJ IDEA.
  User: zakaria
  Date: 16/6/2022
  Time: 5:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UtilConnexion" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Voiture" %>
<%@ page import="modele.Contrat" %>
<%@ page import="modele.Compte" %>
<%@ page import="modele.Client" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Location</title>
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
    ArrayList<Contrat> ctr = new ArrayList<Contrat>();
    Connection con = UtilConnexion.seConnecter();
    String sql = "SELECT * FROM contrat";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while(rs.next()){
        Contrat c1=new Contrat(rs.getInt("idcontrat"),rs.getString("cin"),rs.getString("matricule"),rs.getString("date_debut"),rs.getString("date_fin"),rs.getInt("prix"),rs.getString("status"));
        ctr.add(c1);

    }
    rs.close();
    rs= stmt.executeQuery("SELECT * FROM voiture where status='libre'");
    ArrayList<Voiture> v = new ArrayList<Voiture>();
    while(rs.next()){
        Voiture v1=new Voiture(rs.getString("matricule"),rs.getString("modele"),rs.getInt("annemodele"),rs.getString("marque"),rs.getString("carburant"),rs.getString("status"));
        v.add(v1);

    }
    rs.close();
    rs = stmt.executeQuery("select * from client");
    ArrayList<Client> c = new ArrayList<Client>();
    while(rs.next()){
        Client c1=new Client(rs.getString("cin"),rs.getString("nom"),rs.getString("adresse"),rs.getString("email"),rs.getString("telephone"));
        c.add(c1);

    }
%>
<div id="wrapper">
    <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0">
        <div class="container-fluid d-flex flex-column p-0"><a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="dashboard.jsp">
            <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-car-side"></i></div>
            <div class="sidebar-brand-text mx-3"><span>MALOCATION</span></div>
        </a>
            <hr class="sidebar-divider my-0">
            <ul class="navbar-nav text-light" id="accordionSidebar">
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/dashboard.jsp"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                <li class="nav-item"><a class="nav-link  " href="/locationVoiture/jsp/detailVoiture.jsp"><i class="fas fa-car-alt"></i><span>voiture</span></a></li>
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/detailClients.jsp"><i class="far fa-user-circle"></i><span>client</span></a></li>
                <li class="nav-item"><a class="nav-link active " href="/locationVoiture/jsp/detailLocation.jsp"><i class="fa-duotone fa-road"></i><span>locations</span></a></li>
                <li class="nav-item"><a class="nav-link " href="/locationVoiture/jsp/ajouterUser.jsp"><i class="fas fa-user-friends"></i><span>users</span></a></li>
            </ul>
        </div>
    </nav>
    <div class="d-flex flex-column" id="content-wrapper">
        <div id="content">
            <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
                    <ul class="navbar-nav flex-nowrap ms-auto">
                        <li class="nav-item dropdown no-arrow mx-1"></li>
                        <li class="nav-item dropdown no-arrow mx-1">
                            <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                        </li>
                        <div class="d-none d-sm-block topbar-divider"></div>
                        <li class="nav-item dropdown no-arrow">
                            <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small"><%=role%><i class="fas fa-user-tie" style="margin-left: 10px;font-size: 1.4rem;"></i>&nbsp;</span></a>
                                <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in">
                                    <%if(role.equals("admin")){%><a class="dropdown-item" href="/locationVoiture/jsp/ajouterUser.jsp"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;users</a><%}%>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="/locatinVoiture/logout"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
            <div class="container-fluid">
                <%if(request.getAttribute("message")!=null){%>
                <div class="alert alert-<%=request.getAttribute("type")%>" role="alert">
                    <%=request.getAttribute("message")%>
                </div>
                <%}%>
                <div class="row">
                    <div class="col-12 col-sm-6 col-md-6">
                        <h3 class="text-dark mb-4">details des locations:</h3>
                    </div>
                    <%if(role.equals("admin")){%><div class="col-12 col-sm-6 col-md-6 text-end" style="margin-bottom: 30px;"><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ajouterModal" data-bs-whatever="@mdo">ajouter une Location</button></div><%}%>
                    </div>
                </div>

                <div class="card" id="TableSorterCard">
                    <div class="card-header py-3"><div class="row table-topper align-items-center">
                        <div class="col">
                            <div class="float-start float-md-end mt-5 mt-md-0 search-area " style="display: flex;" >
                                <input type="text" name="matricule" class=" float-start float-sm-end form-control" id="searchInput"  placeholder="search by matricule" style="margin-right: 15px;padding: 5px 10px 5px 10px">
                                <button class="btn btn-primary float-start float-sm-end" onclick="FindInTable()">search</button>
                            </div>
                        </div>
                    </div></div>
                    <div class="row">
                        <div class="col-12">
                            <div class="table-responsive">
                                <table class="table table-striped table tablesorter" id="ipi-table">
                                    <thead class="thead-dark">
                                    <tr>
                                        <th >id location</th>
                                        <th>cin</th>
                                        <th>Matricule</th>
                                        <th>date_debut</th>
                                        <th>date_fin</th>
                                        <th>prix</th>
                                        <th>status</th>
                                        <th class="text-center filter-false sorter-false">actions</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-center">
                                    <% for (Contrat contrat : ctr){
                                    %>
                                    <tr>
                                        <td><%= contrat.getIdcontract() %></td>
                                        <td><%= contrat.getCin() %></td>
                                        <td><%= contrat.getMatricule() %></td>
                                        <td><%= contrat.getDate_debut() %></td>
                                        <td><%= contrat.getDate_fin() %></td>
                                        <td><%= contrat.getPrix() %> DH</td>
                                        <td   class="bg-gradient-<%= (contrat.getStatus().equals("pending")) ? "warning" : "success" %> text-black text-center "><%= contrat.getStatus() %></td>
                                        <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                            <button class="btn btnMaterial btn-flat success semicircle modifier-modal-btn" role="button" data-bs-toggle="modal" data-bs-target="#modifier-modal" data-bs-whatever="<%= contrat.getIdcontract() %>" data-bs-matricule="<%= contrat.getMatricule() %>" data-bs-cin="<%= contrat.getCin() %>" data-bs-debut="<%= contrat.getDate_debut() %>" data-bs-fin="<%= contrat.getDate_fin() %>" data-bs-prix="<%= contrat.getPrix() %>" data-bs-status="<%= contrat.getStatus() %>" <%if (!role.equals("admin")){%>disabled<%}%>><i class="fas fa-pen"></i></button>
                                            <button class="btn btnMaterial btn-flat accent btnNoBorders checkboxHover delete-modal-btn" role="button" style="margin-left: 5px;" data-bs-toggle="modal" data-bs-target="#delete-modal"  data-bs-whatever="<%= contrat.getIdcontract() %>" <%if (!role.equals("admin")){%>disabled<%}%>><i class="fas fa-trash btnNoBorders" style="color: #DC3545;"></i></button></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
                                <label for="cin" class="col-form-label">client:</label>
                                <select id="cin" name="cin" class="form-control">
                                    <option value="1">--client--</option>
                                    <%
                                        for (Client client : c){
                                    %>
                                    <option value="<%=client.getCin()%>"><%=client.getNom()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="matricule" class="col-form-label">voiture:</label>
                                <select id="matricule" name="matricule" class="form-control">
                                    <option value="1">--voiture--</option>
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
        <div class="modal fade" id="modifier-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">modifier location</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form name="modifier" class="form-control" method="get" action="/locationVoiture/modifierLocation">
                            <div class="mb-3">
                                <label for="idlocationModifier" class="col-form-label">idlocation:</label>
                                <input type="text" name="idlocation" class="form-control" id="idlocationModifier"  readonly>
                            </div>
                            <div class="mb-3">
                                <label for="cinModifier" class="col-form-label">cin:</label>
                                <select id="cinModifier" name="cin" class="form-control">
                                    <option value="1">--cin--</option>
                                    <%
                                        for (Client client : c){
                                            %>
                                    <option value="<%=client.getCin()%>"><%=client.getCin()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="matriculeModifier" class="col-form-label">voiture:</label>
                                <select id="matriculeModifier" name="matricule" class="form-control">
                                    <option value="1">--cin--</option>
                                    <%
                                        for (Voiture voiture : v){
                                    %>
                                    <option value="<%=voiture.getMatricule()%>"><%=voiture.getMatricule()+" "+voiture.getModele()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="dateDebutModifier" class="col-form-label">dateDebut:</label>
                                <input type="date" name="dateDebut" class="form-control" id="dateDebutModifier"  >
                            </div>
                            <div class="mb-3">
                                <label for="datefinModifier" class="col-form-label">dateFin:</label>
                                <input type="date" name="datefin" class="form-control" id="datefinModifier"  >
                            </div>
                            <div class="mb-3">
                                <label for="prixModifier" class="col-form-label">prix:</label>
                                <input type="number" name="prix" class="form-control" id="prixModifier"  >
                            </div>
                            <div class="mb-3">
                                <label for="statusModifier" class="col-form-label">status:</label>
                                <select id="statusModifier" name="status" class="form-control" required>
                                    <option value="1">--status--</option>
                                    <option value="pending">pending</option>
                                    <option value="finished">finished</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" onclick="submitFormModifer()" class="btn btn-primary">submit</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="delete-modal" tabindex="-1" aria-labelledby="delete-model" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">confirmation</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        êtes-vous sûr de vouloir supprimer cette location ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger" id="delete_location" >delete</button>
                    </div>
                </div>
            </div>
        </div>
</div>
<script src="/locationVoiture/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.15/js/dataTables.bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.2/js/jquery.tablesorter.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.2/js/widgets/widget-filter.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.2/js/widgets/widget-storage.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script src="/locationVoiture/assets/js/Ludens---1-Index-Table-with-Search--Sort-Filters-v20-1.js"></script>
<script src="/locationVoiture/assets/js/Ludens---1-Index-Table-with-Search--Sort-Filters-v20.js"></script>
<script src="/locationVoiture/assets/js/theme.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
    function submitForm() {
        document.forms["ajouter"].submit();
    }
    function submitFormModifer() {
        document.forms["modifier"].submit();
    }
    var idToDelete;
    var idTomodify;
    var deleteModal = document.getElementById('delete-modal');
    document.querySelectorAll('.delete-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {

            var idlocation = btn.getAttribute('data-bs-whatever');
            idToDelete = idlocation;
            const modal = document.getElementById('delete-modal');
            console.log(idlocation);
            deleteModal.querySelector('.modal-body').innerHTML = 'êtes-vous sûr de vouloir supprimer cette location ? "'+idlocation+'"';

        })
    });
    document.querySelectorAll('.modifier-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            var idcontrat = btn.getAttribute('data-bs-whatever');
            var matricule = btn.getAttribute('data-bs-matricule');
            var cin=btn.getAttribute('data-bs-cin');
            var date_debut=btn.getAttribute('data-bs-debut');
            var date_fin=btn.getAttribute('data-bs-fin');
            var prix=btn.getAttribute('data-bs-prix');
            var status=btn.getAttribute('data-bs-status');
            console.log(status);
            document.getElementById("idlocationModifier").setAttribute("value", idcontrat);
            document.getElementById("prixModifier").setAttribute("value", prix);
            document.getElementById('matriculeModifier').value=matricule.toString();
            document.getElementById('cinModifier').value=cin.toString();
            document.getElementById('statusModifier').value=status.toString();
            document.getElementById('dateDebutModifier').value=date_debut.toString();
            document.getElementById('datefinModifier').value=date_fin.toString();



        })
    });
    document.getElementById('delete_location').addEventListener('click', () => {
        $.get(
            '/locationVoiture/deleteLocation',
            {
                id: idToDelete
            },
            function (data) {
                console.log(data);
                location.reload();
            }
        );

    });


    function FindInTable() {
        // Declare variables
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("ipi-table");
        tr = table.getElementsByTagName("tr");
        console.log("hello brothers");
        if (filter == "") {
            for (i = 0; i < tr.length; i++) {
                tr[i].style.display = "";
            }
        } else {
            for (i = 0; i < tr.length; i++) {
                td = tr[i].getElementsByTagName("td")[0];
                if (td) {
                    txtValue = td.textContent || td.innerText;
                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }
            }
        }


    }



</script>
</body>

</html>