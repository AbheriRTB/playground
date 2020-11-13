package abheri.co.protracklite.utils;

public class Subject {
    private long id;
    private String Name, Description;

    public Subject(long id, String name, String description) {
        this.id = id;
        Name = name;
        Description = description;
    }

    public Subject() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
}
