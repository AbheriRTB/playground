package cricketish.co.joinmeeting;

public class List {
    private String name, link, meet;


    public List(String name, String link, String meet) {
        this.name = name;
        this.link = link;
        this.meet = meet;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getMeet() {
        return meet;
    }

    public void setMeet(String meet) {
        this.meet = meet;
    }
}
