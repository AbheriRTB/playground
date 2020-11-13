package abheri.co.protracklite;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;

import com.google.android.material.bottomappbar.BottomAppBar;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import abheri.co.protracklite.utils.Subject;
import abheri.co.protracklite.utils.SubjectDataHelper;
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
                Intent intent = new Intent(MainActivity.this, MainTopicsActivity.class);
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
        sdh.createSubject("Maths", "Mathematics", 1);
        sdh.getAllSubjects();

        TopicDataHelper tdh = new TopicDataHelper(this);
        tdh.createTopic(1, "Chapter I", "This is chapter I", 2);
        tdh.getAllTopics();

    }
}