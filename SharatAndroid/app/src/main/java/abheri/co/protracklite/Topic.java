package abheri.co.protracklite;

public class Topic {
    private String Title;
    private CharSequence[] Portions;

    public Topic(String title, CharSequence[] portions) {
        Title = title;
        Portions = portions;
    }

    public CharSequence[] getPortions() {
        return Portions;
    }

    public void setPortions(CharSequence[] portions) {
        Portions = portions;
    }

    public String getTitle() {
        return Title;
    }

    public void setTitle(String title) {
        Title = title;
    }
}
