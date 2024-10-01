package com.example.consultasapi.service;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

@WebServlet("/weatherServlet")
public class ApiServlet extends HttpServlet {

    private static final String WEATHER_API_URL = "http://api.weatherstack.com/current";
    private static final String TRM_API_URL = "https://trm-colombia.vercel.app/?date=2023-12-31";
    private static final String RICK_AND_MORTY_API_URL = "https://rickandmortyapi.com/api/character";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String jsonResponse = "";

        if ("Get Weather".equals(action)) {
            String city = request.getParameter("city");
            jsonResponse = fetchWeather(city);
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);

        } else if ("Get TRM".equals(action)) {
            jsonResponse = fetchTrm();
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);

        } else if ("Get Rick and Morty Characters".equals(action)) {
            jsonResponse = fetchRickAndMorty();
            response.setContentType("application/json");
            response.getWriter().write(jsonResponse);
        }
    }

    private String fetchWeather(String city) {
        String apiKey = "f805797a7d20c2564baa3f6891b2c142"; // Tu clave de la API de Weatherstack
        try {
            String queryParams = "?access_key=" + apiKey + "&query=" + URLEncoder.encode(city, "UTF-8");
            URL url = new URL(WEATHER_API_URL + queryParams);
            return getApiResponse(url);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\": \"Error fetching weather data\"}";
        }
    }

    private String fetchTrm() {
        try {
            URL url = new URL(TRM_API_URL);
            return getApiResponse(url);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\": \"Error fetching TRM data\"}";
        }
    }

    private String fetchRickAndMorty() {
        try {
            URL url = new URL(RICK_AND_MORTY_API_URL);
            return getApiResponse(url);
        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\": \"Error fetching Rick and Morty data\"}";
        }
    }

    private String getApiResponse(URL url) throws IOException {
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder content = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        return content.toString();
    }
}
