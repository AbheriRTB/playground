package abheri.co.vyakarana;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {

    ImageButton btnApply;
    TextView tvResult;
    EditText etInput;
    String input, result = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        btnApply = findViewById(R.id.btnApply);
        tvResult = findViewById(R.id.tvResult);
        etInput = findViewById(R.id.etInput);

        btnApply.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                formula();
                tvResult.setText(result);
            }
        });

    }

    private void formula() {
        input = etInput.getText().toString().trim();
        for (int i = 0; i < input.length()-1; ++i) {
            if (input.charAt(i) == input.charAt(i + 1)) {
                result = input.charAt(i) + "" + input.charAt(i) + "";
            }
        }
    }


}