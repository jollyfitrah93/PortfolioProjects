const {default: axios} = require("axios");

const token = "bot6861974788:AAH_AbVplVpEG3XTRhVIgbMVqIeT-_y7vPQ";
const message = "LO%20PENIPU%20KAN!!!!"
const chatId = "6951548817";

const url = "https://api.telegram.org/bot5942982961:AAGBQuh42Gp79sszZSRtOKrDd9Wbibk8p-w/sendMessage?parse_mode=markdown&chat_id=${chatId}&text=${message}"



async function sendMessage() {
    try{
        while(true) {
            await axios.get(url)
                .then((response) => {
                    if (response.status == 200) {
                        console.log(response.statusText)
                    } else {
                        console.log("Message Failed!")
                    }
                })
        }
    } catch (e) {
        sendMessage();
    }
}

sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();
sendMessage();

