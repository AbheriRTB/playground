package cricketish.co.coockify;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;

public class MainActivity extends AppCompatActivity {

    EditText etName1, etName2, etName3, etName4, etName5, etName6;
    EditText etWeight1, etWeight2, etWeight3, etWeight4, etWeight5, etWeight6;

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


    }
}