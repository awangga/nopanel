Untuk menerima pesan dari pengguna Telegram dan memprosesnya menggunakan Google Cloud Functions dengan Golang, Anda bisa menggunakan webhook yang dikirim oleh Telegram ke endpoint Anda saat pesan diterima oleh bot. Berikut adalah langkah-langkah untuk melakukannya:

1. **Siapkan Lingkungan Pengembangan**:
   - Pastikan Anda telah menginstal Google Cloud SDK dan menginisialisasi proyek Anda.
   - Buat direktori proyek baru dan masuk ke direktori tersebut.

2. **Inisialisasi Modul Go**:
   - Jalankan perintah berikut untuk menginisialisasi modul Go:

   ```sh
   go mod init telegram-bot
   ```

3. **Buat File `main.go`**:
   - Buat file `main.go` dengan konten berikut:

```go
package telegrambot

import (
    "encoding/json"
    "fmt"
    "log"
    "net/http"
    "os"
)

const telegramAPI = "https://api.telegram.org/bot%s/sendMessage"

type TelegramUpdate struct {
    UpdateID int `json:"update_id"`
    Message  struct {
        MessageID int `json:"message_id"`
        From      struct {
            ID           int    `json:"id"`
            IsBot        bool   `json:"is_bot"`
            FirstName    string `json:"first_name"`
            LastName     string `json:"last_name"`
            Username     string `json:"username"`
            LanguageCode string `json:"language_code"`
        } `json:"from"`
        Chat struct {
            ID        int64  `json:"id"`
            FirstName string `json:"first_name"`
            LastName  string `json:"last_name"`
            Username  string `json:"username"`
            Type      string `json:"type"`
        } `json:"chat"`
        Date     int    `json:"date"`
        Text     string `json:"text"`
        Entities []struct {
            Offset int    `json:"offset"`
            Length int    `json:"length"`
            Type   string `json:"type"`
        } `json:"entities"`
    } `json:"message"`
}

type SendMessageRequest struct {
    ChatID string `json:"chat_id"`
    Text   string `json:"text"`
}

func sendMessage(chatID, text, botToken string) error {
    apiURL := fmt.Sprintf(telegramAPI, botToken)
    values := url.Values{}
    values.Add("chat_id", chatID)
    values.Add("text", text)
    values.Add("parse_mode", "html")

    resp, err := http.PostForm(apiURL, values)
    if err != nil {
        return err
    }
    defer resp.Body.Close()

    if resp.StatusCode != http.StatusOK {
        return fmt.Errorf("failed to send message: %s", resp.Status)
    }
    return nil
}

func WebhookHandler(w http.ResponseWriter, r *http.Request) {
    var update TelegramUpdate
    if err := json.NewDecoder(r.Body).Decode(&update); err != nil {
        http.Error(w, "Bad request", http.StatusBadRequest)
        return
    }

    botToken := os.Getenv("TELEGRAM_BOT_TOKEN")
    if botToken == "" {
        http.Error(w, "Bot token is not set", http.StatusInternalServerError)
        return
    }

    chatID := update.Message.Chat.ID
    receivedText := update.Message.Text
    responseText := fmt.Sprintf("You said: %s", receivedText)

    if err := sendMessage(fmt.Sprintf("%d", chatID), responseText, botToken); err != nil {
        http.Error(w, err.Error(), http.StatusInternalServerError)
        return
    }

    w.WriteHeader(http.StatusOK)
    w.Write([]byte(`{"status": "success"}`))
}

func main() {
    http.HandleFunc("/webhook", WebhookHandler)
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    log.Printf("Server started at http://localhost:%s\n", port)
    log.Fatal(http.ListenAndServe(":"+port, nil))
}
```

4. **Buat File Konfigurasi `go.mod`**:
   - Buat file `go.mod` dengan konten berikut:

   ```go
   module telegrambot

   go 1.20
   ```

5. **Menyebarkan Fungsi ke Google Cloud**:
   - Pastikan Anda telah menginisialisasi proyek Google Cloud dan mengatur autentikasi.
   - Gunakan perintah berikut untuk menyebarkan fungsi:

   ```sh
   gcloud functions deploy WebhookHandler --runtime go120 --trigger-http --allow-unauthenticated --set-env-vars TELEGRAM_BOT_TOKEN=<YOUR_TELEGRAM_BOT_TOKEN>
   ```

   Gantilah `<YOUR_TELEGRAM_BOT_TOKEN>` dengan token bot Telegram Anda.

6. **Setel Webhook**:
   - Setelah fungsi disebarkan, Anda akan mendapatkan URL untuk fungsi tersebut.
   - Setel URL webhook bot Telegram Anda menggunakan perintah berikut:

   ```sh
   curl -X POST "https://api.telegram.org/bot<YOUR_TELEGRAM_BOT_TOKEN>/setWebhook" -d "url=<YOUR_CLOUD_FUNCTION_URL>"
   ```

   Gantilah `<YOUR_TELEGRAM_BOT_TOKEN>` dengan token bot Telegram Anda dan `<YOUR_CLOUD_FUNCTION_URL>` dengan URL fungsi Google Cloud yang telah Anda sebarkan.

7. **Uji Webhook**:
   - Sekarang, setiap kali bot Anda menerima pesan, webhook akan mengirim data ke endpoint Anda di Google Cloud Functions.
   - Fungsi Anda akan memproses pesan tersebut dan mengirim balasan.

Dengan langkah-langkah di atas, Anda dapat membuat endpoint di Google Cloud Functions untuk menerima dan memproses pesan yang dikirim ke bot Telegram Anda menggunakan Golang. Pastikan Anda menjaga token akses bot dengan aman dan tidak membagikannya secara publik.