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
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.StringTokenizer;

import it.xabaras.android.recyclerview.swipedecorator.RecyclerViewSwipeDecorator;

public class ListView extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    ItemTouchHelper itemTouchHelper;
    Button btnAdd;
    ArrayList<List> lists;
    ConstraintLayout layout;
    boolean yesClick;
    private PopupDialog_Delete.PopupListner listner;


    //For the function when  Undo clicked
    List deletedMovie = null;


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
                break;
            case R.id.btnHelp:
                intent = new Intent(getApplicationContext(), AboutActivity.class);
                startActivity(intent);
                break;

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
        itemTouchHelper = new ItemTouchHelper(simpleCallback);
        itemTouchHelper.attachToRecyclerView(recyclerView);

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

                    String lname = "noname", llink = "nolink", lmeet = "nomeet";
                    if (tokens.hasMoreElements())
                        lname = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        llink = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        lmeet = tokens.nextToken();

                    List list = new List(lname, llink, lmeet);
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
    ItemTouchHelper.SimpleCallback simpleCallback = new ItemTouchHelper.SimpleCallback(0, ItemTouchHelper.LEFT) {
        @Override
        public boolean onMove(@NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, @NonNull RecyclerView.ViewHolder target) {
            return false;
        }

        @Override
        public int getMovementFlags(RecyclerView recyclerView, RecyclerView.ViewHolder viewHolder) {

            return makeMovementFlags(0, ItemTouchHelper.LEFT);


        }

        @Override
        public void onSwiped(@NonNull RecyclerView.ViewHolder viewHolder, int direction) {
            final int position = viewHolder.getAdapterPosition();
            switch (direction) {
                case ItemTouchHelper.LEFT:
                    deletedMovie = lists.get(position);
                    lists.remove(position);
                    listner.onYesClicked();
                    myAdaptor.notifyItemRemoved(position);
                    if (yesClick){
                    Snackbar.make(recyclerView, deletedMovie.toString(), Snackbar.LENGTH_LONG).setAction("UNDO", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            lists.add(position, deletedMovie);
                            myAdaptor.notifyItemInserted(position);
                        }
                    }).setText("Deleted a meeting").show();
                    break;}

            }


        }

        @Override
        public void onChildDraw(@NonNull Canvas c, @NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, float dX, float dY, int actionState, boolean isCurrentlyActive) {
            new RecyclerViewSwipeDecorator.Builder(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
                    .addSwipeLeftBackgroundColor(ContextCompat.getColor(ListView.this, R.color.Bin))
                    .addSwipeLeftActionIcon(R.drawable.bin)
                    .addSwipeLeftLabel("Delete")
                    .setSwipeLeftLabelColor(ContextCompat.getColor(ListView.this, R.color.White))
                    .create()
                    .decorate();
            super.onChildDraw(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive);
        }
    };


    @Override
    protected void onStop(){
        super.onStop();
        saveAllData();

    }

    //  This is the method to save the data in the .txt file
    void saveAllData() {

        try {
            FileOutputStream file = openFileOutput("cricketish.data.txt", MODE_PRIVATE);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);
            for(int i=0; i<lists.size(); ++i) {
                outputFile.write(lists.get(i).getName() + "," + lists.get(i).getLink() + "," + lists.get(i).getMeet() + "\n");
            }
            outputFile.close();
            //Toast.makeText(ListView.this, "Successfully Saved", Toast.LENGTH_SHORT).show();
        } catch (IOException e) {
            Toast.makeText(ListView.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }

    }

    public void openDialog() {
        PopupDialog dialog = new PopupDialog();
        dialog.show(getSupportFragmentManager(), "example.dialog.2");

    }

    //If the user clicks ignore & proceeds to the list
    public void onYesClicked() {
        yesClick = true;
    }
}