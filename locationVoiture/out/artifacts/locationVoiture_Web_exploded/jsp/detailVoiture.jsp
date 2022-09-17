<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UtilConnexion" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="modele.Voiture" %>
<%@ page import="modele.Compte" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Voiture</title>
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
    Connection con = UtilConnexion.seConnecter();
    String sql = "SELECT * FROM voiture";
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
    while(rs.next()){
        Voiture v1=new Voiture(rs.getString("matricule"),rs.getString("modele"),rs.getInt("annemodele"),rs.getString("marque"),rs.getString("carburant"),rs.getString("status"));
        v.add(v1);

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
                <li class="nav-item"><a class="nav-link active " href="/locationVoiture/jsp/detailVoiture.jsp"><i class="fas fa-car-alt"></i><span>voiture</span></a></li>
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
                        <li class="nav-item dropdown no-arrow mx-1"></li>
                        <li class="nav-item dropdown no-arrow mx-1">
                            <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                        </li>
                        <div class="d-none d-sm-block topbar-divider"></div>
                        <li class="nav-item dropdown no-arrow">
                            <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small">admin<i class="fas fa-user-tie" style="margin-left: 10px;font-size: 1.4rem;"></i>&nbsp;</span></a>
                                <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in">
                                    <%if(role.equals("admin")){%><a class="dropdown-item" href="/locationVoiture/jsp/ajouterUser.jsp"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;users</a><%}%>
                                    <a class="dropdown-item" href="/locationVoiture/logout"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>=
            </nav>
            <div class="container-fluid">
    <%if(request.getAttribute("message")!=null){%>
                <div class="alert alert-<%=request.getAttribute("type")%>" role="alert">
                    <%=request.getAttribute("message")%>
                </div>
                <%}%>
                <div class="row">
                    <div class="col-12 col-sm-6 col-md-6">
                        <h3 class="text-dark mb-4">details des voitures:</h3>
                    </div>
                    <div class="col-12 col-sm-6 col-md-6 text-end" style="margin-bottom: 30px;"><button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#ajouterModal" data-bs-whatever="@mdo">ajouter une voiture</button>
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
                                        <th>Matricule</th>
                                        <th>modele</th>
                                        <th>anne modele</th>
                                        <th>marque</th>
                                        <th>carburant</th>
                                        <th>status</th>
                                        <th class="text-center filter-false sorter-false">actions</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-center">
                                    <% for (Voiture voiture : v){
                                    %>
                                    <tr>
                                        <td><%= voiture.getMatricule() %></td>
                                        <td><%= voiture.getModele() %></td>
                                        <td><%= voiture.getAnnemodele() %></td>
                                        <td><%= voiture.getMarque() %></td>
                                        <td><%= voiture.getCarburant() %></td>
                                        <td   class="bg-gradient-<%= (voiture.getStatus().equals("loue")) ? "danger" : "success" %> text-black text-center "><%= voiture.getStatus() %></td>
                                        <td class="text-center align-middle" style="max-height: 60px;height: 60px;">
                                            <button class="btn btnMaterial btn-flat success semicircle modifier-modal-btn" role="button" data-bs-toggle="modal" data-bs-target="#modifier-modal" data-bs-whatever="<%= voiture.getMatricule() %>" data-bs-modele="<%= voiture.getModele() %>" data-bs-marque="<%= voiture.getMarque() %>" data-bs-annemodel="<%= voiture.getAnnemodele() %>" data-bs-status="<%= voiture.getStatus() %>" data-bs-carburant="<%= voiture.getCarburant() %>"><i class="fas fa-pen"></i></button>
                                            <button class="btn btnMaterial btn-flat accent btnNoBorders checkboxHover delete-modal-btn" role="button" style="margin-left: 5px;" data-bs-toggle="modal" data-bs-target="#delete-modal"  data-bs-whatever="<%= voiture.getMatricule() %>"><i class="fas fa-trash btnNoBorders" style="color: #DC3545;"></i></button></td>
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
                        <h5 class="modal-title" id="exampleModalLabel">ajouter modal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form name="ajouter" class="form-control" method="get" action="/locationVoiture/ajouterVoiture">
                            <div class="mb-3">
                                <label for="recipient-name" class="col-form-label">Matricule:</label>
                                <input type="text" name="matricule" class="form-control" id="recipient-name" required>
                            </div>
                            <div class="mb-3">
                                <label for="modele-text" class="col-form-label">modele:</label>
                                <input type="text" name="modele" class="form-control" id="recipient-name" required>
                            </div>
                            <div class="mb-3">
                                <label for="annnemodele-text" class="col-form-label">anne modele:</label>
                                <select id="annemodele" name="annemodele" class="form-control" required>
                                    <option value="1">--year--</option>
                                    <option value="2022">2022</option>
                                    <option value="2021">2021</option>
                                    <option value="2020">2020</option>
                                    <option value="2019">2019</option>
                                    <option value="2018">2018</option>
                                    <option value="2017">2017</option>
                                    <option value="2016">2016</option>
                                    <option value="2015">2015</option>
                                    <option value="2014">2014</option>
                                    <option value="2013">2013</option>
                                    <option value="2012">2012</option>
                                    <option value="2011">2011</option>
                                    <option value="2010">2010</option>
                                    <option value="2009">2009</option>
                                    <option value="2008">2008</option>
                                    <option value="2007">2007</option>
                                    <option value="2006">2006</option>
                                    <option value="2005">2005</option>
                                    <option value="2004">2004</option>
                                    <option value="2003">2003</option>
                                    <option value="2002">2002</option>
                                    <option value="2001">2001</option>
                                    <option value="2000">2000</option>
                                    <option value="1999">1999</option>
                                    <option value="1998">1998</option>
                                    <option value="1997">1997</option>
                                    <option value="1996">1996</option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                </select>

                            </div>
                            <div class="mb-3">
                                <label for="annnemodele-text" class="col-form-label">marque:</label>
                                <input type="text" name="marque" class="form-control" id="marque-name">
                            </div>
                            <div class="mb-3">
                                <label for="carburant-text" class="col-form-label">carburant:</label>
                                <select id="carburant" name="carburant" class="form-control">
                                    <option value="1">--carburant--</option>
                                    <option value="diesel">diesel</option>
                                    <option value="essence">essence</option>
                                    <option value="hybride">hybride</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="status-text" class="col-form-label">status:</label>
                                <select id="status" name="status" class="form-control" required>
                                    <option value="1">--status--</option>
                                    <option value="loue">loue</option>
                                    <option value="libre">libre</option>
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
                        <h5 class="modal-title" id="exampleModalLabel">modifier modal</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form name="modifier" class="form-control" method="get" action="/locationVoiture/modifierVoiture">
                            <div class="mb-3">
                                <label for="recipient-name" class="col-form-label">Matricule:</label>
                                <input type="text" name="matricule" class="form-control" id="matricule-text"  readonly>
                            </div>
                            <div class="mb-3">
                                <label for="modele-text" class="col-form-label">modele:</label>
                                <input type="text" name="modele" class="form-control" id="modeleVoiture">
                            </div>
                            <div class="mb-3">
                                <label for="annnemodele-text" class="col-form-label">anne modele:</label>
                                <select id="annemodelemodifier" name="annemodele" class="form-control">
                                    <option value="1">--year--</option>
                                    <option value="2020">2020</option>
                                    <option value="2019">2019</option>
                                    <option value="2018">2018</option>
                                    <option value="2017">2017</option>
                                    <option value="2016">2016</option>
                                    <option value="2015">2015</option>
                                    <option value="2014">2014</option>
                                    <option value="2013">2013</option>
                                    <option value="2012">2012</option>
                                    <option value="2011">2011</option>
                                    <option value="2010">2010</option>
                                    <option value="2009">2009</option>
                                    <option value="2008">2008</option>
                                    <option value="2007">2007</option>
                                    <option value="2006">2006</option>
                                    <option value="2005">2005</option>
                                    <option value="2004">2004</option>
                                    <option value="2003">2003</option>
                                    <option value="2002">2002</option>
                                    <option value="2001">2001</option>
                                    <option value="2000">2000</option>
                                    <option value="1999">1999</option>
                                    <option value="1998">1998</option>
                                    <option value="1997">1997</option>
                                    <option value="1996">1996</option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                </select>

                            </div>
                            <div class="mb-3">
                                <label for="annnemodele-text" class="col-form-label">marque:</label>
                                <input type="text" name="marque" class="form-control" id="marqueVoiture">
                            </div>
                            <div class="mb-3">
                                <label for="carburant-text" class="col-form-label">carburant:</label>
                                <select id="carburantmodifier" name="carburant" class="form-control">
                                    <option value="1">--carburant--</option>
                                    <option value="diesel">diesel</option>
                                    <option value="essence">essence</option>
                                    <option value="hybride">hybride</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="status-text" class="col-form-label">status:</label>
                                <select id="statusmodifier" name="status" class="form-control">
                                    <option value="1">--status--</option>
                                    <option value="loue">loue</option>
                                    <option value="libre">libre</option>
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
                       are you sure you want to delete this vehiicule ?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-danger" id="delete_voiture" >delete</button>
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

            var matricule = btn.getAttribute('data-bs-whatever');
            idToDelete = matricule;
            const modal = document.getElementById('delete-modal');
            console.log(matricule);
            deleteModal.querySelector('.modal-body').innerHTML = 'are you sure you want to delete this vehicule "'+matricule+'"';

        })
    });
    document.querySelectorAll('.modifier-modal-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            var matricule = btn.getAttribute('data-bs-whatever');
            var modele = btn.getAttribute('data-bs-modele');
            var marque=btn.getAttribute('data-bs-marque');
            var anneemodele=btn.getAttribute('data-bs-annemodel');
            var carburant=btn.getAttribute('data-bs-carburant');
            var status=btn.getAttribute('data-bs-status');
            document.getElementById('annemodelemodifier').value=anneemodele.toString();
            document.getElementById('carburantmodifier').value=carburant.toString();
            document.getElementById('statusmodifier').value=status.toString();

            idTomodify = matricule;
            const modal = document.getElementById('modifier-modal');
            modal.querySelector("#matricule-text").setAttribute("value", matricule);
            modal.querySelector("#modeleVoiture").setAttribute("value", modele);
            modal.querySelector("#marqueVoiture").setAttribute("value", marque);


        })
    });
    document.getElementById('delete_voiture').addEventListener('click', () => {
        $.get(
            '/locationVoiture/deleteVoiture',
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