import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

/*

Library Docs
http://hc.apache.org/httpcomponents-client-4.5.x/index.html
http://hc.apache.org/httpcomponents-client-4.5.x/httpclient/apidocs/index.html

Example this was taken from:
* http://hc.apache.org/httpcomponents-client-4.5.x/httpclient/examples/org/apache/http/examples/client/ClientWithResponseHandler.java

## Compiling

javac -cp '.:/home/vagrant/javaclass/httpcomponents-client-4.5.2/lib/*:' TestDNS.java

## Running

java -cp '.:/home/vagrant/javaclass/httpcomponents-client-4.5.2/lib/*:' TestDNS

## Links

http://unirest.io/java.html
http://hc.apache.org/httpcomponents-client-4.5.x/index.html
http://stackoverflow.com/questions/1322335/what-is-the-best-java-library-to-use-for-http-post-get-etc
http://stackoverflow.com/questions/16137713/how-to-run-a-java-program-from-the-command-line
http://stackoverflow.com/questions/10056895/how-to-add-multiple-jar-files-in-the-javac-java-class-path-for-debian-linux

*/
public class TestDNS {

    public final static void main(String[] args) throws Exception {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        try {
            for(int x = 0; x < 100; x = x + 1) {
              HttpGet httpget = new HttpGet("http://web.service.consul:8080/");

              //System.out.println("Executing request " + httpget.getRequestLine());

              // Create a custom response handler
              ResponseHandler<String> responseHandler = new ResponseHandler<String>() {

                  @Override
                  public String handleResponse(
                          final HttpResponse response) throws ClientProtocolException, IOException {
                      int status = response.getStatusLine().getStatusCode();
                      if (status >= 200 && status < 300) {
                          HttpEntity entity = response.getEntity();
                          return entity != null ? EntityUtils.toString(entity) : null;
                      } else {
                          throw new ClientProtocolException("Unexpected response status: " + status);
                      }
                  }

              };
              String responseBody = httpclient.execute(httpget, responseHandler);
              //System.out.println("----------------------------------------");
              //System.out.println(responseBody);

          }
        } finally {
            httpclient.close();
        }
    }

}

