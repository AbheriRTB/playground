package cricketish.co.fragment.recyclerview;

public class Event {
    private String name, dob, pref;

    public Event(String name, String hobby, String pref) {
        this.name = name;
        this.dob = hobby;
        this.pref = pref;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHobby() {
        return dob;
    }

    public void setHobby(String dob) {
        this.dob = dob;
    }

    public String getPref() {
        return pref;
    }

    public void setPref(String pref) {
        this.pref = pref;
    }
}
