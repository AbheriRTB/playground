package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class ListAdaptor extends RecyclerView.Adapter<ListAdaptor.ViewHolder> {

    private ArrayList<List> events;
    String strMeet;
    int hour;
    String minute;
    String year;
    String date;
    String month;
    String amORpm;
    String link;
    String timeOfDay;
    AlertDialog.Builder dialog;
    int codeIv;


    public ListAdaptor(Context context, ArrayList<List> list) {
        events = list;
        //infoDialog = new Dialog(context);
        dialog = new AlertDialog.Builder(context);
        MainActivity amORpm1 = new MainActivity();
        amORpm1.getAmORpm(amORpm);

    }


    // Class for the View Holder
    public class ViewHolder extends RecyclerView.ViewHolder {
        ImageView ivMeet;
        TextView tvName, tvLink, tvDate, tvMonth;

        public ViewHolder(@NonNull final View itemView) {
            super(itemView);


            tvName = itemView.findViewById(R.id.tvName);
            tvLink = itemView.findViewById(R.id.tvLink);
            tvDate = itemView.findViewById(R.id.tvDate);
            tvMonth = itemView.findViewById(R.id.tvMonth);
            ivMeet = itemView.findViewById(R.id.ivMeet);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    openDialog(itemView, v);

                }
            });

        }
    }


    @NonNull
    @Override
    public ListAdaptor.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.meetings, parent, false);
        return new ViewHolder(v);
    }


    //  Here we declare the values (eg ivMeet, tvName, etc)
    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int i) {
        link = events.get(i).getLink();
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvLink.setText(events.get(i).getLink());
        holder.tvDate.setText(events.get(i).getDate());
        holder.tvMonth.setText(events.get(i).getMonth());
        month = events.get(i).getMonth();
        date = events.get(i).getDate();
        hour = events.get(i).getHour();
        minute = events.get(i).getMinutes();
        year = events.get(i).getYear();


        if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            holder.ivMeet.setImageResource(R.mipmap.zoom);
            strMeet = "Zoom";
            codeIv = 1;
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            holder.ivMeet.setImageResource(R.mipmap.webex);
            strMeet = "WebEx";
            codeIv = 2;
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            holder.ivMeet.setImageResource(R.mipmap.google);
            strMeet = "Google Meet";
            codeIv = 3;
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            holder.ivMeet.setImageResource(R.mipmap.jio);
            strMeet = "Jio Meet";
            codeIv = 4;
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            holder.ivMeet.setImageResource(R.mipmap.other);
            strMeet = "Custom";
            codeIv = 5;
        }
    }


    //  Get the size of the adaptor?
    @Override
    public int getItemCount() {
        return events.size();
    }

    //For dialog to popup on an meeting clicked
    public void openDialog(final View itemView, final View v) {

        switch (hour) {
            case 13:
                hour = 1;
                timeOfDay = "PM";
            case 14:
                hour = 2;
                timeOfDay = "PM";
            case 15:
                hour = 3;
                timeOfDay = "PM";
            case 16:
                hour = 4;
                timeOfDay = "PM";
            case 17:
                hour = 5;
                timeOfDay = "PM";
            case 18:
                hour = 6;
                timeOfDay = "PM";
            case 19:
                hour = 7;
                timeOfDay = "PM";
            case 20:
                hour = 8;
                timeOfDay = "PM";
            case 21:
                hour = 9;
                timeOfDay = "PM";
            case 22:
                hour = 10;
                timeOfDay = "PM";
            case 23:
                hour = 11;
                timeOfDay = "PM";
            case 24:

                hour = 11;
                timeOfDay = "PM";
            default:
                timeOfDay = "AM";
        }
        if (minute.length() == 1) {
            minute = "0" + minute;
        }
        final String time = date + "th " + month + " at " +
                hour + ":" + minute + timeOfDay;
        dialog.setTitle("Join a Meeting?")
                .setMessage("Do you want to join a meeting scheduled to " + time +
                        " now?")
                .setPositiveButton("Join", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                                Uri.parse(link));
                        itemView.getContext().startActivity(intent);
                        Toast.makeText(v.getContext(), "Worked", Toast.LENGTH_SHORT).show();
                    }
                })
                .setNegativeButton("No", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {

                    }
                });

        if (codeIv == 1) {
            dialog.setIcon(R.mipmap.zoom);
        } else if (codeIv == 2) {
            dialog.setIcon(R.mipmap.webex);
        } else if (codeIv == 3) {
            dialog.setIcon(R.mipmap.google);
        } else if (codeIv == 4) {
            dialog.setIcon(R.mipmap.jio);
        } else if (codeIv == 5) {
            dialog.setIcon(R.mipmap.other);
        }
        dialog.show();
    }
}

