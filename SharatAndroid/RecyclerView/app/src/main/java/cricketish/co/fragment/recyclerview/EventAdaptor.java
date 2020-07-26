package cricketish.co.fragment.recyclerview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class EventAdaptor extends RecyclerView.Adapter<EventAdaptor.ViewHolder> {

    private ArrayList<Event> events;

    public EventAdaptor(Context context, ArrayList<Event> list) {
        events = list;
    }

    public class ViewHolder extends RecyclerView.ViewHolder {
        ImageView ivPref;
        TextView tvName, tvHobby;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            tvName = itemView.findViewById(R.id.tvName);
            tvHobby = itemView.findViewById(R.id.tvHobby);
            ivPref = itemView.findViewById(R.id.ivPref);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                }
            });

        }
    }

    @NonNull
    @Override
    public EventAdaptor.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {

        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.list_layout, parent, false);
        return new ViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull EventAdaptor.ViewHolder holder, int i) {
        holder.itemView.setTag(events.get(i));
        holder.tvName.setText(events.get(i).getName());
        holder.tvHobby.setText(events.get(i).getHobby());
        if (events.get(i).getPref().equalsIgnoreCase("Run")) {
            holder.ivPref.setImageResource(R.drawable.run);
        } else if (events.get(i).getPref().equalsIgnoreCase("Walk")) {
            holder.ivPref.setImageResource(R.drawable.walk);

        }
    }

    @Override
    public int getItemCount() {
        return events.size();
    }
}
