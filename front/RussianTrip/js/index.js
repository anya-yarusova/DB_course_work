function Hello(){
  var login = localStorage.getItem('loggedInUser')
  document.getElementById('hello-login').textContent = `Вы вошли как ${login}. Добро пожаловать!`;
}

function sendRequestToLogout(){
  localStorage.removeItem('loggedInUser')
}