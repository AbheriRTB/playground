package cricketish.co.fragment.recyclerview;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;

    ArrayList<Event> event;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        event = new ArrayList<Event>();
        event.add(new Event("Sharat", "Play Cricket", "Walk"));
        event.add(new Event("Phala", "Listen to Music", "Run"));
        event.add(new Event("Prasanna", "Play Flute", "Run"));
        event.add(new Event("Ramaswamy", "Play Solitare", "Walk"));
        event.add(new Event("Mahalakshmi", "To assign work", "Walk"));
        event.add(new Event("Usain Bolt", "Run!!", "Run"));
        event.add(new Event("Ganga", "Watch Serial", "Walk"));
        event.add(new Event("MSD", "Play Cricket", "Run"));
        event.add(new Event("Sharat", "Play Cricket", "Walk"));
        event.add(new Event("Phala", "Listen to Music", "Run"));
        event.add(new Event("Prasanna", "Play Flute", "Run"));
        event.add(new Event("Ramaswamy", "Play Solitare", "Walk"));
        event.add(new Event("Mahalakshmi", "To assign work", "Walk"));
        event.add(new Event("Usain Bolt", "Run!!", "Run"));
        event.add(new Event("Ganga", "Watch Serial", "Walk"));
        event.add(new Event("MSD", "Play Cricket", "Run"));
        event.add(new Event("Sharat", "Play Cricket", "Walk"));
        event.add(new Event("Phala", "Listen to Music", "Run"));
        event.add(new Event("Prasanna", "Play Flute", "Run"));
        event.add(new Event("Ramaswamy", "Play Solitare", "Walk"));
        event.add(new Event("Mahalakshmi", "To assign work", "Walk"));
        event.add(new Event("Usain Bolt", "Run!!", "Run"));
        event.add(new Event("Ganga", "Watch Serial", "Walk"));
        event.add(new Event("MSD", "Play Cricket", "Run"));

        myAdaptor = new EventAdaptor(this, event);
        recyclerView.setAdapter(myAdaptor);
    }
}