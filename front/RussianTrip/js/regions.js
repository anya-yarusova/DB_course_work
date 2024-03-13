// Функция для обновления процента посещенных регионов
function updatePercentage() {
  var percentage = 0;
  fetch('http://localhost:8080/regions/percent?' + new URLSearchParams({login: login}), {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => response.json())
  .then(response => {
    percentage = response;
    document.getElementById('percentage').textContent = `Процент посещенных регионов = ${percentage.toFixed(1)}%`;
  }
  )
  .catch(error => {
    console.error('Произошла ошибка:', error);
    alert('Поизошла ошибка, чекай логи:)');
  });
}

  // Функция для отправки данных на сервер
  function sendData() {
    var url = 'http://localhost:8080/regions'
    if (this.checked) {
      url += '/visit?';
    } else {
      url += '/unvisit?';
    }

    fetch(url + new URLSearchParams({login: login, regionId: this.id}), {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        console.log('Данные успешно отправлены на сервер');
      } else {
        console.error('Произошла ошибка при отправке данных на сервер');
      }
    })
    .catch(error => {
      console.error('Произошла ошибка:', error);
      alert('Поизошла ошибка, чекай логи:)');
    });
  }

  var login = localStorage.getItem('loggedInUser');

  fetch('http://localhost:8080/regions/all?'+ new URLSearchParams({login: login}), {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => response.json())
    .then(data => {
      data.forEach(region => {
        var checkbox = document.querySelector('input[type="checkbox"][id="' + region.regionId+ '"]');
        if (region.visited) {
          checkbox.checked = true;
        }
      });
    })
    .catch(error => {
      console.error('Произошла ошибка:', error);
      alert('Поизошла ошибка, чекай логи:)');
    });

// Обработчики событий для каждого checkbox
var checkboxes = document.querySelectorAll('input[type="checkbox"]');

updatePercentage();

checkboxes.forEach(function(checkbox) {
  checkbox.addEventListener('change', sendData);
  checkbox.addEventListener('change', updatePercentage);
});