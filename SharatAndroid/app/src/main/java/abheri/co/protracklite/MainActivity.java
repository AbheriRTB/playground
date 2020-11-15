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
            sdh.createSubject("II lang (Hindi)", "Hindi", 2);
            sdh.createSubject("II lang (Kannada)", "Kannada", 3);
            sdh.createSubject("II lang (Sanskrit)", "Sanskrit", 4);
            sdh.createSubject("Maths", "Mathematics", 6);
            sdh.createSubject("Science", "General Science", 7);
            sdh.createSubject("Social", "Social Science", 8); }


        if(ts.size() <= 0) {

            // English Portions
            tdh.createTopic(1, "The Fun They Had", "This is chapter I", 1);
            tdh.createTopic(2, "The Road Not Taken", "This is poem I", 1);
            tdh.createTopic(3, "The Sound of Music", "This is chapter II", 1);
            tdh.createTopic(4, "Wind", "This is poem II", 1);
            tdh.createTopic(5, "The Little Girl", "This is chapter III", 1);
            tdh.createTopic(6, "Rain on the Roof", "This is poem III", 1);
            tdh.createTopic(7, "A Truly Beautiful Mind", "This is chapter IV", 1);
            tdh.createTopic(8, "The Lake Isle of Innisfree", "This is poem IV", 1);
            tdh.createTopic(9, "The Snake and the Mirror", "This is chapter V", 1);
            tdh.createTopic(10, "A Legend of the Northland", "This is poem V", 1);
            tdh.createTopic(11, "My Childhood", "This is chapter VI", 1);
            tdh.createTopic(12, "No Men Are Foreign", "This is poem VI", 1);
            tdh.createTopic(13, "Packing", "This is chapter VII", 1);
            tdh.createTopic(14, "The Duck and the Kangaroo", "This is poem VII", 1);
            tdh.createTopic(15, "Reach for the Top", "This is chapter VIII", 1);
            tdh.createTopic(16, "On Killing a Tree", "This is poem VIII", 1);
            tdh.createTopic(17, "The Bond of Love", "This is chapter IX", 1);
            tdh.createTopic(18, "The Snake Trying", "This is poem IX", 1);
            tdh.createTopic(19, "Kathmandu", "This is chapter X", 1);
            tdh.createTopic(20, "A Slumber Did My Spirit Seal", "This is poem X", 1);
            tdh.createTopic(21, "If I Were You", "This is chapter XI", 1);
            tdh.getAllTopics();
        }

        if(gs.size() <= 0) {
        gdh.createGoal("Mid-Term Exams","There will be mid term exams this month", "1/12/2020", 1);
        gdh.getAllGoals();}

    }
}