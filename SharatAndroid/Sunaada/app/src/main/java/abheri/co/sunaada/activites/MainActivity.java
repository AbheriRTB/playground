package abheri.co.sunaada.activites;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.drawerlayout.widget.DrawerLayout;

import android.app.ActionBar;
import android.content.Intent;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import com.google.android.material.navigation.NavigationView;

import abheri.co.sunaada.R;

public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    Toolbar toolbarMain;
    DrawerLayout drawerLayout;
    NavigationView navigationView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        toolbarMain.findViewById(R.id.toolbarMain);
        setSupportActionBar(toolbarMain);

        drawerLayout.findViewById(R.id.drawer_layout);
        navigationView.findViewById(R.id.navigation);

        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this, drawerLayout, toolbarMain,
                R.string.open_drawer,
                R.string.close_drawer);

        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();
        navigationView.setNavigationItemSelectedListener(this);

    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        Intent intent;
        switch (item.getItemId()){
            case R.id.upcoming_con:
                intent = new Intent(this, UpcomingActivity.class);
                startActivity(intent);
                break;
            case R.id.artists_con:
                break;
            case R.id.venue_con:
                break;
            case R.id.org_con:
                break;
            case R.id.event_con:
                break;
            case R.id.artists_dict:
                break;
            case R.id.venue_dict:
                break;
            case R.id.org_dict:
                break;
        }

        return true;
    }
}