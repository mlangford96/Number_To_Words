<!DOCTYPE HTML>

<head>
    <link rel = "stylesheet" type = "text/css" href = "style/index.css">
</head>

<body>
<% 
    String inputText = request.getParameter("input_text");
    String output = new String();
    int length = inputText.length();
    char nextNum = ' ';
    boolean containsCents = false;
    int decimalPoint = 0;

    decimalPoint = contains_cents(inputText, length);

    if (decimalPoint > 0) {
        containsCents = true;
    }
    
    if (!contains_only_numbers(inputText, length)) {
        length = 0;
        output = " ";
        output = output.concat("Input must only contain numbers and/or a single decimal point");
    }

    String dollars = inputText;
    String cents = inputText;

    if (containsCents && length > 0) {
        dollars = dollars.substring(0, decimalPoint);
        if (dollars.length() >= 7) { 
            output = output.concat("Number must be in the format 123.45 up to a maximum of 999999.99");
            length = 0;
        } else {            
            output = output.concat(dollars_to_words(dollars));
        }

        if (contains_dollars(dollars)) {
            output = output.concat(" DOLLARS");
        }

        cents = cents.substring(decimalPoint + 1);
        if (cents.length() > 2 || cents.length() < 2) {
            output = "";
            cents = "00";
            length = 0;
            output = output.concat("Number must be in the format 123.45 up to a maximum of 999999.99");
        } 
        if (cents.charAt(0) != '0' || cents.charAt(1) != '0') {
            if (contains_dollars(dollars)) {
                output = output.concat(" AND ");
            }
            if (length > 0) {
                output = output.concat(cents_to_words(cents));
                output = output.concat(" CENTS");
            }
        }        
    } else  if (length > 0) {
        output = output.concat(dollars_to_words(dollars));
        output = output.concat(" DOLLARS");
    }

     
%>

<%! private boolean contains_dollars(String dollars) {
        for (int i = 0; i < dollars.length(); i++) {
            if (dollars.charAt(i) != '0') {
                return true;
            }
        }
        return false;
    }
%>

<%! private String cents_to_words(String cents) {
        String output = "";

        if (cents.charAt(0) == '0' && cents.charAt(1) == '0') {
           return output;
        }

        if (cents.charAt(0) == '0') {
            output = output.concat(ones_to_words(cents.charAt(1)));
        } else {
            output = output.concat(tens_to_words(cents));
        }

        return output;
    }
%>


<%! private String dollars_to_words(String dollars) {
    String output = ""; 
    int length = dollars.length();

        switch(length) {
            case 1:
                output = output.concat(ones_to_words(dollars.charAt(0))); 
                break;
            case 2:
                output = output.concat(tens_to_words(dollars));
                break;
            case 3:
                output = output.concat(hundreds_to_words(dollars));
                break;
            case 4:
                output = output.concat(thousands_to_words(dollars));
                break;
            case 5:
                output = output.concat(ten_thousand_to_words(dollars));
                break;
            case 6:
                output = output.concat(hundred_thousand_to_words(dollars));
                break;
            }
        return output;
    }
%>

<%!
    private String ones_to_words(char dollars) {
        String output = "";

        switch(dollars) {
            case '1':
                output = output.concat("ONE");
                break;
            case '2':
                output = output.concat("TWO");
                break;
            case '3':
                output = output.concat("THREE");
                break;
            case '4':
                output = output.concat("FOUR");
                break;
            case '5':
                output = output.concat("FIVE");
                break;
            case '6':
                output = output.concat("SIX");
                break;
            case '7':
                output = output.concat("SEVEN");
                break;
            case '8':
                output = output.concat("EIGHT");
                break;
            case '9':
                output = output.concat("NINE");
                break; 
        }
        return output;
    }
%>

<%!
    private String tens_to_words(String dollars) {
        String output = "";
        switch(dollars.charAt(0)) {
           case '1':
               output = output.concat(teens_to_words(dollars));
               break;
           case '2':
               output = output.concat("TWENTY");
               break;
           case '3':
               output = output.concat("THRITY");
               break;
           case '4':
               output = output.concat("FORTY");
               break;
           case '5':
               output = output.concat("FIFTY");
               break;
           case '6':
               output = output.concat("SIXTY");
               break;
           case '7':
               output = output.concat("SEVENTY");
               break;
           case '8':
               output = output.concat("EIGHTY");
               break;
           case '9':
               output = output.concat("NINETY");
               break; 
        }
        if (dollars.charAt(1) != '0') {
            if (dollars.charAt(0) != '0' && dollars.charAt(0) != '1') {
                output = output.concat("-");           
            } 
            if (dollars.charAt(0) != '1') {
                output = output.concat(ones_to_words(dollars.charAt(1))); 
            }
        }
        return output;     
    } 
