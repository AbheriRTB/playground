package abheri.co.protracklite.utils;

public class Goal {
    private String Name, Description, Date;
    private long id;

    public Goal(String name, String description, String date, long id) {
        Name = name;
        Description = description;
        Date = date;
        this.id = id;
    }

    public Goal() {

    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public String getDate() {
        return Date;
    }

    public void setDate(String date) {
        Date = date;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
}

