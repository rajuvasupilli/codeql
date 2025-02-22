public class VulnerableApp {
  public static void main(String[] args) {
    if (args.length > 0) {
      String userInput = args[0];
      try {
        // WARNING: Concatenating user input directly into a command is dangerous!
        // This call is vulnerable to command injection.
        Process process = Runtime.getRuntime().exec("ls " + userInput);
        process.waitFor();
      } catch (Exception e) {
        e.printStackTrace();
      }
    } else {
      System.out.println("No input provided.");
    }
  }
}

