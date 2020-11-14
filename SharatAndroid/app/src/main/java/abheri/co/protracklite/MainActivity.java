package abheri.co.protracklite;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

import com.google.android.material.bottomappbar.BottomAppBar;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.List;

import abheri.co.protracklite.utils.Goal;
import abheri.co.protracklite.utils.GoalDataHelper;
import abheri.co.protracklite.utils.Subject;
import abheri.co.protracklite.utils.SubjectDataHelper;
import abheri.co.protracklite.utils.Topic;
import abheri.co.protracklite.utils.TopicDataHelper;

public class MainActivity extends AppCompatActivity {

    BottomAppBar appBar;
    FloatingActionButton floatingActionButton;

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.main_menue, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            // action with ID action_refresh was selected
            case R.id.aboutMenu:

                break;
            // action with ID action_settings was selected
            case R.id.addMenu:

                break;
            // action with ID action_settings was selected
            case R.id.manageMenu:
                Intent intent = new Intent(MainActivity.this, SubjectActivity.class);
                startActivity(intent);
                break;
        }

        return true;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        appBar = findViewById(R.id.mainBottomAppBar);
        setSupportActionBar(appBar);
        floatingActionButton = findViewById(R.id.floatingActionButton);

        floatingActionButton.setColorFilter(Color.WHITE);

        SubjectDataHelper sdh = new SubjectDataHelper(this);
        TopicDataHelper tdh = new TopicDataHelper(this);
        GoalDataHelper gdh = new GoalDataHelper(this);


        List<Subject> ls = sdh.getAllSubjects();
        List<Topic> ts = tdh.getAllTopics();
        List<Goal> gs = gdh.getAllGoals();
        if(ls.size() <= 0) {
            sdh.createSubject("English", "English Subject", 1);
            sdh.createSubject("II lang (Kannada)", "Kannada", 2);
            sdh.createSubject("II lang (Hindi)", "Hindi", 3);
            sdh.createSubject("II lang (Sanskrit)", "Sanskrit", 4);
            sdh.createSubject("Social", "Social Science", 5);
            sdh.createSubject("Science", "General Science", 6);
            sdh.createSubject("Maths", "Mathematics", 7);
        }


        if(ts.size() <= 0) {
            tdh.createTopic(1, "Chapter I", "This is chapter I", 2);
            tdh.createTopic(2, "Chapter II", "This is chapter II", 2);
            tdh.createTopic(3, "Chapter III", "This is chapter III", 2);
            tdh.createTopic(4, "Chapter IV", "This is chapter IV", 2);
            tdh.createTopic(5, "Chapter V", "This is chapter V", 2);
            tdh.createTopic(6, "Chapter I", "This is chapter V", 4);
            tdh.getAllTopics();
        }

        if(gs.size() <= 0) {
        gdh.createGoal("Mid-Term Exams","There will be mid term exams this month", "1/12/2020", 1);
        gdh.getAllGoals();}

    }
}