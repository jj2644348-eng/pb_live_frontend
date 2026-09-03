const express = require('http');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server);

// एक्टिव रूम्स का डेटा स्टोर करने के लिए
const activeRooms = {};

io.on('connection', (socket) => {
    console.log(`User Connected: ${socket.id}`);

    // रूम क्रिएट करना या जॉइन करना
    socket.on('join_room', ({ roomId, username }) => {
        socket.join(roomId);
        
        if (!activeRooms[roomId]) {
            activeRooms[roomId] = { seats: Array(8).fill(null), users: [] };
        }
        
        activeRooms[roomId].users.push({ id: socket.id, username });
        
        // रूम के बाकी लोगों को अपडेट भेजें
        io.to(roomId).emit('update_room', activeRooms[roomId]);
    });

    // सीट पर बैठना (Take the Mic / Seat)
    socket.on('take_seat', ({ roomId, seatIndex, username }) => {
        if (activeRooms[roomId] && !activeRooms[roomId].seats[seatIndex]) {
            activeRooms[roomId].seats[seatIndex] = { id: socket.id, username };
            io.to(roomId).emit('update_room', activeRooms[roomId]);
        }
    });

    // चैट मैसेज भेजना
    socket.on('send_message', ({ roomId, message, username }) => {
        io.to(roomId).emit('receive_message', { username, message });
    });

    // डिस्कनेक्ट होने पर यूज़र को हटाना
    socket.on('disconnect', () => {
        console.log(`User Disconnected: ${socket.id}`);
        for (let roomId in activeRooms) {
            activeRooms[roomId].users = activeRooms[roomId].users.filter(u => u.id !== socket.id);
            // सीट्स से भी हटाएँ
            activeRooms[roomId].seats = activeRooms[roomId].seats.map(seat => seat?.id === socket.id ? null : seat);
            io.to(roomId).emit('update_room', activeRooms[roomId]);
        }
    });
});

server.listen(3000, () => {
    console.log('Server is running on port 3000');
});

