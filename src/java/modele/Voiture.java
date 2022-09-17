package modele;

public class Voiture {
    private String matricule;
    private String modele;
    private int annemodele;
    private String marque;
    private String carburant;
    private String status;

    public Voiture(String matricule, String modele, int annemodele, String marque, String carburant, String status) {
        this.matricule = matricule;
        this.modele = modele;
        this.annemodele = annemodele;
        this.marque = marque;
        this.carburant = carburant;
        this.status = status;
    }

    public String getMatricule() {
        return matricule;
    }

    public void setMatricule(String matricule) {
        this.matricule = matricule;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public int getAnnemodele() {
        return annemodele;
    }

    public void setAnnemodele(int annemodele) {
        this.annemodele = annemodele;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getCarburant() {
        return carburant;
    }

    public void setCarburant(String carburant) {
        this.carburant = carburant;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
