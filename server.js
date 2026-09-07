const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

app.use(express.static('public'));

// यूजर डेटा और रूम स्टोरेज
const activeRooms = new Map();

io.on('connection', (socket) => {
    console.log(`New user connected: ${socket.id}`);

    // रूम ज्वाइन करना (जैसे लाइव ऑडियो/वीडियो पार्टी रूम)
    socket.on('join-room', ({ roomId, username }) => {
        socket.join(roomId);
        console.log(`${username} joined room: ${roomId}`);
        
        socket.to(roomId).emit('user-joined', { message: `${username} has joined the room.` });
    });

    // चैट या गिफ्ट मैसेज ब्रॉडकास्ट करना
    socket.on('send-message', ({ roomId, username, message }) => {
        io.to(roomId).emit('receive-message', { username, message, timestamp: new Date().toLocaleTimeString() });
    });

    // डिस्कनेक्ट होना
    socket.on('disconnect', () => {
        console.log(`User disconnected: ${socket.id}`);
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
    console.log(`Live Party App Server is running on port ${PORT}`);
});

