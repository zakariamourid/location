<%--
  Created by IntelliJ IDEA.
  User: zakaria
  Date: 16/6/2022
  Time: 4:10 PM
  To change this template use File | Settings | File Templates.
--%>
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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Client</title>
</head>

<body id="page-top">
<jsp:include page="entet.jsp"></jsp:include>
<%    Compte compte= (Compte)session.getAttribute("compte");
    if(compte==null){
        response.sendRedirect("/locationVoiture/jsp/index.jsp");
    }
    ArrayList<Client> c = new ArrayList<Client>();
    Connection con = UtilConnexion.seConnecter();
    String sql = "SELECT * FROM Client";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
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
                <li class="nav-item"><a class="nav-link " href="dashboard.jsp"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                <li class="nav-item"><a class="nav-link  " href="/locationVoiture/jsp/detailVoiture.jsp"><i class="fas fa-car-alt"></i><span>voiture</span></a></li>
                <li class="nav-item"><a class="nav-link active" href="/locationVoiture/jsp/detailClients.jsp"><i class="far fa-user-circle"></i><span>client</span></a></li>
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
                        <li class="nav-item dropdown no-arrow mx-1"></li>
                        <li class="nav-item dropdown no-arrow mx-1">
                            <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                        </li>
                        <div class="d-none d-sm-block topbar-divider"></div>
                        <li class="nav-item dropdown no-arrow">
                            <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small">admin<i class="fas fa-user-tie" style="margin-left: 10px;font-size: 1.4rem;"></i>&nbsp;</span></a>
                                <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in">
                                    <div class="dropdown-divider"></div><a class="dropdown-item" href="#"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
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
                        <h3 class="text-dark mb-4">details des Clients:</h3>
                    </div>
                    <div class="col-12 col-sm-6 col-md-6 text-end" style="margin-bottom: 30px;"><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ajouterModal" data-bs-whatever="@mdo">ajouter un client</button>
                    </div>
                </div>
                <div class="card" id="TableSorterCard">
                    <div class="card-header py-3"><div class="row table-topper align-items-center">
                        <div class="col">
                            <div class="float-start float-md-end mt-5 mt-md-0 search-area " style="display: flex;" >
                                <input type="text" name="matricule" class=" float-start float-sm-end form-control" id="searchInput"  placeholder="search by cin" style="margin-right: 15px;padding: 5px 10px 5px 10px">
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
                                        <th>cin</th>
                                        <th>nom</th>
                                        <th>email</th>
                                        <th>adresse</th>
                                        <th>telephone</th>
                                        <th class="text-center filter-false sorter-false">actions</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-center">
                                    <% for (Client client : c){
                                    %>
                                    <tr>
                                        <td><%= client.getCin() %></td>
                                        <td><%= client.getNom() %></td>
                                        <td><%= client.getEmail() %></td>
                                        <td><%= client.getAdresse() %></td>
                                        <td><%= client.getTel() %></td>
                                        <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                            <button class="btn btnMaterial btn-flat success semicircle modifier-modal-btn" role="button" data-bs-toggle="modal" data-bs-target="#modifier-modal" data-bs-cin="<%= client.getCin() %>" data-bs-nom="<%= client.getNom() %>" data-bs-email="<%= client.getEmail() %>" data-bs-adresse="<%= client.getAdresse() %>" data-bs-telephone="<%= client.getTel() %>" ><i class="fas fa-pen"></i></button>
                                            <button class="btn btnMaterial btn-flat accent btnNoBorders checkboxHover delete-modal-btn" role="button" style="margin-left: 5px;" data-bs-toggle="modal" data-bs-target="#delete-modal"  data-bs-cin="<%= client.getCin() %>"><i class="fas fa-trash btnNoBorders" style="color: #DC3545;"></i></button></td>
                                    </tr>
                                    <%
                                        } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="bg-white sticky-footer">
            <div class="container my-auto">
                <div class="text-center my-auto copyright"><span>Copyright © zakaria-mourid 2022</span></div>
            </div>
        </footer>
        <div class="modal fade" id="ajouterModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">ajouter client</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form name="ajouter" id="ajouterForm" class="form-control" method="get" action="/locationVoiture/ajouterClient">
                            <div class="mb-3">
                                <label for="cin" class="col-form-label">cin:</label>
                                <input type="text" name="cin" class="form-control" id="cin" required placeholder="cin">
                            </div>
                            <div class="mb-3">
                                <label for="nom" class="col-form-label">nom:</label>
                                <input type="text" name="nom" class="form-control" id="nom" required placeholder="nom">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="col-form-label">email:</label>
                                <input type="email" name="email" class="form-control" id="email" placeholder="email">
                            </div>
                            <div class="mb-3">
                                <label for="adresse" class="col-form-label">adresse:</label>
                                <input type="text" name="adresse" class="form-control" id="adresse" placeholder="adresse">
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="col-form-label">telephone:</label>
                                <input type="tel" name="telephone" class="form-control" id="telephone" placeholder="06XXXXXXXX">
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
                        <h5 class="modal-title" id="exampleModalLabel">modifier client</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form name="modifier" id="modifierForm" class="form-control" method="get" action="/locationVoiture/modifierClient">
                            <div class="mb-3">
                                <label for="cin" class="col-form-label">cin:</label>
                                <input type="text" name="cin" class="form-control" id="cinModifier" required placeholder="cin" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="nom" class="col-form-label">nom:</label>
                                <input type="text" name="nom" class="form-control" id="nomModifer" required placeholder="nom">
                            </div>
                            <div class="mb-3">
                                <label for="email" class="col-form-label">email:</label>
                                <input type="email" name="email" class="form-control" id="emailModifer" placeholder="email">
                            </div>
                            <div class="mb-3">
                                <label for="adresse" class="col-form-label">adresse:</label>
                                <input type="text" name="adresse" class="form-control" id="adresseModifier" placeholder="adresse">
                            </div>
                            <div class="mb-3">
                                <label for="telephone" class="col-form-label">telephone:</label>
                                <input type="tel" name="telephone" class="form-control" id="telephoneModifier" placeholder="06XXXXXXXX">
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
                        are you sure you want to delete this client ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger" id="delete_client" >delete</button>
                    </div>
                </div>
            </div>
        </div>
    </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
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
        $.ajax({
            type : 'get',
            url : '/locationVoiture/ajouterClient',
            data : $('#ajouterForm').serialize(),
            success:function (data) {
                location.reload()
            }
        });
    }
    function submitFormModifer() {
        document.forms["modifier"].submit();
    }
    var idToDelete;
    var deleteModal = document.getElementById('delete-modal');
    document.querySelectorAll('.delete-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            var cin = btn.getAttribute('data-bs-cin');
            console.log(cin);
            idToDelete = cin;
            const modal = document.getElementById('delete-modal');

            deleteModal.querySelector('.modal-body').innerHTML = 'are you sure you want to delete this client "'+cin+'"';

        })
    });
    document.querySelectorAll('.modifier-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            var cin = btn.getAttribute('data-bs-cin');
            var nom = btn.getAttribute('data-bs-nom');
            var adresse=btn.getAttribute('data-bs-adresse');
            var email=btn.getAttribute('data-bs-email');
            var telephone=btn.getAttribute('data-bs-telephone');
            document.getElementById('cinModifier').value=cin.toString();
            document.getElementById('nomModifer').value=nom.toString();
            document.getElementById('adresseModifier').value=adresse.toString();
            document.getElementById('emailModifer').value=email.toString();
            document.getElementById('telephoneModifier').value=telephone.toString();
            console.log("cin: "+cin+" nom: "+nom+" adresse: "+adresse+" email: "+email+" telephone: "+telephone);
        })
    });
    document.getElementById('delete_client').addEventListener('click', () => {
        $.get(
            '/locationVoiture/deleteClient',
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