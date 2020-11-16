package abheri.co.protracklite;

import android.graphics.Color;
import android.os.Bundle;

import com.google.android.material.bottomappbar.BottomAppBar;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import android.view.View;

public class AddActivity extends AppCompatActivity {

    BottomAppBar appBar;
    FloatingActionButton fab;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add);

        appBar = findViewById(R.id.mainBottomAppBar2);
        setSupportActionBar(appBar);
        fab = findViewById(R.id.fab);

        fab.setColorFilter(Color.WHITE);

    }
}