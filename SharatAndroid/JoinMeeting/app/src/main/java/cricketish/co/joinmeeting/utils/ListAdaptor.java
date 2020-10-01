package cricketish.co.joinmeeting.utils;

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

import cricketish.co.joinmeeting.R;

public class ListAdaptor extends RecyclerView.Adapter<ListAdaptor.ViewHolder> {

    private ArrayList<List> events;
    int hour, hourForTime, month;
    String minute, year, date, link, timeOfDay, strMonth, strMeet, time,
            timeSuffix, minuteForTime;
    AlertDialog.Builder joinDialog;
    RecyclerView recyclerView;


    public ListAdaptor(Context context, ArrayList<List> list, RecyclerView rv) {
        events = list;
        joinDialog = new AlertDialog.Builder(context);
        recyclerView = rv;

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
                public void onClick(final View v) {

                    final int i = recyclerView.getChildLayoutPosition(v);
                    final String openLink = events.get(i).getLink();
                    getHour(i);
                    getMonths(i);
                    //getMinute(i);
                    joinDialog.setTitle("Join Meeting " + events.get(i).getName());

                    if (events.get(i).getDate().equals("1") || events.get(i).getDate().equals("21"))
                        timeSuffix = "st ";
                    else if (events.get(i).getDate().equals("2") || events.get(i).getDate().equals("22"))
                        timeSuffix = "nd ";
                    else if (events.get(i).getDate().equals("3") || events.get(i).getDate().equals("23"))
                        timeSuffix = "rd ";
                    else
                        timeSuffix = "th ";

                    time = events.get(i).getDate() + timeSuffix + strMonth + /*" at " + events.get(i).getHour() + ":"
                            + events.get(i).getMinutes() + */" now?";

                    if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
                        joinDialog.setIcon(R.mipmap.zoom)
                                .setMessage("Do you want to join a Zoom Meeting scheduled " +
                                        "on " + time);
                    } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
                        joinDialog.setIcon(R.mipmap.webex)
                                .setMessage("Do you want to join a WebEx Meeting scheduled " +
                                        "on " + time);
                    } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
                        joinDialog.setIcon(R.mipmap.google)
                                .setMessage("Do you want to join a Google Meet scheduled " +
                                        "on " + time);
                    } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
                        joinDialog.setIcon(R.mipmap.jio)
                                .setMessage("Do you want to join a Jio Meet scheduled " +
                                        "on " + time);
                    } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
                        joinDialog.setIcon(R.mipmap.other)
                                .setMessage("Do you want to join a Meeting scheduled " +
                                        "on " + time);
                    }

                    joinDialog.setPositiveButton("Join", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                                    Uri.parse(openLink));
                            itemView.getContext().startActivity(intent);
                            Toast.makeText(v.getContext(), "Joining", Toast.LENGTH_SHORT).show();
                        }
                    });


                    joinDialog.setNegativeButton("No", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                        }
                    }).create().show();

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
        String montNames[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun",
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
        link = events.get(i).getLink();
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvLink.setText(events.get(i).getLink());
        holder.tvDate.setText(events.get(i).getDate());
        month = events.get(i).getMonth();
        holder.tvMonth.setText(montNames[month]);
        date = events.get(i).getDate();
        hour = events.get(i).getHour();
        minute = events.get(i).getMinutes();
        year = events.get(i).getYear();

        if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            holder.ivMeet.setImageResource(R.mipmap.zoom);
            strMeet = "Zoom";
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            holder.ivMeet.setImageResource(R.mipmap.webex);
            strMeet = "WebEx";
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            holder.ivMeet.setImageResource(R.mipmap.google);
            strMeet = "Google Meet";
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            holder.ivMeet.setImageResource(R.mipmap.jio);
            strMeet = "Jio Meet";
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            holder.ivMeet.setImageResource(R.mipmap.other);
            strMeet = "Custom";
        }
    }


    //  Get the size of the adaptor?
    @Override
    public int getItemCount() {
        return events.size();
    }

    public void getMonths(int i) {
        switch (events.get(i).getMonth()) {
            case 0:
                strMonth = "Jan";
                break;
            case 1:
                strMonth = "Feb";
                break;
            case 2:
                strMonth = "Mar";
                break;
            case 3:
                strMonth = "Apr";
                break;
            case 4:
                strMonth = "May";
                break;
            case 5:
                strMonth = "Jun";
                break;
            case 6:
                strMonth = "Jul";
                break;
            case 7:
                strMonth = "Aug";
                break;
            case 8:
                strMonth = "Sep";
                break;
            case 9:
                strMonth = "Oct";
                break;
            case 10:
                strMonth = "Nov";
                break;
            case 11:
                strMonth = "Dec";
                break;
        }
    }

    private void getHour(int i) {
        switch (events.get(i).getHour()) {
            case 13:
                hourForTime = 1;
                timeOfDay = "PM";
                break;
            case 14:
                hourForTime = 2;
                timeOfDay = "PM";
                break;
            case 15:
                hourForTime = 3;
                timeOfDay = "PM";
                break;
            case 16:
                hourForTime = 4;
                timeOfDay = "PM";
                break;
            case 17:
                hourForTime = 5;
                timeOfDay = "PM";
                break;
            case 18:
                hourForTime = 6;
                timeOfDay = "PM";
                break;
            case 19:
                hourForTime = 7;
                timeOfDay = "PM";
                break;
            case 20:
                hourForTime = 8;
                timeOfDay = "PM";
                break;
            case 21:
                hourForTime = 9;
                timeOfDay = "PM";
                break;
            case 22:
                hourForTime = 10;
                timeOfDay = "PM";
                break;
            case 23:
                hourForTime = 11;
                timeOfDay = "PM";
                break;
            case 24:
                hourForTime = 12;
                timeOfDay = "PM";
                break;
            default:
                timeOfDay = "AM";
        }
    }

    /*private void getMinute(int i) {
        switch (events.get(i).getMinutes()) {
            case "1":
                minuteForTime = "01";
                break;
            case "2":
                minuteForTime = "02";
                break;
            case "3":
                minuteForTime = "03";
                break;
            case "4":
                minuteForTime = "04";
                break;
            case "5":
                minuteForTime = "05";
                break;
            case "6":
                minuteForTime = "06";
                break;
            case "7":
                minuteForTime = "07";
                break;
            case "8":
                minuteForTime = "08";
                break;
            case "9":
                minuteForTime = "09";
                break;
        }
    }*/

}


