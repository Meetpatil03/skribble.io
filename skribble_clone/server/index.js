const express = require('express');
var http = require('http');
const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
const mongoose = require('mongoose');
const Room = require('./models/Room');
var io = require('socket.io')(server);
const getWord = require('./api/getWord');
// middleware
app.use(express.json());

const DB = 'mongodb+srv://meet:test123@cluster0.zuxghrp.mongodb.net/?retryWrites=true&w=majority';

mongoose.connect(DB).then(()=>{
    console.log("MongoDB Connnected!");
}).catch((e)=>{
    console.log(e);
});

io.on('connection',(socket)=>{
    console.log('connected!');
    socket.on('create-game',async({nickname,name,occupancy,maxRounds})=>{
        try{
                const existingRoom = await Room.findOne({name});
                if(existingRoom){
                    socket.emit('notCorrectGame','Room with that name already exits!');
                return;   
                }

                let room = new Room();
                const word = getWord();
                   room.word = word;
                   room.name = name;
                   room.occupancy = occupancy;
                   room.maxRounds = maxRounds;
                   
                   let player = {
                    socketID: socket.id,
                    nickname,
                    isPartyLeader: true, 
                   }

                   room.players.push(player);
                   room = await room.save();
                   socket.join(room);
                   io.to(name).emit('updateRoom',room);


        }catch(e){
            console.log(e);
        }
    });
});

server.listen(port,'0.0.0.0',()=>{
    console.log('Server Started and running on Port :'+port);
});