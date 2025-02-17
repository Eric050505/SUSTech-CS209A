package Lab.Lab9.Practice1;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URL;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;


public class ChatServer {
    public static void main(String[] args) {
        Set<ClientHandler> clients = ConcurrentHashMap.newKeySet();

        try (ServerSocket serverSocket = new ServerSocket(12000)) {
            System.out.println("Server started ......");

            while (true) {
                Socket socket = serverSocket.accept();
                System.out.println("New client connected.");

                ClientHandler clientHandler = new ClientHandler(socket, clients);
                clients.add(clientHandler);
                new Thread(clientHandler).start();
            }
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }
}

class ClientHandler implements Runnable {
    private final Socket socket;
    private final BufferedReader in;
    private final PrintWriter out;
    private final Set<ClientHandler> clients;
    private String clientName;

    public ClientHandler(Socket socket, Set<ClientHandler> clients) throws IOException {
        this.socket = socket;
        this.clients = clients;
        this.in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        this.out = new PrintWriter(socket.getOutputStream(), true);
    }

    public void sendMessage(String message) {
        out.println(message);
    }

    private void broadcast(String message, ClientHandler sender) {
        for (ClientHandler client : clients) {
            if (client != sender) {
                client.sendMessage(message);
            }
        }
    }

    @Override
    public void run() {
        try {
            clientName = in.readLine();
            broadcast(clientName + " joined the chat!", this);

            String message;
            while ((message = in.readLine()) != null) {
                if (message.equals("EXIT")) {
                    System.out.println(clientName + " disconnected");
                    break;
                }

                broadcast(clientName + ": " + message, this);
                String pokemonDetails = getPokemonDetails(message);
                sendMessage(pokemonDetails);
                System.out.println("Info of " + pokemonDetails + "sent");
            }
        } catch (IOException e) {
            System.out.println(clientName + " disconnected");
        } finally {
            try {
                socket.close();
            } catch (IOException e) {
                System.out.println(e.getMessage());
            }
            clients.remove(this);
            broadcast(clientName + " left the chat!", this);
        }
    }

    private String getPokemonDetails(String pokemonName) throws IOException {
        String url = "https://pokeapi.co/api/v2/pokemon/" + pokemonName;
        HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("User-Agent", "Mozilla/5.0");
        int responseCode = connection.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null)
                response.append(inputLine);
            in.close();

            JSONObject pokemonData = JSONObject.fromObject(response.toString());
            String height = pokemonData.get("height").toString();
            String weight = pokemonData.get("weight").toString();

            JSONArray abilitiesJson = JSONArray.fromObject(pokemonData.get("abilities"));
            StringBuilder abilities = new StringBuilder();
            for (int i = 0; i < abilitiesJson.size(); i++) {
                JSONObject ability = abilitiesJson.getJSONObject(i);
                abilities.append(JSONObject.fromObject(ability.get("ability")).get("name")).append(", ");
            }

            abilities.delete(abilities.length() - 2, abilities.length());

/*
            for (int i = 0; i < pokemonData.get("abilities").; i++) {
                abilities.append(pokemonData.get("abilities").getJSONObject(i)
                        .getJSONObject("ability").getString("name"));

                if (i < pokemonData.getJSONArray("abilities").size() - 1)
                    abilities.append(", ");
            }*/

            return "Name: " + pokemonName + "\nHeight: " + height + "\nWeight: " + weight + "\nAbilities: " + abilities;
        } else
            return "Error: Unable to retrieve data for " + pokemonName;
    }
}