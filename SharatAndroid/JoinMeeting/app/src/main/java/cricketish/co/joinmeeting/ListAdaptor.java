package cricketish.co.joinmeeting;

import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.Objects;

public class ListAdaptor extends RecyclerView.Adapter<ListAdaptor.ViewHolder> {

    private ArrayList<List> events;
    String strMeet, strMonth, timeOfDay;
    Dialog infoDialog;
    Button btnJoin, btnCancel;
    ImageView ivMeet2;
    boolean join = false;
    TextView tvLink2, tvDate2, tvMeet2, tvTitle2;
    AlertDialog.Builder joinDialog;


    public ListAdaptor(Context context, ArrayList<List> list) {
        events = list;
        infoDialog = new Dialog(context);
        joinDialog = new AlertDialog.Builder(context);
    }


    // Class for the View Holder
    public class ViewHolder extends RecyclerView.ViewHolder {
        ImageView ivMeet;
        TextView tvName, tvLink, tvDate, tvMonth, tvMeet;

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
                    //ShowPopupInfo(itemView, v, tvLink, tvDate, tvMeet, tvName, ivMeet);
                    //join = true;
                    joinDialog.setNegativeButton("No", new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {

                        }
                    })
                            .setPositiveButton("Join", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    String link = String.valueOf(tvLink2.getText());
                                    Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                                            Uri.parse(link));
                                    itemView.getContext().startActivity(intent);
                                    Toast.makeText(v.getContext(), "Worked", Toast.LENGTH_SHORT).show();
                                }
                            })
                            .create().show();
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

    //  Here we declare the values (eg ivMeet, tvName, etc) where we get the position on clicked
    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int i) {
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvLink.setText(events.get(i).getLink());
        int hour = Integer.parseInt(events.get(i).getHour());
        int month = Integer.parseInt(events.get(i).getMonth());
        int intHour = 0;
        String minute = events.get(i).getMinutes();
        String day = events.get(i).getDate();
        String year = events.get(i).getYear();

        switch (month) {
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
        switch (hour) {
            case 13:
                intHour = 1;
                timeOfDay = "PM";
                break;
            case 14:
                intHour = 2;
                timeOfDay = "PM";
                break;
            case 15:
                intHour = 3;
                timeOfDay = "PM";
                break;
            case 16:
                intHour = 4;
                timeOfDay = "PM";
                break;
            case 17:
                intHour = 5;
                timeOfDay = "PM";
                break;
            case 18:
                intHour = 6;
                timeOfDay = "PM";
                break;
            case 19:
                intHour = 7;
                timeOfDay = "PM";
                break;
            case 20:
                intHour = 8;
                timeOfDay = "PM";
                break;
            case 21:
                intHour = 9;
                timeOfDay = "PM";
                break;
            case 22:
                intHour = 10;
                timeOfDay = "PM";
                break;
            case 23:
                intHour = 11;
                timeOfDay = "PM";
                break;
            case 24:
                intHour = 12;
                timeOfDay = "PM";
                break;
            case 0:
                intHour = 0;
                timeOfDay = "AM";
                break;
            case 1:
                intHour = 1;
                timeOfDay = "AM";
                break;
            case 2:
                intHour = 2;
                timeOfDay = "AM";
                break;
            case 3:
                intHour = 3;
                timeOfDay = "AM";
                break;
            case 4:
                intHour = 4;
                timeOfDay = "AM";
                break;
            case 5:
                intHour = 5;
                timeOfDay = "AM";
                break;
            case 6:
                intHour = 6;
                timeOfDay = "AM";
                break;
            case 7:
                intHour = 7;
                timeOfDay = "AM";
                break;
            case 8:
                intHour = 8;
                timeOfDay = "AM";
                break;
            case 9:
                intHour = 9;
                timeOfDay = "AM";
                break;
            case 10:
                intHour = 10;
                timeOfDay = "AM";
                break;
            case 11:
                intHour = 11;
                timeOfDay = "AM";
                break;
            case 12:
                intHour = 12;
                timeOfDay = "AM";
                break;
            default:
                timeOfDay = "AM";
        }

        String time = day + "th " + strMonth + " at " + intHour + ":" + minute + timeOfDay;


        if (events.get(i).getDate() == null) {
            holder.tvDate.setVisibility(View.INVISIBLE);
        } else {
            holder.tvDate.setText(events.get(i).getDate());
        }
        if (events.get(i).getMonth() == null) {
            holder.tvMonth.setVisibility(View.INVISIBLE);
        } else {
            holder.tvMonth.setText(events.get(i).getMonth());
        }

        joinDialog.setTitle("Join a Meeting");


        if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            holder.ivMeet.setImageResource(R.mipmap.zoom);
            strMeet = "Zoom";
            joinDialog.setIcon(R.mipmap.zoom)
                    .setMessage("Do you want to join a Zoom Meeting scheduled on " + time + " now?");
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            holder.ivMeet.setImageResource(R.mipmap.webex);
            strMeet = "WebEx";
            joinDialog.setIcon(R.mipmap.webex)
                    .setMessage("Do you want to join a WebEx Meeting scheduled on " + time + " now?");
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            holder.ivMeet.setImageResource(R.mipmap.google);
            strMeet = "Google Meet";
            joinDialog.setIcon(R.mipmap.google)
                    .setMessage("Do you want to join a Google Meet scheduled on " + time + " now?");
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            holder.ivMeet.setImageResource(R.mipmap.jio);
            strMeet = "Jio Meet";
            joinDialog.setIcon(R.mipmap.jio)
                    .setMessage("Do you want to join a Jio Meet scheduled on " + time + " now?");
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            holder.ivMeet.setImageResource(R.mipmap.other);
            strMeet = "Custom";
            joinDialog.setIcon(R.mipmap.other)
                    .setMessage("Do you want to join a Custom Meeting scheduled on " + time + " now?");
        }

    }


    //  Get the size of the adaptor?
    @Override
    public int getItemCount() {
        return events.size();
    }


    /*public void ShowPopupInfo(final View ItemView, final View v, TextView tvLink, TextView tvDate,
                              TextView tvMeet, TextView tvTitle, ImageView ivMeet) {
        
        LayoutInflater inflatr = (LayoutInflater) this.getSystemService(v.getContext().LAYOUT_INFLATER_SERVICE);

        infoDialog.setContentView(R.layout.popup_diaglog);
        btnJoin = infoDialog.findViewById(R.id.btnJoin);
        btnCancel = infoDialog.findViewById(R.id.btnCancel);
        tvTitle2 = infoDialog.findViewById(R.id.tvTitle2);
        tvLink2 = infoDialog.findViewById(R.id.tvLink2);
        tvDate2 = infoDialog.findViewById(R.id.tvDate2);
        ivMeet2 = infoDialog.findViewById(R.id.ivMeet2);
        tvMeet2 = infoDialog.findViewById(R.id.tvMeet2);

        tvMeet2.setText(strMeet);
        tvTitle2.setText(tvTitle.getText());
        tvDate2.setText(tvDate.getText());
        tvLink2.setText(tvLink.getText());

        if (strMeet.equalsIgnoreCase("Zoom")) {
            ivMeet2.setImageResource(R.mipmap.zoom);
        } else if (strMeet.equalsIgnoreCase("WebEx")) {
            ivMeet2.setImageResource(R.mipmap.webex);
        } else if (strMeet.equalsIgnoreCase("Google Meet")) {
            ivMeet2.setImageResource(R.mipmap.google);
        } else if (tvMeet.getText().equals("Jio Meet")) {
            ivMeet2.setImageResource(R.mipmap.jio);
        } else {
            ivMeet2.setImageResource(R.mipmap.other);
        }

        btnJoin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (join) {
                    String link = String.valueOf(tvLink2.getText());
                    Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                            Uri.parse(link));
                    ItemView.getContext().startActivity(intent);
                    Toast.makeText(v.getContext(), "Worked", Toast.LENGTH_SHORT).show();
                }
            }
        });
        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ListAdaptor.this.infoDialog.dismiss();
            }
        });
        Objects.requireNonNull(this.infoDialog.getWindow()).setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        this.infoDialog.show();


    }*/

}

