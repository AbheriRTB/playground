package abheri.co.protracklite.utils;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

public class TopicDataHelper {

    private SQLiteDatabase database;
    private DataHelper dbHelper;
    private String[] allColumns = { DataHelper.COLUMN_TID,
            DataHelper.COLUMN_TOPIC, DataHelper.COLUMN_TDISC, DataHelper.SUBJECT_ID };

    public TopicDataHelper(Context context) {
        dbHelper = new DataHelper(context);
        database = dbHelper.getWritableDatabase();
    }

    public TopicDataHelper(Context context, SQLiteDatabase db) {
        dbHelper = new DataHelper(context);
        database = dbHelper.getWritableDatabase();
    }

    public void open() throws SQLException {
        database = dbHelper.getWritableDatabase();
    }

    public void close() {
        //dbHelper.close();
    }

    public Topic createTopic(int tid, String topic, String topicDisc, int subjID) {
        ContentValues values = new ContentValues();
        values.put(DataHelper.COLUMN_TID, tid);
        values.put(DataHelper.COLUMN_TOPIC, topic);
        values.put(DataHelper.COLUMN_TDISC, topicDisc);
        values.put(DataHelper.SUBJECT_ID, subjID);
        long insertId = database.insert(DataHelper.TABLE_TOPIC, null, values);
        Cursor cursor = database.query(DataHelper.TABLE_TOPIC,
                allColumns, DataHelper.COLUMN_TID + " = " + tid, null,
                null, null, null);
        cursor.moveToFirst();
        Topic newTopic = cursorToTopic(cursor);
        cursor.close();
        return newTopic;
    }

    public void deleteTopic(Topic topic) {
        long id = topic.getTopicID();
        System.out.println("Topic deleted with id: " + id);
        database.delete(DataHelper.TABLE_TOPIC, DataHelper.COLUMN_TID
                + " = " + id, null);
    }

    public void deleteAllTopics() {
        int nrows = database.delete(DataHelper.TABLE_TOPIC, "1" , null);
        System.out.println(nrows + " Topics deleted");
    }

    public List<Topic> getAllTopics() {
        List<Topic> topics = new ArrayList<Topic>();

        Cursor cursor = database.query(DataHelper.TABLE_TOPIC,
                allColumns, null, null, null, null, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            Topic topic = cursorToTopic(cursor);
            topics.add(topic);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return topics;
    }
    public List<Topic> getTopicsBySubject(long subject_id) {
        List<Topic> topics = new ArrayList<Topic>();

        String query = "SELECT * FROM " + DataHelper.TABLE_TOPIC + " WHERE " + DataHelper.SUBJECT_ID + "=" + subject_id + ";";

        Cursor cursor = database.rawQuery(query, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            Topic topic = cursorToTopic(cursor);
            topics.add(topic);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return topics;
    }

    private Topic cursorToTopic(Cursor cursor) {
        Topic topic = new Topic();
        topic.setTopicID(cursor.getLong(0));
        topic.setName(cursor.getString(1));
        topic.setDescription(cursor.getString(2));
        topic.setId(cursor.getLong(3));
        return topic;
    }
}
