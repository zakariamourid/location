package modele;

public class Compte {
    private int idCompte;
    private String user;
    private String mdp;
    private String role;

    public Compte(int idCompte, String user, String mdp,String role) {
        this.idCompte = idCompte;
        this.user = user;
        this.mdp = mdp;
        this.role=role;
    }

    public int getIdCompte() {
        return idCompte;
    }

    public void setIdCompte(int idCompte) {
        this.idCompte = idCompte;
    }
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }
}
