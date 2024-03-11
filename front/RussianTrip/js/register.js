document.addEventListener("DOMContentLoaded", function() {
  var form = document.querySelector("form");

  form.addEventListener("submit", function(event) {
    event.preventDefault();

    var login = form.querySelector('input[name="login"]').value;
    var name = form.querySelector('input[name="name"]').value;
    var surname = form.querySelector('input[name="surname"]').value;
    var pass = form.querySelector('input[name="pass"]').value;
    var birthday = form.querySelector('input[name="birthday"]').value;

    var data = {
      login: login,
      name: name,
      surname: surname,
      birthday: birthday
    };
    // Отправляем данные на сервер
    fetch('http://localhost:8080/auth/register?' + new URLSearchParams({password: pass}), {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(data)
    })
    .then(response => {
      if (response.ok) {
        console.log("Данные успешно отправлены на сервер");
        localStorage.setItem('loggedInUser', login)
        window.location.href = 'index.html';
      } else {
        console.error('Ошибка входа:', response.body.loginContext);
      }
    })
    .catch(error => {
      console.error('Произошла ошибка:', error);
    });
  });
});
