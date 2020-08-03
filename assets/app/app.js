const app = document.getElementById('app');

const startButton= document.createElement('button');
const stopButton= document.createElement('button');
const pauseButton= document.createElement('button');
const counter= document.createElement('p');
startButton.innerText= 'start';
stopButton.innerText= 'stop';
pauseButton.innerText= 'pause';

app.appendChild(startButton);
app.appendChild(stopButton);
app.appendChild(pauseButton);
app.appendChild(counter);

let int;
let i= 0;

var audio1 = new Audio('bell.mp3');
var audio2 = new Audio('Wrong 02.wav');
clearInterval(int);

const startTimer= () => {
  clearInterval(int);
  console.log('starting')
  int= setInterval(() => {
    i++
    counter.innerText= i;
    if(i== 120) {
      console.log('2 minutes')
      audio1.play();
    }
    if(i== 180) {
      console.log('3 minutes');
      clearInterval(int);
      audio2.play();
    }

  }, 1000);
}

const stopTimer= () => {
  console.log('stopping');
  counter.innerText= '';
  clearInterval(int);
}

const clearTimer= ()=> {

}

startButton.addEventListener('click', startTimer);
stopButton.addEventListener('click', stopTimer);