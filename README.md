# Dynamic-IP-Tracker

## Описание
Dynamic-IP-Tracker - это скрипт для маршрутизаторов MikroTik на платформе RouterOS, предназначенный для отслеживания изменений динамического публичного IP-адреса и отправки уведомлений о новых IP-адресах через Telegram-бота. Это особенно полезно для пользователей, использующих проброс портов, которые хотят быть в курсе изменений своего IP-адреса.

В будущем планируется расширение функционала скрипта для автоматического обновления правил проброса портов в зависимости от нового IP-адреса.

## Приступая к работе

Перед использованием скрипта выполните следующие шаги:

1. Создайте Telegram-бота и получите токен:
    - Перейдите в Telegram и найдите бота @BotFather (https://t.me/BotFather).
    - Создайте нового бота, следуя инструкциям, и получите telegramToken.
2. Получите ваш chatId:
    - Напишите сообщение вашему боту.
    - Используйте API Telegram для получения вашего chatId, отправив запрос:
    - ```https://api.telegram.org/bot<telegramToken>/getUpdates```
    - Найдите ваш chatId в ответе.
3. Замените значения в скрипте:
    - Вставьте ваш telegramToken и chatId в соответствующие переменные.
    - Убедитесь, что интерфейс, указанный в строке find interface="int-pppoe", соответствует вашему интерфейсу, через который осуществляется подключение к интернету.
  
## Скрипт

```
:global telegramToken "TOKEN"  # Замените на ваш токен Telegram-бота
:global chatId "CHATID"        # Замените на ваш chatId
:global currentIP
:global previousIP

:global sendTelegramMessage do={
    :local message $1  
    :global telegramToken
    :global chatId
    :global newIPMessage  
    :local url ("https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$chatId&text=$newIPMessage")

    /tool fetch url=$url keep-result=no    # Отправка сообщения в Telegram
}

# Получение текущего IP-адреса
:set currentIP [/ip address get [find interface="int-pppoe"] address ];

:if ($currentIP != $previousIP) do={
    :global newIPMessage ("New public IP: " . $currentIP)    # Формирование сообщения с новым IP
    :put [$sendTelegramMessage varName="newIPMessage"]       # Отправка сообщения через Telegram
    :set previousIP $currentIP                               # Обновление предыдущего IP
} else={
    :log info "IP has not changed or is empty"               # Логирование, если IP не изменился
}
```

## Заключение
**Dynamic-IP-Tracker** является простым и эффективным способом отслеживания изменений динамического IP-адреса на маршрутизаторе MikroTik с уведомлениями через Telegram.
