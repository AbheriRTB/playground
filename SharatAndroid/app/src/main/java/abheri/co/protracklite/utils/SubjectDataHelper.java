package abheri.co.protracklite.utils;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.SQLException;
import android.database.sqlite.SQLiteDatabase;

import java.util.ArrayList;
import java.util.List;

public class SubjectDataHelper {
    private SQLiteDatabase database;
    private DataHelper dbHelper;
    private String[] allColumns = { DataHelper.COLUMN_SID,
            DataHelper.COLUMN_SUBJECT,DataHelper.COLUMN_SUBDISC, DataHelper.COLUMN_SID };

    public SubjectDataHelper(Context context) {

        dbHelper = new DataHelper(context);
        database = dbHelper.getWritableDatabase();
    }

    public SubjectDataHelper(Context context, SQLiteDatabase db) {
        dbHelper = new DataHelper(context);
        database = db;
    }

    public void open() throws SQLException {
        database = dbHelper.getWritableDatabase();
    }

    public void close() {
        //dbHelper.close();
    }

    public Subject createSubject(String subject, String description, int tid) {
        ContentValues values = new ContentValues();
        values.put(DataHelper.COLUMN_SID, tid);
        values.put(DataHelper.COLUMN_SUBJECT, subject);
        values.put(DataHelper.COLUMN_SUBDISC, description);

        long insertId = database.insert(DataHelper.TABLE_SUBJECT, null,
                values);
        Cursor cursor = database.query(DataHelper.TABLE_SUBJECT,
                allColumns, DataHelper.COLUMN_SID + " = " + tid, null,
                null, null, null);
        cursor.moveToFirst();
        Subject newSubject = cursorToSubject(cursor);
        cursor.close();
        return newSubject;
    }

    public void deleteSubject(Subject subject) {
        long id = subject.getId();
        System.out.println("Sentence deleted with id: " + id);
        database.delete(DataHelper.TABLE_SUBJECT, DataHelper.COLUMN_SID
                + " = " + id, null);
    }

    public void deleteAllSubjects() {

        int nrows = database.delete(DataHelper.TABLE_SUBJECT, "1", null);
        System.out.println(nrows + " Subjects deleted");
    }

    public List<Subject> getAllSubjects() {
        List<Subject> subjects = new ArrayList<Subject>();


        Cursor cursor = database.query(DataHelper.TABLE_SUBJECT,
                allColumns, null, null, null, null, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            Subject subject = cursorToSubject(cursor);
            subjects.add(subject);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return subjects;
    }

    public List<Subject> getSubjects(long subject_id) {
        List<Subject> subjects = new ArrayList<Subject>();

        String query = "SELECT * FROM " + DataHelper.TABLE_SUBJECT + " WHERE " + DataHelper.COLUMN_SID + "=" + subject_id + ";";

        Cursor cursor = database.rawQuery(query, null);

        cursor.moveToFirst();
        while (!cursor.isAfterLast()) {
            Subject subject = cursorToSubject(cursor);
            subjects.add(subject);
            cursor.moveToNext();
        }
        // make sure to close the cursor
        cursor.close();
        return subjects;
    }

    private Subject cursorToSubject(Cursor cursor) {
        Subject subject = new Subject();
        subject.setId(cursor.getLong(0));
        subject.setName(cursor.getString(1));
        subject.setDescription(cursor.getString(2));
        return subject;
    }

}
