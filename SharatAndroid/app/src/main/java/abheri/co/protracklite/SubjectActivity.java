package abheri.co.protracklite;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.widget.TextView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;

import abheri.co.protracklite.utils.SubjectAdaptor;
import abheri.co.protracklite.utils.Subject;
import abheri.co.protracklite.utils.SubjectDataHelper;
import abheri.co.protracklite.utils.OldTopic;
import abheri.co.protracklite.utils.Topic;
import abheri.co.protracklite.utils.TopicDataHelper;

public class SubjectActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    FloatingActionButton fabAdd;
    ArrayList<OldTopic> oldTopics;
    CharSequence[] english, social, maths, science, lang;
    List<Subject> list;
    TextView tvTitle;
    List<Subject> subjects;
    List<Topic> topics;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_subject);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);
        tvTitle = findViewById(R.id.tvTitle2);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        oldTopics = new ArrayList<OldTopic>();




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

        SubjectDataHelper sdh = new SubjectDataHelper(this);

        subjects = sdh.getAllSubjects();
        TopicDataHelper tdh = new TopicDataHelper(this);
        topics = tdh.getAllTopics();

        for (int i = 0; i < subjects.size(); i++){
            List<Topic> lt;
            lt = tdh.getTopicsBySubject(subjects.get(i).getId());
            subjects.get(i).setTopics(lt);
        }

        LayoutInflater inflater = SubjectActivity.this.getLayoutInflater();
        myAdaptor = new SubjectAdaptor(this, subjects, getResources().getDrawable(R.drawable.custom_dialog), inflater, recyclerView);
        recyclerView.setAdapter(myAdaptor);

    }
}