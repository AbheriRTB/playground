import 'package:sunaad/models/orgs.dart';
import 'package:sunaad/models/programs.dart';

class DataUtils {
  List<String> getArtisteListFromPrograms(List<Programs> prgList) {
    List<String> artisteList = List<String>();
    //List<String> artisteSet = List<String>();
    Set<String> artisteSet = Set<String>();
    for (int i = 0; i < prgList.length; ++i) {
      Programs pr = prgList[i];
      String artiste = pr.artiste_name;
      artisteSet.add(artiste);
    }

    artisteList = artisteSet.toList();
    artisteList.sort();

    return artisteList;
  }

  List<Orgs> createArtisteProgramCollection(
      List<Programs> prgList, List<String> artList) {
    List<Orgs> artisteProgramCollection = List<Orgs>();
    String art = "";
    for (int i = 0; i < artList.length; ++i) {
      String selArt = artList[i];
      String artImage = "";
      List<Programs> artisteProgramList = List<Programs>();
      for (int j = 0; j < prgList.length; ++j) {
        Programs pr = prgList[j];
        art = pr.artiste_name;
        if (art.trim() == selArt) {
          artisteProgramList.add(pr);
          artImage = pr.artiste_image;
        }
      }
      Orgs orgs = Orgs(selArt, artImage, artisteProgramList);
      //orgs.title == selArt;
      //orgs.children == artisteProgramList;
      artisteProgramCollection.add(orgs);
    }

    return artisteProgramCollection;
  }

  List<String> getOrganizersListFromPrograms(List<Programs> prgList) {
    List<String> organizerList = List<String>();
    //List<String> artisteSet = List<String>();
    Set<String> orginizerSet = Set<String>();
    for (int i = 0; i < prgList.length; ++i) {
      Programs pr = prgList[i];
      String organizer = pr.organizer_name;
      orginizerSet.add(organizer);
    }

    organizerList = orginizerSet.toList();
    organizerList.sort();
    return organizerList;
  }

  List<Orgs> createOrganizersProgramCollection(
      List<Programs> prgList, List<String> orgList) {
    List<Orgs> organizerProgramCollection = List<Orgs>();
    String art = "";
    for (int i = 0; i < orgList.length; ++i) {
      String selOrg = orgList[i];
      List<Programs> organizerProgramList = List<Programs>();
      for (int j = 0; j < prgList.length; ++j) {
        Programs pr = prgList[j];
        art = pr.organizer_name;
        if (art.trim() == selOrg) {
          organizerProgramList.add(pr);
        }
      }
      Orgs orgs = Orgs(selOrg, "", organizerProgramList);
      //orgs.title == selArt;
      //orgs.children == artisteProgramList;
      organizerProgramCollection.add(orgs);
    }

    return organizerProgramCollection;
  }

  List<String> getVenueListFromPrograms(List<Programs> prgList) {
    List<String> venueList = List<String>();
    //List<String> artisteSet = List<String>();
    Set<String> venueSet = Set<String>();
    for (int i = 0; i < prgList.length; ++i) {
      Programs pr = prgList[i];
      String venue = pr.venue_name;
      venueSet.add(venue);
    }

    venueList = venueSet.toList();
    venueList.sort();
    return venueList;
  }

  List<Orgs> createVenueProgramCollection(
      List<Programs> prgList, List<String> venueList) {
    List<Orgs> venueProgramCollection = List<Orgs>();
    String venues = "";
    for (int i = 0; i < venueList.length; ++i) {
      String selVenue = venueList[i];
      List<Programs> venueProgramList = List<Programs>();
      for (int j = 0; j < prgList.length; ++j) {
        Programs pr = prgList[j];
        venues = pr.venue_name;
        if (venues.trim() == selVenue) {
          venueProgramList.add(pr);
        }
      }
      Orgs orgs = Orgs(selVenue, "", venueProgramList);
      //orgs.title == selArt;
      //orgs.children == artisteProgramList;
      venueProgramCollection.add(orgs);
    }

    return venueProgramCollection;
  }

  List<String> getEventTypeListFromPrograms(List<Programs> prgList) {
    List<String> eventList = List<String>();
    //List<String> artisteSet = List<String>();
    Set<String> eventSet = Set<String>();
    for (int i = 0; i < prgList.length; ++i) {
      Programs pr = prgList[i];
      String event = pr.event_type;
      eventSet.add(event);
    }

    eventList = eventSet.toList();
    eventList.sort();
    return eventList;
  }

  List<Orgs> createEventTypeProgramCollection(
      List<Programs> prgList, List<String> eventList) {
    List<Orgs> eventProgramCollection = List<Orgs>();
    String eventTypes = "";
    for (int i = 0; i < eventList.length; ++i) {
      String selEvent = eventList[i];
      List<Programs> eventTypeProgramList = List<Programs>();
      for (int j = 0; j < prgList.length; ++j) {
        Programs pr = prgList[j];
        eventTypes = pr.event_type;
        if (eventTypes.trim() == selEvent) {
          eventTypeProgramList.add(pr);
        }
      }
      Orgs orgs = Orgs(selEvent, "", eventTypeProgramList);
      //orgs.title == selArt;
      //orgs.children == artisteProgramList;
      eventProgramCollection.add(orgs);
    }

    return eventProgramCollection;
  }

  List<String> getCityListFromPrograms(List<Programs> prgList) {
    List<String> cityList = List<String>();
    //List<String> artisteSet = List<String>();
    Set<String> citySet = Set<String>();
    for (int i = 0; i < prgList.length; ++i) {
      Programs pr = prgList[i];
      String city = pr.venue_city;
      citySet.add(city);
    }

    cityList = citySet.toList();
    cityList.sort();
    return cityList;
  }

  List<Orgs> createCityProgramCollection(
      List<Programs> prgList, List<String> cityList) {
    List<Orgs> cityProgramCollection = List<Orgs>();
    String cities = "";
    for (int i = 0; i < cityList.length; ++i) {
      String selCity = cityList[i];
      List<Programs> cityTypeProgramList = List<Programs>();
      for (int j = 0; j < prgList.length; ++j) {
        Programs pr = prgList[j];
        cities = pr.venue_city;
        if (cities.trim() == selCity) {
          cityTypeProgramList.add(pr);
        }
      }
      Orgs orgs = Orgs(selCity, "", cityTypeProgramList);
      //orgs.title == selArt;
      //orgs.children == artisteProgramList;
      cityProgramCollection.add(orgs);
    }

    return cityProgramCollection;
  }
}
