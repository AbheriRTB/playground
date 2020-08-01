package cricketish.co.joinmeeting;

public class List {
    private String name, link, meet, date, month;
    private boolean markForDelete;


    //  Constructor
    public List(String name, String link, String meet, String date, String month) {
        this.name = name;
        this.link = link;
        this.meet = meet;
    }

    public List(String name, String link, String meet, boolean markForDelete) {
        this.name = name;
        this.link = link;
        this.meet = meet;
        this.markForDelete = markForDelete;
    }

    // Getter and Setters
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

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public boolean isMarkForDelete() {
        return markForDelete;
    }

    public void setMarkForDelete(boolean markForDelete) {
        this.markForDelete = markForDelete;
    }
}
