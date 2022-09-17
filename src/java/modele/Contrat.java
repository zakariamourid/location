package modele;

public class Contrat {
    private int idcontract;
    private String cin;
    private String matricule;
    private String date_debut;
    private String date_fin;
    private int prix;
    private String status;

    public Contrat(int idcontract, String cin, String matricule, String date_debut, String date_fin, int prix, String status) {
        this.idcontract = idcontract;
        this.cin = cin;
        this.matricule = matricule;
        this.date_debut = date_debut;
        this.date_fin = date_fin;
        this.prix = prix;
        this.status = status;
    }

    public int getIdcontract() {
        return idcontract;
    }

    public String getCin() {
        return cin;
    }

    public String getMatricule() {
        return matricule;
    }

    public String getDate_debut() {
        return date_debut;
    }

    public String getDate_fin() {
        return date_fin;
    }

    public int getPrix() {
        return prix;
    }

    public String getStatus() {
        return status;
    }
}

