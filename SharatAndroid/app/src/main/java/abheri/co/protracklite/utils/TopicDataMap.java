package abheri.co.protracklite.utils;

public class TopicDataMap {
    private int topic_id;
    private int goal_id;

    public int getTdm_id() {
        return tdm_id;
    }

    public void setTdm_id(int tdm_id) {
        this.tdm_id = tdm_id;
    }

    public TopicDataMap(int topic_id, int goal_id, int tdm_id) {
        this.topic_id = topic_id;
        this.goal_id = goal_id;
        this.tdm_id = tdm_id;
    }

    private int tdm_id;

    public TopicDataMap() {

    }

    public int getTopic_id() {
        return topic_id;
    }

    public void setTopic_id(int topic_id) {
        this.topic_id = topic_id;
    }

    public int getGoal_id() {
        return goal_id;
    }

    public void setGoal_id(int goal_id) {
        this.goal_id = goal_id;
    }
}
