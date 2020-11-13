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
    CharSequence[] english, social, maths, science, lang;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_topics);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        topics = new ArrayList<Topic>();


        /*fabAdd = findViewById(R.id.fabAdd);
        fabAdd.setColorFilter(Color.WHITE);
        fabAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                MaterialAlertDialogBuilder builder = new MaterialAlertDialogBuilder(MainTopicsActivity.this,
                        R.style.MyThemeOverlay_MaterialComponents_MaterialAlertDialog);

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
*/
        english = new CharSequence[]{
                "The Fun They Had",
                "The Sound of Music",
                "The Little Girl",
                "A Truly Beautiful Mind",
                "The Snake and The Mirror",
                "My Childhood",
        };
        science = new CharSequence[]{
                "Matter in Our Surrounding",
                "Is Matter Around Us Pure",
                "Atoms and Molecules",
                "Structure of the Atom",
                "The Fundamental of Unit of Life",
                "Tissues",
                "Diversity in Living Organism",
        };
        social = new CharSequence[]{
                "The French Revolution",
                "Socialism in Europe and the Russian Revolution",
                "Nazism and the Rise of Hitler",
                "Forest Society and Colonialism",
                "Pastoralists in the Modern World",
        };
        lang = new CharSequence[]{
                "Chapter V",
                "Chapter VIII"
        };
        maths = new CharSequence[]{
                "Chapter IX",
                "Chapter X"
        };

        topics.add(new Topic("English", english));
        topics.add(new Topic("Maths", maths));
        topics.add(new Topic("Social Science", social));
        topics.add(new Topic("General Science", science));
        topics.add(new Topic("II lang (Kannada)", lang));
        topics.add(new Topic("II lang (Sanskrit)", lang));
        topics.add(new Topic("II lang (Hindi)", lang));
        LayoutInflater inflater = MainTopicsActivity.this.getLayoutInflater();
        myAdaptor = new MainTopicAdaptor(this, topics, getResources().getDrawable(R.drawable.custom_dialog), inflater, recyclerView);
        recyclerView.setAdapter(myAdaptor);

    }
}