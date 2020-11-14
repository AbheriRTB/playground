package abheri.co.protracklite.utils;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DataHelper extends SQLiteOpenHelper {

    String SubjectName = "Subject";
    String TopicName = "Topic";

    public static final String TABLE_SUBJECT = "subject";
    public static final String COLUMN_SID = "_id";
    public static final String COLUMN_SUBJECT = "subject";
    public static final String COLUMN_SUBDISC = "description";


    public static final String TABLE_TOPIC = "topic";
    public static final String COLUMN_TID = "_id";
    public static final String COLUMN_TOPIC = "topic";
    public static final String SUBJECT_ID = "_sid";
    public static final String COLUMN_TDISC = "description";


    public static final String TABLE_GOAL = "goal";
    public static final String COLUMN_GID = "_id";
    public static final String COLUMN_GOAL = "goal";
    public static final String COLUMN_ENDDATE = "end_date";
    public static final String COLUMN_GDISC = "description";


    private static final String DATABASE_NAME = "protrack.db";

    private static final int DATABASE_VERSION = 1;


    private static final String subject_table = "create table "
            + TABLE_SUBJECT + "(" + COLUMN_SID
            + " integer primary key, "
            + COLUMN_SUBJECT
            + " text not null,"
            + COLUMN_SUBDISC
            + " text not null);";


    private static final String goal_table = "create table "
            + TABLE_GOAL + "(" + COLUMN_GID
            + " integer primary key, "
            + COLUMN_GOAL
            + " text not null,"
            + COLUMN_ENDDATE
            + " date not null,"
            + COLUMN_GDISC
            + " text not null);";

    private static final String topic_table = "create table "
            + TABLE_TOPIC + "(" + COLUMN_TID
            + " integer primary key, "
            + COLUMN_TOPIC
            + " text not null,"
            + COLUMN_TDISC
            + " text not null,"
            + SUBJECT_ID
            + " integer,"
            + " foreign key( "
            + SUBJECT_ID + ") references "
            + TABLE_SUBJECT
            + "(" + COLUMN_SID + "));";


    private Context dbContext;


    public DataHelper(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);
        dbContext = context;
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(subject_table);
        db.execSQL(topic_table);
        db.execSQL(goal_table);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {

    }

    public void DeleteSubjectTable(SQLiteDatabase db) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_SUBJECT + ";");
    }

    public void DeleteTopicTable(SQLiteDatabase db) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_TOPIC + ";");
    }

    public void DeleteGoalTable(SQLiteDatabase db) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_GOAL + ";");
    }


}
