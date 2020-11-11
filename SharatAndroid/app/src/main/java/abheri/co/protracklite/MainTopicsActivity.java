package abheri.co.protracklite;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.DialogInterface;
import android.graphics.Color;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.material.dialog.MaterialAlertDialogBuilder;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;

public class MainTopicsActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    FloatingActionButton fabAdd;

    ArrayList<Topic> topics;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_topics);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        topics = new ArrayList<Topic>();


        fabAdd = findViewById(R.id.fabAdd);
        fabAdd.setColorFilter(Color.WHITE);
        fabAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MaterialAlertDialogBuilder builder = new MaterialAlertDialogBuilder(MainTopicsActivity.this,
                        R.style.MyThemeOverlay_MaterialComponents_MaterialAlertDialog);
                LayoutInflater inflater = MainTopicsActivity.this.getLayoutInflater();
                View view = inflater.inflate(R.layout.dialog_text_input, null);
                builder.setView(view)
                        .setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                            }
                        })
                        .setPositiveButton("ok", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {

                            }
                        })
                        .setBackground(getResources().getDrawable(R.drawable.custom_dialog));
                builder.show();
            }
        });

        topics.add(new Topic("MS Dhoni"));
        topics.add(new Topic("Ab de Villers"));
        topics.add(new Topic("Virat Kohli"));
        topics.add(new Topic("Sharatchandra"));

        myAdaptor = new MainTopicAdaptor(this, topics);
        recyclerView.setAdapter(myAdaptor);

    }
}