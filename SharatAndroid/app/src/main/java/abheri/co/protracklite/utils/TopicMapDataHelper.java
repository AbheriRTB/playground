package abheri.co.protracklite.utils;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

public class TopicMapDataHelper {
    private SQLiteDatabase database;
    private DataHelper dbHelper;
    private String[] allColumns = { DataHelper.TOPIC_ID,
            DataHelper.GOAL_ID};

    public TopicMapDataHelper(Context context) {

        dbHelper = new DataHelper(context);
        database = dbHelper.getWritableDatabase();
    }

    public TopicMapDataHelper(Context context, SQLiteDatabase db) {
        dbHelper = new DataHelper(context);
        database = db;
    }

    public void open() throws SQLException {
        database = dbHelper.getWritableDatabase();
    }

    public void close() {
        //dbHelper.close();
    }

    public TopicDataMap createTopicDataMap(int topic_id, int goal_id, int tdm_id) {
        ContentValues values = new ContentValues();
        values.put(DataHelper.COLUMN_TDMID, tdm_id);
        values.put(DataHelper.GOAL_ID, goal_id);
        values.put(DataHelper.TOPIC_ID, topic_id);
        Cursor cursor = database.query(DataHelper.TABLE_TOPIC_DATA_MAP,
                allColumns, DataHelper.COLUMN_SID + " = " + tdm_id, null,
                null, null, null);
        cursor.moveToFirst();
        TopicDataMap newTopicDataMap = cursorToTopicDataMap(cursor);
        cursor.close();
        return newTopicDataMap;
    }

    /*public void deleteTopicDataMap(TopicDataMap subject) {
        long id = subject.getId();
        System.out.println("Sentence deleted with id: " + id);
        database.delete(DataHelper.TABLE_SUBJECT, DataHelper.COLUMN_SID
                + " = " + id, null);
    }*/

    public void deleteAllTopicDataMaps() {

        int nrows = database.delete(DataHelper.TABLE_TOPIC_DATA_MAP, "1", null);
        System.out.println(nrows + " TopicDataMaps deleted");
    }

    public List<TopicDataMap> getAllTopicDataMaps() {
        List<TopicDataMap> topicDataMaps = new ArrayList<TopicDataMap>();


        Cursor cursor = database.query(DataHelper.TABLE_TOPIC_DATA_MAP,
                allColumns, null, null, null, null, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            TopicDataMap topicDataMap = cursorToTopicDataMap(cursor);
            topicDataMaps.add(topicDataMap);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return topicDataMaps;
    }

    public List<TopicDataMap> getTopicDataMaps(long subject_id) {
        List<TopicDataMap> topicDataMaps = new ArrayList<TopicDataMap>();

        String query = "SELECT * FROM " + DataHelper.TABLE_TOPIC_DATA_MAP + " WHERE " + DataHelper.COLUMN_SID + "=" + subject_id + ";";

        Cursor cursor = database.rawQuery(query, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            TopicDataMap topicDataMap = cursorToTopicDataMap(cursor);
            topicDataMaps.add(topicDataMap);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return topicDataMaps;
    }

    private TopicDataMap cursorToTopicDataMap(Cursor cursor) {
        TopicDataMap topicDataMap = new TopicDataMap();
        topicDataMap.setTdm_id(cursor.getInt(3));
        topicDataMap.setGoal_id(cursor.getInt(0));
        topicDataMap.setTopic_id(cursor.getInt(1));
        return topicDataMap;
    }

}