%>

<%! private String teens_to_words(String dollars) {
        String output = "";

         switch(dollars.charAt(1)) {
           case '0':
               output = output.concat("TEN");
               break;
           case '1':
               output = output.concat("ELEVEN");
               break;
           case '2':
               output = output.concat("TWELVE");
               break;
           case '3':
               output = output.concat("THIRTEEN");
               break;
           case '4':
               output = output.concat("FOURTEEN");
               break;
           case '5':
               output = output.concat("FIFTEEN");
               break;
           case '6':
               output = output.concat("SIXTEEN");
               break;
           case '7':
               output = output.concat("SEVENTEEN");
               break;
           case '8':
               output = output.concat("EIGHTEEN");
               break; 
           case '9':
               output = output.concat("NINETEEN");
               break;
        }       
        return output;
    }
%>

<%!
    private String hundreds_to_words(String dollars) {
        String output = "";

        output = output.concat(ones_to_words(dollars.charAt(0)));

        if (dollars.charAt(0) != '0') {
            output = output.concat(" HUNDRED"); 
        }

        if (dollars.charAt(1) != '0' || dollars.charAt(2) != '0') {
            output = output.concat(" AND ");
        } 
        output = output.concat(tens_to_words(dollars.substring(1)));
        return output;
   }
%>

<%! private String thousands_to_words(String dollars) {
        String output = "";
 
        output = output.concat(ones_to_words(dollars.charAt(0)));
        if (contains_dollars(dollars)) {
            output = output.concat(" THOUSAND ");
        }
        output = output.concat(hundreds_to_words(dollars.substring(1)));
        return output;
    }
%>


<%! private String ten_thousand_to_words(String dollars) {
        String output = "";
 
        if (dollars.charAt(1) == '1') {
            output = output.concat(teens_to_words(dollars.substring(0, 2)));
        } else {
            output = output.concat(tens_to_words(dollars.substring(0, 2)));
        }

        if (contains_dollars(dollars)) {
            output = output.concat(" THOUSAND ");
        }
        output = output.concat(hundreds_to_words(dollars.substring(1)));
        return output;
    }
%>



<%! private String hundred_thousand_to_words(String dollars) {
        String output = "";
 
        output = output.concat(ones_to_words(dollars.charAt(0)));
        if (contains_dollars(dollars)) {
            output = output.concat(" HUNDRED");
        }
        if (dollars.charAt(1) != '0' || dollars.charAt(2) != '0') {
            output = output.concat(" AND ");
        }

        output = output.concat(ten_thousand_to_words(dollars.substring(1)));
        return output;
    }
%>


<%!
    private int contains_cents(String inputText, int inputLength) {
        char nextNum = ' ';

        for (int i = 0; i < inputLength; i++) {
            nextNum = inputText.charAt(i);
            if (nextNum == '.') {
                return i;
            }
        }
        return 0;
    }    
%>

<%!
    private boolean contains_only_numbers(String inputText, int inputLength) {
        char nextNum = ' ';

        for (int i = 0; i < inputLength; i++) {
            nextNum = inputText.charAt(i);
            
            if ((nextNum < '0' || nextNum > '9') && nextNum != '.') {
                return false;
            } 
        }
        return true;
    }
%>


        <div class = top_pane>
            <h1>Numbers to Words Web Page</h1>
            <br>
            <h2>Dollars and Cents</h2>
        </div>

        <div class = input_pane>
            <form class = "form" action = "test.jsp" method = "GET">
                <input type = "text" name = "input_text" class = "input_text"
                        placeholder = "Please Enter a Numerical Dollar Value">
                <br>
                <input type = "submit" class = "submit" value = "SUBMIT">
            </form>
        <br>
        <p> <%=output%> <p>
        </div>
 
</body>
</html>
