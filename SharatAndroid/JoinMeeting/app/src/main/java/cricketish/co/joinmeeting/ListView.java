package cricketish.co.joinmeeting;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.ItemTouchHelper;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.graphics.Canvas;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.google.android.material.snackbar.Snackbar;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

import it.xabaras.android.recyclerview.swipedecorator.RecyclerViewSwipeDecorator;

public class ListView extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    Button btnAdd;
    ArrayList<List> lists;
    ConstraintLayout layout;

    //For the function when  Undo clicked
    List deletedMovie = null;


    public ListView() {
        itemTouchHelper = new ItemTouchHelper(simpleCallback);
        itemTouchHelper.attachToRecyclerView(recyclerView);
    }


    //  This function is to bring the button on the Action Bar (From Here)
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
            case R.id.btnHelp:
                intent = new Intent(getApplicationContext(), cricketish.co.joinmeeting.HelpActivity.class);
                startActivity(intent);

        }

        return super.onOptionsItemSelected(item);
    }
    //  (Till Here)


    //  Finally the app starts here
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_list_view);
        String meet = getIntent().getStringExtra("meet");
        String name = getIntent().getStringExtra("name");
        String link = getIntent().getStringExtra("link");

        layout = findViewById(R.id.layot);
        layout.setVisibility(View.INVISIBLE);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        lists = new ArrayList<List>();
        lists = loadData();
        myAdaptor = new ListAdaptor(this, lists);
        recyclerView.setAdapter(myAdaptor);

        if (lists.size() == 0) {
            layout.setVisibility(View.VISIBLE);
        }
    }

    //  This function wraps up the data for the list from the .txt file
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


    // This is the Swipe to delete functionality (Till 162)
    //  TODO Fix the problem(Swipe function not working)
    ItemTouchHelper itemTouchHelper;
    ItemTouchHelper.SimpleCallback simpleCallback = new ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT) {
        @Override
        public boolean onMove(@NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, @NonNull RecyclerView.ViewHolder target) {
            return false;
        }

        @Override
        public void onSwiped(@NonNull RecyclerView.ViewHolder viewHolder, int direction) {
            final int position = viewHolder.getAdapterPosition();
            switch (direction) {
                case ItemTouchHelper.LEFT:
                    deletedMovie = lists.get(position);
                    lists.remove(position);
                    myAdaptor.notifyItemRemoved(position);
                    Snackbar.make(recyclerView, deletedMovie.toString(), Snackbar.LENGTH_LONG).setAction("UNDO", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            lists.add(position, deletedMovie);
                            myAdaptor.notifyItemInserted(position);
                        }
                    }).show();
                    break;
            }

        }

        @Override
        public void onChildDraw(@NonNull Canvas c, @NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, float dX, float dY, int actionState, boolean isCurrentlyActive) {
            new RecyclerViewSwipeDecorator.Builder(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
                    .addSwipeLeftBackgroundColor(ContextCompat.getColor(ListView.this, R.color.Bin))
                    .addSwipeLeftActionIcon(R.drawable.bin)
                    .addSwipeLeftLabel("Delete")
                    .create()
                    .decorate();
            super.onChildDraw(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive);
        }
    };
}