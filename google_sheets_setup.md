# Подключение Google-таблицы

## 1. Создать таблицу
Откройте sheets.google.com → «Пустой файл» → назовите, например, «К Корню — Клиенты».

## 2. Вставить скрипт
В таблице: **Расширения → Apps Script**. Удалите весь код-заглушку и вставьте:

```js
function doPost(e) {
  const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Submissions')
    || SpreadsheetApp.getActiveSpreadsheet().insertSheet('Submissions');
  const data = JSON.parse(e.postData.contents);

  if (sheet.getLastRow() === 0) {
    sheet.appendRow(['Дата','Сайт','Session ID','Этап','Язык','Тема','Результат','Имя','Телефон','Проблема','Срок','Ситуация','Эмоции','Ответы теста (JSON)']);
  }

  sheet.appendRow([
    new Date(),
    data.site || '',
    data.session_id || '',
    data.stage || '',
    data.lang || '',
    data.category || '',
    data.pattern_title || '',
    data.name || '',
    data.phone || '',
    data.problem_text || '',
    data.duration || '',
    data.situation_text || '',
    data.emotions || '',
    data.answers ? JSON.stringify(data.answers) : ''
  ]);

  return ContentService.createTextOutput(JSON.stringify({status:'ok'}))
    .setMimeType(ContentService.MimeType.JSON);
}
```

Сохраните проект (значок диска, дайте любое имя).

## 3. Развернуть как веб-приложение
1. Кнопка **Deploy → New deployment**.
2. Рядом с «Select type» нажмите на шестерёнку → выберите **Web app**.
3. **Execute as**: Me (ваш аккаунт).
4. **Who has access**: Anyone.
5. **Deploy**.
6. Google попросит авторизовать доступ — это ваш собственный скрипт к вашей же таблице, разрешите (Advanced → Go to project (unsafe) если появится предупреждение — это стандартно для собственных скриптов).
7. Скопируйте **Web app URL** (заканчивается на `/exec`).

## 4. Прислать ссылку
Пришлите эту ссылку сюда в чат — я вставлю её в код сайта (`GOOGLE_SHEET_WEBAPP_URL`), и с этого момента каждая заявка будет попадать и в Supabase, и в вашу Google-таблицу.

**Важно:** если позже поменяете код скрипта в Apps Script, нужно будет сделать **Deploy → Manage deployments → Edit → New version**, иначе изменения не применятся.
