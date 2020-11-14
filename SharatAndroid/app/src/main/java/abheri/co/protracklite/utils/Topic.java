package abheri.co.protracklite.utils;

public class Topic {
    private long id, topicID;
    private String Name, Description;

    public Topic() {

    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getTopicID() {
        return topicID;
    }

    public void setTopicID(long topicID) {
        this.topicID = topicID;
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

    public Topic(long id, long topicID, String name, String description) {
        this.id = id;
        this.topicID = topicID;
        Name = name;
        Description = description;
    }
}
