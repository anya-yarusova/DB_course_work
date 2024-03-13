function Hello(){
  var login = localStorage.getItem('loggedInUser')
  document.getElementById('hello-login').textContent = `Вы вошли как ${login}. Добро пожаловать!`;
}

function sendRequestToLogout(){
  localStorage.removeItem('loggedInUser')
}

Hello();
var deleteButton = document.getElementById('det');

deleteButton.addEventListener('click', sendRequestToLogout);