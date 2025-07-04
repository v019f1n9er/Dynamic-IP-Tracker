# Dynamic-IP-Tracker

## Описание
**Dynamic-IP-Tracker** - это скрипт для маршрутизаторов MikroTik на платформе RouterOS, предназначенный для отслеживания изменений динамического публичного IP-адреса и отправки уведомлений о новых IP-адресах через Telegram-бота, а также для изменения правил NAT для проброса порта. Это особенно полезно для пользователей, использующих проброс портов, которые хотят быть в курсе изменений своего IP-адреса.

## Приступая к работе

Перед использованием скрипта выполните следующие шаги:

1. Создайте Telegram-бота и получите токен:
    - Перейдите в Telegram и найдите бота `@BotFather` (https://t.me/BotFather).
    - Создайте нового бота, следуя инструкциям, и получите `telegramToken`.
2. Получите ваш chatId:
    - Напишите сообщение вашему боту.
    - Используйте API Telegram для получения вашего `chatId`, отправив запрос:
      `https://api.telegram.org/bot<telegramToken>/getUpdates`
    - Найдите ваш `chatId` в ответе.
3. Замените значения в скрипте:
    - Вставьте ваш `telegramToken` (строка 1) и `chatId` (строка 2) в соответствующие переменные.
    - Убедитесь, что интерфейс, указанный в строке `find interface="int-pppoe"` (строка 16), соответствует вашему интерфейсу, через который осуществляется подключение к интернету.
    - Создайте комментарий под необходимым вам правилом проброса порта в NAT и внесите этот комментарий в часть скрипта в строке 22 (`[find comment="test"]`), где `test` является вашим комментарием.
4. Автоматическое выполнение скрипта:
    - Создайте сценарий автозапуска через Scheduler, выполнив команду в терминале маршрутизатора:
      `/system scheduler add name="your-task-name" interval=00:05:00 on-event="/system script run your-script-name" policy=read,write,test,sniff,policy`

## Заключение
**Dynamic-IP-Tracker** является простым и эффективным способом отслеживания изменений динамического IP-адреса на маршрутизаторе MikroTik с уведомлениями через Telegram.
