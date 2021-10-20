/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author nguye
 */
public class APIUtils {

    public static String getBaseURLAPi() {
        return "http://localhost:8081/";
    }

    public static String sendGetRequest(String api_url, boolean getResult) throws MalformedURLException, IOException {
        URL url = new URL(api_url);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");

        con.setDoOutput(true);

        con.setRequestProperty("Accept", "application/json");
        con.setRequestProperty("Content-Type", "application/json");
        //get response

        int code = con.getResponseCode();

        if (getResult) {
            if (code != 200) {
                System.out.println("Error: " + code);
                return "error";
            } else {
                try (BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                    String line;
                    while ((line = bufferedReader.readLine()) != null) {
                        return line;
                    }
                } catch (Exception ex) {
                    System.out.println(ex.toString());
                }

            }
        }
        return null;
    }

    //send http request
    public static String sendPostRequest(String api_url, String stringBodyRequest) throws MalformedURLException, IOException {
        //post
        URL url = new URL(api_url);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("POST");

        con.setRequestProperty("Accept", "application/json");
        con.setRequestProperty("content-type", "application/json");
        con.setRequestProperty("Accept-Charset", "UTF-8");
        
         con.setDoOutput(true);

        try (OutputStream os = con.getOutputStream()) {
            byte[] input = stringBodyRequest.getBytes("utf-8");
            os.write(input, 0, input.length);
        } catch (Exception ex) {
            System.out.println(ex.toString());
        }

        int code = con.getResponseCode();

        if (code != 200) {
            System.out.println("Error: " + code);
            return "error";
        } else {
            System.out.println("Sucessfull");

            try (BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                String response;
                while ((response = bufferedReader.readLine()) != null) {
                    return response;
                }
            } catch (Exception ex) {
                System.out.println(ex.toString());
            }
        }
        return null;
    }
}
