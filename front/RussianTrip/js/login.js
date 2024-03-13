  document.addEventListener('DOMContentLoaded', function() {
    var loginForm = document.getElementById('loginForm');

    loginForm.addEventListener('submit', function(event) {
      event.preventDefault(); // Предотвращаем отправку формы по умолчанию

      // Получаем данные из формы
      var login = document.getElementById('loginInput').value;
      var password = document.getElementById('passwordInput').value;


      var data = {
        login: login,
        password: password
      };
      // Отправляем данные на сервер
      fetch('http://localhost:8080/auth/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(data),
      })
      .then(response => {
        if (response.ok) {
          localStorage.setItem('loggedInUser', login)
          window.location.href = 'index.html';
        } else {
          console.error('Ошибка входа:', response.statusText);
          alert('Поизошла ошибка, чекай логи:)');
        }
      })
      .catch(error => {
        console.error('Произошла ошибка:', error);
        alert('Поизошла ошибка, чекай логи:)');
      });
    });
  });