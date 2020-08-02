package cricketish.co.joinmeeting;

import android.app.Dialog;
import android.content.Context;
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

public class ListAdaptor extends RecyclerView.Adapter<ListAdaptor.ViewHolder> {

    private ArrayList<List> events;
    String strMeet;
    Dialog infoDialog;
    Button btnJoin, btnCancel;
    ImageView ivMeet2;
    boolean join;
    TextView tvLink2, tvDate2, tvMeet2, tvTitle2;


    public ListAdaptor(Context context, ArrayList<List> list) {
        events = list;
        infoDialog = new Dialog(context);
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
                public void onClick(View v) {
                    ShowPopupInfo(tvLink, tvDate, tvMeet, tvName, ivMeet);
                    if (join) {
                        String link = String.valueOf(tvLink.getText());
                        Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                                Uri.parse(link));
                        itemView.getContext().startActivity(intent);
                        Toast.makeText(v.getContext(), "Worked", Toast.LENGTH_SHORT).show();
                    }

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
        String link = events.get(i).getLink();
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvLink.setText(events.get(i).getLink());
        holder.tvDate.setText(events.get(i).getDate());
        holder.tvMonth.setText(events.get(i).getMonth());


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

        /*if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            ivMeet2.setImageResource(R.mipmap.zoom);
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            ivMeet2.setImageResource(R.mipmap.webex);
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            ivMeet2.setImageResource(R.mipmap.google);
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            ivMeet2.setImageResource(R.mipmap.jio);
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            ivMeet2.setImageResource(R.mipmap.other);
        }*/
    }


    //  Get the size of the adaptor?
    @Override
    public int getItemCount() {
        return events.size();
    }


    public void ShowPopupInfo(TextView tvLink, TextView tvDate,
                              TextView tvMeet, TextView tvTitle, ImageView ivMeet) {
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
        tvDate.setText(tvDate.getText());
        tvLink.setText(tvLink.getText());
        tvTitle2.setText(tvTitle.getText());
        tvTitle2.setText(tvTitle.getText());
        btnJoin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                join = true;
            }
        });
        btnCancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ListAdaptor.this.infoDialog.dismiss();
            }
        });
        this.infoDialog.getWindow().setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        this.infoDialog.show();


    }

}

