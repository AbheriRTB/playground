package cricketish.co.joinmeeting;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.ItemTouchHelper;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class ListView extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    Button btnAdd;
    String deleatedMovie = null;

    ArrayList<List> lists;

    public ListView() {
        itemTouchHelper = new ItemTouchHelper(simpleCallback);
        itemTouchHelper.attachToRecyclerView(recyclerView);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {

        getMenuInflater().inflate(R.menu.list, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            case R.id.btnAdd:
                Intent intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.MainActivity.class);
                startActivity(intent);

        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_view);
        String meet = getIntent().getStringExtra("meet");
        String name = getIntent().getStringExtra("name");
        String link = getIntent().getStringExtra("link");

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        lists = new ArrayList<List>();
        lists = loadData();
        //lists.add(new List(name, link, meet));
        myAdaptor = new ListAdaptor(this, lists);
        recyclerView.setAdapter(myAdaptor);
    }

    ArrayList<List> loadData() {

        File file = getApplicationContext().getFileStreamPath("cricketish.data.txt");
        String lineFromFile;
        ArrayList<List> retArrayList = new ArrayList<List>();

        if (file.exists()) {
            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(openFileInput("cricketish.data.txt")));
                while ((lineFromFile = reader.readLine()) != null) {
                    StringTokenizer tokens = new StringTokenizer(lineFromFile, ",");
                    List list = new List(tokens.nextToken(), tokens.nextToken(), tokens.nextToken());
                    retArrayList.add(list);
                }

                reader.close();

            } catch (IOException e) {
                Toast.makeText(this, e.getMessage(), Toast.LENGTH_SHORT).show();
            }
        }

        return retArrayList;
    }

    ItemTouchHelper itemTouchHelper;

    ItemTouchHelper.SimpleCallback simpleCallback = new ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT) {
        @Override
        public boolean onMove(@NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, @NonNull RecyclerView.ViewHolder target) {
            return false;
        }

        @Override
        public void onSwiped(@NonNull RecyclerView.ViewHolder viewHolder, int direction) {
            int position = viewHolder.getAdapterPosition();
            switch (direction) {
                case ItemTouchHelper.LEFT:
                    deleatedMovie = lists.get(position).toString();
                    lists.remove(position);
                    myAdaptor.notifyItemRemoved(position);
                    break;
            }

        }
    };

}