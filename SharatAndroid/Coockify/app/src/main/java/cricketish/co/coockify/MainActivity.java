package cricketish.co.coockify;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    EditText etName1, etName2, etName3, etName4, etName5, etName6;
    EditText etWeight1, etWeight2, etWeight3, etWeight4, etWeight5, etWeight6;
    Button btnSubmit;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        etName1 = findViewById(R.id.etName1);
        etName2 = findViewById(R.id.etName2);
        etName3 = findViewById(R.id.etName3);
        etName4 = findViewById(R.id.etName4);
        etName5 = findViewById(R.id.etName5);
        etName6 = findViewById(R.id.etName6);
        etWeight1 = findViewById(R.id.etWeight1);
        etWeight2 = findViewById(R.id.etWeight2);
        etWeight3 = findViewById(R.id.etWeight3);
        etWeight4 = findViewById(R.id.etWeight4);
        etWeight5 = findViewById(R.id.etWeight5);
        etWeight6 = findViewById(R.id.etWeight6);
        btnSubmit = findViewById(R.id.btnSend);

        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent toResultPage = new Intent(MainActivity.this, ResultActivity.class);
                toResultPage.putExtra("name1", etName1.getText().toString().trim());
                toResultPage.putExtra("name2", etName2.getText().toString().trim());
                toResultPage.putExtra("name3", etName3.getText().toString().trim());
                toResultPage.putExtra("name4", etName4.getText().toString().trim());
                toResultPage.putExtra("name5", etName5.getText().toString().trim());
                toResultPage.putExtra("name6", etName6.getText().toString().trim());
                toResultPage.putExtra("weight1", etWeight1.getText().toString().trim());
                toResultPage.putExtra("weight2", etWeight2.getText().toString().trim());
                toResultPage.putExtra("weight3", etWeight3.getText().toString().trim());
                toResultPage.putExtra("weight4", etWeight4.getText().toString().trim());
                toResultPage.putExtra("weight5", etWeight5.getText().toString().trim());
                toResultPage.putExtra("weight6", etWeight6.getText().toString().trim());
                startActivity(toResultPage);
            }
        });
    }
}