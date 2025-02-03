function insecureFunction(userInput) {
  eval(userInput); // Insecure usage of eval
}
insecureFunction("alert('This is insecure!')");

