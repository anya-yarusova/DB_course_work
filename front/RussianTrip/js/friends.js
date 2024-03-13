function sendRequestToServer(friendLogin) {
  var login = localStorage.getItem('loggedInUser')
  fetch('http://localhost:8080/friends/add?' + new URLSearchParams({ user: login, friendLogin: friendLogin }), {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(data => {
      if (!data.ok) {
        alert("Такого логина не существует");
        return;
      }
        // Добавляем логин друга в список
        const newFriend = document.createElement("li");
        const deleteButton = document.createElement("button");
        newFriend.textContent = friendLogin;
        deleteButton.classList.add("btn", "btn-del");
        deleteButton.textContent = "delete";
        deleteButton.onclick = function () {
          sendDeleteRequestToServer(friendLogin);
          newFriend.remove();
        }
        newFriend.appendChild(deleteButton);
        const friendsList = document.querySelector(".friends_list ul");
        friendsList.appendChild(newFriend);
        // Очищаем поле ввода
        const friendsLoginInput = document.querySelector("input[name='friends_login']");
        friendsLoginInput.value = "";
    })
    .catch(error => {
      console.error('Произошла ошибка:', error);
      alert('Поизошла ошибка, чекай логи:)');
    });
}


function sendDeleteRequestToServer(friendLogin) {
  var login = localStorage.getItem('loggedInUser')

  fetch('http://localhost:8080/friends/remove?' + new URLSearchParams({ user: login, friendLogin: friendLogin }), {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => {
      if (!response.ok) {
        throw new Error('Ошибка удаления друга');
      }
      return response;
      // Возможно, вам нужно выполнить дополнительные действия после успешного удаления друга
    })
    .catch(error => {
      console.error('Произошла ошибка при удалении друга:', error);
      alert('Произошла ошибка при удалении друга');
    });
}

function getFriends() {
  var login = localStorage.getItem('loggedInUser')
  fetch('http://localhost:8080/friends/all?' + new URLSearchParams({ user: login }), {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    }
  })
    .then(response => response.json())
    .then(data => {
      data.forEach(friend => {
        console.log("fidghsdiufhg");
        // Добавляем логин друга в список
        const newFriend = document.createElement("li");
        const deleteButton = document.createElement("button");
        newFriend.textContent = friend.login;
        deleteButton.classList.add("btn", "btn-del");
        deleteButton.textContent = "delete";
        deleteButton.onclick = function () {
          sendDeleteRequestToServer(friend.login);
          newFriend.remove();
        }
        newFriend.appendChild(deleteButton);
        const friendsList = document.querySelector(".friends_list ul");
        friendsList.appendChild(newFriend);
      });
    })
    .catch(error => {
      console.error('Произошла ошибка:', error);
      alert('Поизошла ошибка, чекай логи:)');
    });
}

document.addEventListener("DOMContentLoaded", function () {
  getFriends();
  const sendFriendRequestBtn = document.querySelector(".send_friend_request");
  const friendsLoginInput = document.querySelector("input[name='friends_login']");


  sendFriendRequestBtn.addEventListener("click", function () {
    const friendLogin = friendsLoginInput.value.trim();
    if (friendLogin !== "") {
      // Отправляем запрос на сервер
      // Предположим, что у нас есть функция sendRequestToServer() для отправки запроса
      sendRequestToServer(friendLogin);
        // .then(response => {
        //   // Предположим, что сервер возвращает true или false в зависимости от того, найден ли такой логин
        //   if (response.ok) {
        //     // Добавляем логин друга в список
        //     const newFriend = document.createElement("li");
        //     const deleteButton = document.createElement("button");
        //     newFriend.textContent = friendLogin;
        //     deleteButton.classList.add("btn", "btn-del");
        //     deleteButton.textContent = "delete";
        //     deleteButton.onclick = function () {
        //       sendDeleteRequestToServer(friendLogin);
        //       newFriend.remove();
        //     }
        //     newFriend.appendChild(deleteButton);
        //     friendsList.appendChild(newFriend);
        //     // Очищаем поле ввода
        //     friendsLoginInput.value = "";
        //   } else {
        //     alert("Такого логина не существует");
        //   }
        // })
        // .catch(error => {
        //   console.error("Ошибка при отправке запроса на сервер:", error);
        //   alert("Произошла ошибка при отправке запроса на сервер");
        // });
    } else {
      alert("Введите логин друга");
    }
  });
});
