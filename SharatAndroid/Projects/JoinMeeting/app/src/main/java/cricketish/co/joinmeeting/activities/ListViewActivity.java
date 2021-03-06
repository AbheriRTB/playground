package cricketish.co.joinmeeting.activities;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.ItemTouchHelper;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Canvas;
import android.net.Uri;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.StringTokenizer;

import cricketish.co.joinmeeting.R;
import cricketish.co.joinmeeting.utils.List;
import cricketish.co.joinmeeting.utils.ListAdaptor;
import it.xabaras.android.recyclerview.swipedecorator.RecyclerViewSwipeDecorator;

public class ListViewActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerView.Adapter myAdaptor;
    RecyclerView.LayoutManager layoutManager;
    ItemTouchHelper itemTouchHelper;
    ArrayList<List> lists;
    ConstraintLayout layout;
    TextView tvMeeting, tvFirst;
    AlertDialog.Builder dialog;
    Calendar calendar;
    ImageView ivRight, ivLeft;
    FloatingActionButton btnAdd2;
    Toolbar toolbar;

    //For the function when  Undo clicked
    List deletedMovie = null;


    //  This function is to bring the button on the Action Bar (From Here)
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        //inflater.inflate(R.menu.lists, menu);
        //return true;
        getMenuInflater().inflate(R.menu.lists, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            /*case R.id.btnAdd:
                Intent intent = new Intent(getApplicationContext(), AddActivity.class);
                startActivity(intent);
                break;
            case R.id.btnHelp:
                intent = new Intent(getApplicationContext(), AboutActivity.class);
                startActivity(intent);
                break;
            case R.id.btnSettings:
                intent = new Intent(getApplicationContext(), SettingsActivity.class);
                openSettingsDialog();
                //startActivity(intent);
                break;*/
            case R.id.menuAbout:
                Intent intent;
                intent = new Intent(getApplicationContext(), AboutActivity.class);
                //openSettingsDialog();
                startActivity(intent);
                break;
            case R.id.menuSettings:
                intent = new Intent(getApplicationContext(), SettingsActivity.class);
                openSettingsDialog();
                //startActivity(intent);
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

        /*String meet = getIntent().getStringExtra("meet");
        String name = getIntent().getStringExtra("name");
        String link = getIntent().getStringExtra("link");
        String month = getIntent().getStringExtra("month");
        String day = getIntent().getStringExtra("day");
        String year = getIntent().getStringExtra("year");
        String hour = getIntent().getStringExtra("hour");
        String minutes = getIntent().getStringExtra("minutes");*/

        SharedPreferences prefs = getSharedPreferences("prefs", MODE_PRIVATE);
        boolean firstTime = prefs.getBoolean("firstTime", true);
        RecyclerView rv = findViewById(R.id.list);

        if (firstTime)
            openBetaDialog();

        tvFirst = findViewById(R.id.tvFirst);
        tvFirst.setVisibility(View.INVISIBLE);
        tvMeeting = findViewById(R.id.tvMeeting);
        toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        ivRight = findViewById(R.id.ivTopRightAdd);
        ivLeft = findViewById(R.id.ivTopLeftAdd);
        tvMeeting = findViewById(R.id.tvMeeting);
        btnAdd2 = findViewById(R.id.btnAdd2);
        tvMeeting.setVisibility(View.VISIBLE);
        ivLeft.setVisibility(View.VISIBLE);
        ivRight.setVisibility(View.VISIBLE);

        recyclerView = findViewById(R.id.list);
        recyclerView.setHasFixedSize(true);

        layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        lists = new ArrayList<List>();
        lists = loadData();
        myAdaptor = new ListAdaptor(this, lists, rv);
        recyclerView.setAdapter(myAdaptor);
        itemTouchHelper = new ItemTouchHelper(simpleCallback);
        itemTouchHelper.attachToRecyclerView(recyclerView);

        final Intent intent = new Intent(ListViewActivity.this, AddActivity.class);
        btnAdd2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(intent);
            }
        });

        if (lists.size() == 0) {
            tvFirst.setVisibility(View.VISIBLE);
            tvMeeting.setVisibility(View.GONE);
            ivLeft.setVisibility(View.GONE);
            ivRight.setVisibility(View.GONE);
        }
    }


    //  This function wraps up the data for the list from the .txt file
    ArrayList<List> loadData() {

        File file = getApplicationContext().getFileStreamPath("join.meeting.data.txt");
        String lineFromFile;
        ArrayList<List> retArrayList = new ArrayList<List>();

        if (file.exists()) {
            try {
                BufferedReader reader = new BufferedReader(new InputStreamReader(openFileInput("join.meeting.data.txt")));
                while ((lineFromFile = reader.readLine()) != null) {
                    StringTokenizer tokens = new StringTokenizer(lineFromFile, ",");

                    String tokenName = "noname", tokenLink = "nolink", tokenMeet = "nomeet",
                            tokenDate = "1", tokenYear = "2020", tokenMinute = "05";
                    int tokenHour = 1, tokenMonth = 1;

                    if (tokens.hasMoreElements())
                        tokenName = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        tokenLink = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        tokenMeet = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        tokenDate = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        tokenMonth = Integer.parseInt(tokens.nextToken());
                    if (tokens.hasMoreElements())
                        tokenYear = tokens.nextToken();
                    if (tokens.hasMoreElements())
                        tokenHour = Integer.parseInt(tokens.nextToken());
                    if (tokens.hasMoreElements())
                        tokenMinute = tokens.nextToken();

                    List list2 = new List(tokenName, tokenLink, tokenMeet, tokenDate,
                            tokenMonth, tokenYear, tokenHour, tokenMinute);
                    retArrayList.add(list2);

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
                    dialog = new AlertDialog.Builder(ListViewActivity.this);
                    dialog
                            .setPositiveButton("Delete", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    lists.remove(position);

                                    myAdaptor.notifyItemRemoved(position);
                                    Snackbar.make(recyclerView, deletedMovie.toString(), Snackbar.LENGTH_LONG)
                                            .setAction("UNDO", new View.OnClickListener() {
                                                @Override
                                                public void onClick(View view) {
                                                    lists.add(position, deletedMovie);
                                                    myAdaptor.notifyItemInserted(position);
                                                }
                                            }).setText("Deleted a Meet").show();
                                }
                            })

                            .setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    myAdaptor.notifyItemChanged(position);
                                }
                            })
                            .setTitle("Alert")
                            .setMessage("Do you want to really delete this meet?")
                            .show();
                    break;

            }


        }

        @Override
        public void onChildDraw(@NonNull Canvas c, @NonNull RecyclerView recyclerView, @NonNull RecyclerView.ViewHolder viewHolder, float dX, float dY, int actionState, boolean isCurrentlyActive) {
            new RecyclerViewSwipeDecorator.Builder(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive)
                    .addSwipeLeftBackgroundColor(ContextCompat.getColor(ListViewActivity.this, R.color.Bin))
                    .addSwipeLeftActionIcon(R.drawable.bin)
                    .addSwipeLeftLabel("Delete")
                    .setSwipeLeftLabelColor(ContextCompat.getColor(ListViewActivity.this, R.color.White))
                    .create()
                    .decorate();
            super.onChildDraw(c, recyclerView, viewHolder, dX, dY, actionState, isCurrentlyActive);
        }
    };


    @Override
    protected void onStop() {
        super.onStop();
        saveAllData();

    }

    //  This is the method to save the data in the .txt file
    void saveAllData() {

        try {
            FileOutputStream file = openFileOutput("join.meeting.data.txt", MODE_PRIVATE);
            OutputStreamWriter outputFile = new OutputStreamWriter(file);
            for (int i = 0; i < lists.size(); ++i) {
                outputFile.write(lists.get(i).getName() + "," + lists.get(i).getLink() + "," + lists.get(i).getMeet() +
                        "," + lists.get(i).getDate() + "," + lists.get(i).getMonth() + "," + lists.get(i).getYear() + "," +
                        lists.get(i).getHour() + "," + lists.get(i).getMinutes() + "\n");
            }
            outputFile.close();

        } catch (IOException e) {
            Toast.makeText(ListViewActivity.this, e.getMessage(), Toast.LENGTH_SHORT).show();
        }

    }

    //  The beta dialog creator which appears on the start off the activity
    public void openBetaDialog() {
        final AlertDialog.Builder betaDialog = new AlertDialog.Builder(ListViewActivity.this);
        betaDialog.setTitle("Warning!")

                .setMessage("This app is still in Beta stages, if found any error please report it " +
                        "to our email (mentioned in our about page)")

                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                    }
                })

                .setNeutralButton("Never Show Again", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        SharedPreferences prefs = getSharedPreferences("prefs", MODE_PRIVATE);
                        SharedPreferences.Editor editor = prefs.edit();
                        editor.putBoolean("firstTime", false);
                        editor.apply();
                    }
                })

                .create().show();

    }

    // Settings dialog
    private void openSettingsDialog() {
        final String formsLink = "https://forms.gle/8QbJZHrGxQMNHFnX9";

        final AlertDialog.Builder settingsDialog = new AlertDialog.Builder(ListViewActivity.this);
        settingsDialog.setTitle("Work in progress")
                .setMessage("The Settings page is still in the making," +
                        " you can have a review or just ignore")
                .setNeutralButton("Review", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        Intent forms = new Intent(android.content.Intent.ACTION_VIEW,
                                Uri.parse(formsLink));
                        ListViewActivity.this.startActivity(forms);
                    }
                })
                .setPositiveButton("ok", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                    }
                })
                .create().show();


    }


}