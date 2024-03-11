// function sendRequestToServer(friendLogin) {
//   fetch('/addFriend', { // Измените путь запроса на /addFriend
//     method: 'POST', // Используйте метод POST для добавления друга
//     body: JSON.stringify({ friendLogin: friendLogin }),
//     headers: {
//       'Content-Type': 'application/json'
//     }
//   })
//   .then(response => {
//     if (!response.ok) {
//       throw new Error('Ошибка при добавлении друга');
//     }

//   })
//   .catch(error => {
//     console.error('Произошла ошибка при добавлении друга:', error);
//     alert('Произошла ошибка при добавлении друга');
//   });
// }

function sendRequestToServer() {
  return new Promise((resolve, reject) => {
    // В этом примере просто генерируем случайное число для имитации результата запроса
    const randomNumber = Math.random();
    if (randomNumber < 0.999999) {
      // Возвращаем успешный результат
      resolve(true);
    } else {
      // Возвращаем неуспешный результат
      resolve(false);
    }
  });
}

function sendDeleteRequestToServer(friendLogin) {
  // Здесь вы можете использовать fetch или другой метод для отправки запроса на сервер
  // Например:
  fetch('/deleteFriend', {
    method: 'POST',
    body: JSON.stringify({ friendLogin: friendLogin }),
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then(response => {
    if (!response.ok) {
      throw new Error('Ошибка удаления друга');
    }
    // Возможно, вам нужно выполнить дополнительные действия после успешного удаления друга
  })
  .catch(error => {
    console.error('Произошла ошибка при удалении друга:', error);
    alert('Произошла ошибка при удалении друга');
  });
}

document.addEventListener("DOMContentLoaded", function() {
  const sendFriendRequestBtn = document.querySelector(".send_friend_request");
  const friendsLoginInput = document.querySelector("input[name='friends_login']");
  const friendsList = document.querySelector(".friends_list ul");

  sendFriendRequestBtn.addEventListener("click", function() {
    const friendLogin = friendsLoginInput.value.trim();
    if (friendLogin !== "") {
      // Отправляем запрос на сервер
      // Предположим, что у нас есть функция sendRequestToServer() для отправки запроса
      sendRequestToServer()
        .then(response => {
          // Предположим, что сервер возвращает true или false в зависимости от того, найден ли такой логин
          if (response) {
            // Добавляем логин друга в список
            const newFriend = document.createElement("li");
            const deleteButton = document.createElement("button");
            newFriend.textContent = friendLogin;
            deleteButton.classList.add("btn", "btn-del");
            deleteButton.textContent = "delete";
            deleteButton.onclick = function(){
              sendDeleteRequestToServer(friendLogin);
              newFriend.remove();
            }
            newFriend.appendChild(deleteButton);
            friendsList.appendChild(newFriend);
            // Очищаем поле ввода
            friendsLoginInput.value = "";
          } else {
            alert("Такого логина не существует");
          }
        })
        .catch(error => {
          console.error("Ошибка при отправке запроса на сервер:", error);
          alert("Произошла ошибка при отправке запроса на сервер");
        });
    } else {
      alert("Введите логин друга");
    }
  });
});
