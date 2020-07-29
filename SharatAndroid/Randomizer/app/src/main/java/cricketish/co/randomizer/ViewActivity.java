package cricketish.co.randomizer;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class ViewActivity extends AppCompatActivity {

    Button btnSubmit;
    EditText etName1, etName2, etName3, etName4;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view_activity);
        btnSubmit = findViewById(R.id.btnSubmit);
        etName1 = findViewById(R.id.etName1);
        etName2 = findViewById(R.id.etName2);
        etName3 = findViewById(R.id.etName3);
        etName4 = findViewById(R.id.etName4);

        btnSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String topic1 = etName1.getText().toString();
                String topic2 = etName2.getText().toString();
                String topic3 = etName3.getText().toString();
                String topic4 = etName4.getText().toString();
                Intent intent = new Intent();
                intent.putExtra("topic1", topic1);
                intent.putExtra("topic2", topic2);
                intent.putExtra("topic3", topic3);
                intent.putExtra("topic4", topic4);
                setResult(RESULT_OK, intent);
                ViewActivity.this.finish();

            }
        });
    }
}