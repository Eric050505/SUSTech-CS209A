package Assignment.Assignment2;

import Assignment.Assignment2.Model.GameRecord;
import Assignment.Assignment2.Model.GameSession;
import Assignment.Assignment2.Model.User;
import lombok.Setter;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.*;
import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.logging.FileHandler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

public class GameServer {
    private static final int PORT = 12345;
    private static final String USER_DATA_FILE = "src/main/resources/Assignment/Assignment2/users.dat";
    private static final ConcurrentLinkedDeque<ClientHandler> waitingClients = new ConcurrentLinkedDeque<>();
    private static final Set<String> onlineUsers = new HashSet<>();
    private static Map<String, User> users;
    private static final Set<ClientHandler> clientHandlers = new HashSet<>();
    private static final Logger logger = Logger.getLogger(GameServer.class.getName());
    static {
        try {
            FileHandler fileHandler = new FileHandler("E:\\Users\\Eric\\IdeaProjects\\CS209A\\src\\main\\resources\\Assignment\\Assignment2\\game_server.log", true);
            fileHandler.setFormatter(new SimpleFormatter());
            logger.addHandler(fileHandler);
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Failed to setup file handler for logging.", e);
        }
    }

    public static void main(String[] args) {
        System.out.println("Game Server is running at port " + PORT);
        loadUserData();
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            while (true) {
                Socket clientSocket = serverSocket.accept();
                ClientHandler clientHandler = new ClientHandler(clientSocket);
                clientHandlers.add(clientHandler);
                new Thread(clientHandler).start();
            }
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error during server operation: " + e.getMessage(), e);
        }
    }

    private static void loadUserData() {
        File file = new File(USER_DATA_FILE);
        if (file.exists() && file.length() > 0) {
            try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(file))) {
                users = (Map<String, User>) ois.readObject();
                System.out.println("User data loaded successfully.");
            } catch (IOException | ClassNotFoundException e) {
                logger.log(Level.SEVERE, "Error loading user data: " + e.getMessage(), e);
                users = new HashMap<>();
            }
        } else {
            System.out.println("No user data file found or file is empty, starting with an empty user list.");
            users = new HashMap<>();
        }
    }

    private static void saveUserData() {
        try (ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(USER_DATA_FILE))) {
            oos.writeObject(users);
            System.out.println("User data saved successfully.");
        } catch (IOException e) {
            logger.log(Level.SEVERE, "Error saving user data: " + e.getMessage(), e);
        }
    }

    private static void broadcast() throws IOException {
        List<User> usersCopy = new ArrayList<>(users.values());
        Set<String> onlineUsersCopy = new HashSet<>(onlineUsers);
        Set<String> waitingUsernames = new HashSet<>();
        for (ClientHandler clientHandler : waitingClients)
            if (clientHandler.user != null) waitingUsernames.add(clientHandler.user.getUsername());

        for (ClientHandler clientHandler : clientHandlers)
            clientHandler.write(new Object[]{usersCopy, onlineUsersCopy, waitingUsernames});
    }

    private static void startGame(ClientHandler clientPlayer1, ClientHandler clientPlayer2, int boardSize) throws IOException {
        clientPlayer1.user.setMistakes(0);
        clientPlayer2.user.setMistakes(0);
        GameSession gameSession = new GameSession(clientPlayer1.user, clientPlayer2.user, boardSize);
        clientPlayer1.write("START: " + clientPlayer1.user.getUsername() + ", you are Player 1!");
        clientPlayer1.write(gameSession);
        clientPlayer1.setOpponentUserHandler(clientPlayer2);
        clientPlayer1.setOpponentUsername(clientPlayer2.user.getUsername());

        clientPlayer2.write("START: " + clientPlayer2.user.getUsername() + ", you are Player 2!");
        clientPlayer2.write(gameSession);
        clientPlayer2.setOpponentUserHandler(clientPlayer1);
        clientPlayer2.setOpponentUsername(clientPlayer1.user.getUsername());
        System.out.printf("Game session started between %s and %s.\n", clientPlayer1.user.getUsername(), clientPlayer2.user.getUsername());
    }

    private static class ClientHandler implements Runnable {
        private User user;
        private final Socket clientSocket;
        private ObjectOutputStream out;
        @Setter
        private ClientHandler opponentUserHandler;
        @Setter
        private String opponentUsername;

        private ClientHandler(Socket clientSocket) {
            this.clientSocket = clientSocket;
        }

        @Override
        public void run() {
            try {
                out = new ObjectOutputStream(clientSocket.getOutputStream());
                ObjectInputStream in = new ObjectInputStream(clientSocket.getInputStream());
                while (true) {
                    Object object = in.readObject();
                    if (object instanceof String message) {
                        String head = message.split(":")[0];
                        switch (head) {
                            case "REGISTER" -> handleRegister(message);
                            case "LOGIN" -> handleLogin(message);
                            case "LOGOUT", "DISCONNECT" -> handleDisconnect();
                            case "MATCH" -> handleMatch(Integer.parseInt(message.split(":")[1]));
                            case "CANCEL_MATCHING" -> handleCancelMatching();
                            case "CANCEL_WAITING" -> handleCancelWaiting();
                            case "MOVE" -> handleMove(message);
                            case "OVER" -> handleOver(message.split(":")[1]);
                            case "QUERY" -> handleQuery(message.split(":")[1]);
                            case "JOIN" -> handleJoin(message.split(":")[1]);
                            case "REFRESH" -> broadcast();
                        }
                    } else if (object instanceof GameSession gameSession) {
                        gameSession.setUser1(this.user);
                        gameSession.setUser2(opponentUserHandler.user);
                        write(gameSession);
                        opponentUserHandler.write(gameSession);
                    } else
                        user.setMistakes((int) object);
                }

            } catch (IOException e) {
                logger.log(Level.SEVERE, "IOException occurred while handling client: " + e.getMessage(), e);
                if (opponentUsername != null)
                    logger.log(Level.SEVERE, "All of two players left the game!");
            } catch (ClassNotFoundException | InterruptedException e) {
                logger.log(Level.SEVERE, "Exception occurred while processing client request: " + e.getMessage(), e);
            } finally {
                try {
                    if (user != null) {
                        waitingClients.remove(this);
                        onlineUsers.remove(user.getUsername());
                        logger.info("User " + user.getUsername() + " has left the game.");
                        clientHandlers.remove(this);
                        if (opponentUserHandler != null)
                            opponentUserHandler.write("OPPONENT_LEAVING: " + user.getUsername() + " left the game.");
                    }
                    clientSocket.close();
                    broadcast();
                } catch (IOException e) {
                    logger.log(Level.SEVERE, "IOException occurred while closing the client socket: " + e.getMessage(), e);
                } finally {
                    clientHandlers.remove(this);
                }
            }
        }

        private void saveGameRecord(User user, GameRecord gameRecord) {
            user.getGameRecords().add(gameRecord);
            saveUserData();
        }

        private void handleJoin(String username) throws IOException {
            waitingClients.remove(this);
            for (ClientHandler waitingClient : waitingClients)
                if (waitingClient.user.getUsername().equals(username)) {
                    waitingClients.remove(waitingClient);
                    startGame(this, waitingClient, waitingClient.user.getPreferBoardSize() == -1 ? 4 : waitingClient.user.getPreferBoardSize());
                    broadcast();
                    return;
                }
        }

        private void handleQuery(String body) throws IOException {
            write(users.get(body).getGameRecords());
        }

        private void handleOver(String body) throws IOException {
            boolean hasRemaining = Boolean.parseBoolean(body.split(" ")[0]);
            String username1 = body.split(" ")[1];
            int mistakes1 = Integer.parseInt(body.split(" ")[2]);
            int mistakes2 = Integer.parseInt(body.split(" ")[4]);
            int boardSize = Integer.parseInt(body.split(" ")[5]);
            String resultMessage;
            String opponentMessage;

            if (mistakes1 == mistakes2 || hasRemaining) {
                GameSession gameSession = new GameSession(user, opponentUserHandler.user, boardSize);
                write(gameSession);
                opponentUserHandler.write(gameSession);
            } else {
                boolean userWins = ((mistakes1 < mistakes2) == (username1.equals(user.getUsername())));
                resultMessage = userWins ? "WIN: " + user.getUsername() + ", you are winner!" : "LOSE: " + user.getUsername() + ", you are lost!";
                opponentMessage = userWins ? "LOSE: " + opponentUserHandler.user.getUsername() + ", you are lost!" : "WIN: " + opponentUserHandler.user.getUsername() + ", you are winner!";

                write(resultMessage);
                opponentUserHandler.write(opponentMessage);

                saveGameRecord(user, new GameRecord(opponentUserHandler.user.getUsername(), userWins, new Date()));
                saveGameRecord(opponentUserHandler.user, new GameRecord(user.getUsername(), !userWins, new Date()));
                loadUserData();
                broadcast();
                opponentUserHandler.opponentUserHandler = null;
                opponentUserHandler = null;
                opponentUsername = null;
            }
        }

        private void handleMove(String message) throws IOException {
            this.opponentUserHandler.write(message);
        }

        private void handleDisconnect() throws IOException {
            write("LOGOUT: You have logged out.");
            onlineUsers.remove(user.getUsername());
            waitingClients.remove(this);
            if (opponentUserHandler != null)
                opponentUserHandler.write("OPPONENT_LEAVING: " + user.getUsername() + " left the game.");
            user = null;
            broadcast();
        }

        private void handleMatch(int preferBoardSize) throws IOException, ClassNotFoundException {
            this.user.setPreferBoardSize(preferBoardSize);
            write("WAITING: Waiting for opponents...");
            waitingClients.add(this);
            int thisSize = this.user.getPreferBoardSize();
            int matchingSize = 0;
            if (waitingClients.size() > 1) for (ClientHandler waitingClient : waitingClients)
                if (waitingClient != this) {
                    int otherSize = waitingClient.user.getPreferBoardSize();
                    if (thisSize == -1 && otherSize == -1) matchingSize = 4;
                    else if (thisSize == -1) matchingSize = otherSize;
                    else if (otherSize == thisSize) matchingSize = thisSize;
                    else if (otherSize == -1) matchingSize = thisSize;

                    if (matchingSize != 0) {
                        waitingClients.remove(this);
                        waitingClients.remove(waitingClient);
                        startGame(waitingClient, this, matchingSize);
                        broadcast();
                        return;
                    }
                }
            broadcast();
        }

        private void handleRegister(String message) throws IOException {
            String[] parts = message.split(" ");
            String username = parts[0].split(":")[1];
            String password = parts[1];

            if (users.containsKey(username)) {
                out.writeObject("REGISTER_FAILED: Username already exists.");
                out.flush();
            } else {
                users.put(username, new User(username, password));
                saveUserData();
                write("REGISTER_SUCCESS: Registration successful.");
                out.flush();
            }
        }

        private void handleLogin(String message) throws IOException, InterruptedException {
            String[] parts = message.split(" ");
            String username = parts[0].split(":")[1];
            String password = parts[1];

            if (users.containsKey(username) && users.get(username).getPassword().equals(password)) {
                if (onlineUsers.contains(username)) {
                    write("LOGIN_FAILED: User already logged in.");
                    return;
                }
                this.user = users.get(username);
                write(user);
                write("LOGIN_SUCCESS: Welcome " + user.getUsername() + ".");

                onlineUsers.add(user.getUsername());
                broadcast();

                for (ClientHandler clientHandler : clientHandlers) {
                    if (clientHandler.opponentUsername != null && clientHandler.opponentUsername.equals(username) && clientHandler != this) {
                        this.opponentUserHandler = clientHandler;
                        clientHandler.opponentUserHandler = this;
                        clientHandler.write("OPPONENT_RECONNECTION:" + user.getUsername());
                        this.opponentUsername = clientHandler.user.getUsername();
                        write("RECONNECTION:" + user.getUsername());
                        return;
                    }
                }
            } else write("LOGIN_FAILED: Invalid username or password.");
        }

        private void handleCancelWaiting() throws IOException {
            opponentUserHandler = null;
            opponentUsername = null;
        }

        private void handleCancelMatching() throws IOException {
            waitingClients.remove(this);
            write("CANCEL SUCCESS: You have cancelled matching.");
            broadcast();
        }

        private void write(Object object) throws IOException {
            out.writeObject(object);
            out.flush();
        }

    }

}
