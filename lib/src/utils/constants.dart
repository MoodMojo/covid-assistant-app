

class Constants {

  static String TOP_HEADLINES_URL =  "https://newsapi.org/v2/top-headlines?country=us&apiKey=b5643af41c7647b589202ead9abc7dd5";

  static String headlinesFor(String keyword) {

    return  "https://newsapi.org/v2/everything?q=$keyword&apiKey=b5643af41c7647b589202ead9abc7dd5";

  }

  

}