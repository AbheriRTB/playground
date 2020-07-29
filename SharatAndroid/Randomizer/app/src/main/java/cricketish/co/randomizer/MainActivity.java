package cricketish.co.randomizer;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.Random;

public class MainActivity extends AppCompatActivity {

    Button btnRandom, btnView;
    String[] topics = new String[4];
    Random num = new Random();
    int iNum;

    //Get the data from the Activity 2 (View Activity)
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            topics[0] = data.getStringExtra("topic1");
            topics[1] = data.getStringExtra("topic2");
            topics[2] = data.getStringExtra("topic3");
            topics[3] = data.getStringExtra("topic4");
        }
        //If pressed back button
        else if (requestCode == RESULT_CANCELED) {

        }
    }

    TextView tvTopic, tvName;
    final int TOPIC = 3076;
    int dispIndex = 0;
    final String[] NAMES = {"Person 1", "Person 2", "Person 3", "Person 4"};

    Random random = new Random();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        btnRandom = findViewById(R.id.btnRandom);
        btnView = findViewById(R.id.btnView);
        tvTopic = findViewById(R.id.tvTopic);
        tvName = findViewById(R.id.tvName);

        dispIndex = random.nextInt(6)+1;
        //On the click of the view button
        btnView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, cricketish.co.randomizer.ViewActivity.class);
                startActivityForResult(intent, TOPIC);


            }
        });
        iNum = num.nextInt(3);
        //On the click of the random button every time shows a different value in the array
        btnRandom.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                tvName.setText(NAMES[iNum]);
                tvTopic.setText(topics[dispIndex]);
                //Stops the display index at 3 and restarts it
                iNum = iNum == 3 ? 0 : iNum + 1;

            }

        });

    }
}
