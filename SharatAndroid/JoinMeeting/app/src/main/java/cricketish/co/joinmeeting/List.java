package cricketish.co.joinmeeting;

public class List {
    private String name, link, meet, date, year, minutes;
    private boolean markForDelete;
    private int hour, month;


    //  Constructor
    public List(String name, String link, String meet, String date,
                int month, String year, int hour, String minutes) {
        this.name = name;
        this.link = link;
        this.meet = meet;
        this.date = date;
        this.month = month;
        this.year = year;
        this.hour = hour;
        this.minutes = minutes;
    }

    public List(String name, String link, String meet, boolean markForDelete) {
        this.name = name;
        this.link = link;
        this.meet = meet;
        this.markForDelete = markForDelete;
    }

    ;

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

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public boolean isMarkForDelete() {
        return markForDelete;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public String getMinutes() {
        return minutes;
    }

    public void setMinutes(String minutes) {
        this.minutes = minutes;
    }

    public void setMarkForDelete(boolean markForDelete) {
        this.markForDelete = markForDelete;
    }
}
