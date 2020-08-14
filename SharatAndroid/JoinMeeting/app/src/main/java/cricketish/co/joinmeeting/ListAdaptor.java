package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
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
    int hour, codeIv, month;
    String minute, year, date, link, timeOfDay, strMonth, strMeet, time;
    AlertDialog.Builder dialog, joinDialog;
    RecyclerView recyclerView;

    public ListAdaptor(Context context, ArrayList<List> list, RecyclerView rv) {
        events = list;
        //infoDialog = new Dialog(context);
        dialog = new AlertDialog.Builder(context);
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
                    //openDialog(itemView, v);
                    //joinDialog.setNegativeButton("no", new DialogInterface.OnClickListener() {
                    //@Override
                    //public void onClick(DialogInterface dialogInterface, int i) {

                    //}
                    //})
                    //.setPositiveButton("Join", new DialogInterface.OnClickListener() {
                    //@Override
                    //public void onClick(DialogInterface dialogInterface, int i) {
                    final int i = recyclerView.getChildLayoutPosition(v);
                    switch (events.get(i).getHour()) {
                        case 13:
                            hour = 1;
                            timeOfDay = "PM";
                            break;
                        case 14:
                            hour = 2;
                            timeOfDay = "PM";
                            break;
                        case 15:
                            hour = 3;
                            timeOfDay = "PM";
                            break;
                        case 16:
                            hour = 4;
                            timeOfDay = "PM";
                            break;
                        case 17:
                            hour = 5;
                            timeOfDay = "PM";
                            break;
                        case 18:
                            hour = 6;
                            timeOfDay = "PM";
                            break;
                        case 19:
                            hour = 7;
                            timeOfDay = "PM";
                            break;
                        case 20:
                            hour = 8;
                            timeOfDay = "PM";
                            break;
                        case 21:
                            hour = 9;
                            timeOfDay = "PM";
                            break;
                        case 22:
                            hour = 10;
                            timeOfDay = "PM";
                            break;
                        case 23:
                            hour = 11;
                            timeOfDay = "PM";
                            break;
                        case 24:
                            hour = 12;
                            timeOfDay = "PM";
                            break;
                        case 0:
                            hour = 12;
                            timeOfDay = "AM";
                            break;
                        case 1:
                            hour = 1;
                            timeOfDay = "AM";
                            break;
                        case 2:
                            hour = 2;
                            timeOfDay = "AM";
                            break;
                        case 3:
                            hour = 3;
                            timeOfDay = "AM";
                            break;
                        case 4:
                            hour = 4;
                            timeOfDay = "AM";
                            break;
                        case 5:
                            hour = 5;
                            timeOfDay = "AM";
                            break;
                        case 6:
                            hour = 6;
                            timeOfDay = "AM";
                            break;
                        case 7:
                            hour = 7;
                            timeOfDay = "AM";
                            break;
                        case 8:
                            hour = 8;
                            timeOfDay = "AM";
                            break;
                        case 9:
                            hour = 9;
                            timeOfDay = "AM";
                            break;
                        case 10:
                            hour = 10;
                            timeOfDay = "AM";
                            break;
                        case 11:
                            hour = 11;
                            timeOfDay = "AM";
                            break;
                        case 12:
                            hour = 12;
                            timeOfDay = "AM";
                            break;
                        default:
                            timeOfDay = "AM";
                    }
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

                            time = events.get(i).getDate() + "th " + strMonth + " at " + events.get(i).getHour() + ":"
                                    + minute + timeOfDay + " now?";
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
                                            Uri.parse(events.get(i).getLink()));
                                    itemView.getContext().startActivity(intent);
                                    Toast.makeText(v.getContext(), "Joining", Toast.LENGTH_SHORT).show();
                                }
                            });
                            joinDialog.setNegativeButton("No", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {

                                }
                            }).create().show();

                    //})
                    //.create().show();
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


        joinDialog.setTitle("Join Meeting");

        if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            holder.ivMeet.setImageResource(R.mipmap.zoom);
            strMeet = "Zoom";
            codeIv = 1;
            //joinDialog.setIcon(R.mipmap.zoom)
            //      .setMessage("Do you want to join a Zoom Meeting scheduled " +
            //               "on " + time);
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            holder.ivMeet.setImageResource(R.mipmap.webex);
            strMeet = "WebEx";
            codeIv = 2;
            /*joinDialog.setIcon(R.mipmap.webex)
                    .setMessage("Do you want to join a WebEx Meeting scheduled " +
                            "on " + time);*/
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            holder.ivMeet.setImageResource(R.mipmap.google);
            strMeet = "Google Meet";
            codeIv = 3;
            /*joinDialog.setIcon(R.mipmap.google)
                    .setMessage("Do you want to join a Google Meet scheduled " +
                            "on " + time);*/
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            holder.ivMeet.setImageResource(R.mipmap.jio);
            strMeet = "Jio Meet";
            codeIv = 4;
            //joinDialog.setIcon(R.mipmap.jio)
            //      .setMessage("Do you want to join a Jio Meet scheduled " +
            //            "on " + time);
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            holder.ivMeet.setImageResource(R.mipmap.other);
            strMeet = "Custom";
            codeIv = 5;
            //joinDialog.setIcon(R.mipmap.other)
            //      .setMessage("Do you want to join a Custom Meeting scheduled " +
            //            "on " + time);
        }
    }


    //  Get the size of the adaptor?
    @Override
    public int getItemCount() {
        return events.size();
    }

    //For dialog to popup on an meeting clicked
    /*public void openDialog(final View itemView, final View v) {


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
    }*/
}

