:global telegramToken "TOKEN"
:global chatId "CHATID"
:global currentIP
:global previousIP

:global sendTelegramMessage do={
    :local message $1  
    :global telegramToken
    :global chatId
    :global newIPMessage  
    :local url ("https://api.telegram.org/bot$telegramToken/sendMessage?chat_id=$chatId&text=$newIPMessage")

    /tool fetch url=$url keep-result=no
}

:set currentIP [/ip address get [find interface="int-pppoe"] address ];

:if ($currentIP != $previousIP) do={
    :global newIPMessage ("New public IP: " . $currentIP)
    :put [$sendTelegramMessage varName="newIPMessage"]
    :set previousIP $currentIP
} else={
    :log info "IP has not changed or is empty"
}