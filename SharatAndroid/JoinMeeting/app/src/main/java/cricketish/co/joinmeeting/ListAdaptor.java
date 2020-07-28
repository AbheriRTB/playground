package cricketish.co.joinmeeting;

import android.content.Context;
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

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.StringTokenizer;

public class ListAdaptor extends RecyclerView.Adapter<ListAdaptor.ViewHolder> {

    private ArrayList<List> events;

    public ListAdaptor(Context context, ArrayList<List> list) {
        events = list;
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        ImageView ivMeet;
        TextView tvName, tvLink;

        public ViewHolder(@NonNull final View itemView) {
            super(itemView);

            tvName = itemView.findViewById(R.id.tvName);
            tvLink = itemView.findViewById(R.id.tvLink);
            ivMeet = itemView.findViewById(R.id.ivMeet);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    String link = String.valueOf(tvLink.getText());
                    Intent intent = new Intent(android.content.Intent.ACTION_VIEW,
                            Uri.parse(link));
                    itemView.getContext().startActivity(intent);
                    Toast.makeText(v.getContext(), "Worked", Toast.LENGTH_SHORT).show();

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

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int i) {
        String link = events.get(i).getLink();
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvLink.setText(events.get(i).getLink());

        if (events.get(i).getMeet().equalsIgnoreCase("zoom")) {
            holder.ivMeet.setImageResource(R.mipmap.zoom);
        } else if (events.get(i).getMeet().equalsIgnoreCase("webex")) {
            holder.ivMeet.setImageResource(R.mipmap.webex);
        } else if (events.get(i).getMeet().equalsIgnoreCase("google")) {
            holder.ivMeet.setImageResource(R.mipmap.google);
        } else if (events.get(i).getMeet().equalsIgnoreCase("jiomeet")) {
            holder.ivMeet.setImageResource(R.mipmap.jio);
        } else if (events.get(i).getMeet().equalsIgnoreCase("other")) {
            holder.ivMeet.setImageResource(R.mipmap.other);
        }
    }

    @Override
    public int getItemCount() {
        return events.size();
    }

    private void setTextToTextView() {
        String text = "";

        for (int i = 0; i < events.size(); ++i) {
            text = text + events.get(i).getName() + " " + events.get(i).getLink() + events.get(i).getMeet() + "\n";
        }
    }

}

