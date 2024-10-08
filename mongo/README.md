# MongoDB

## Membuat TTL Collection

![image](https://github.com/user-attachments/assets/91337041-0e8f-46f1-aaf7-f8cfb0c345c8)


Menggunakan TTL indexes di MongoDB membutuhkan sebuah field dengan tipe tanggal (Date) untuk menentukan waktu kadaluwarsa. Sayangnya, TTL indexes tidak dapat digunakan langsung pada field yang bukan tipe Date. Jadi, Anda tidak dapat secara langsung menggunakan field seperti userid (jika itu bukan tipe Date) sebagai dasar untuk TTL index.

### Membuka Mongoshell
Pertama tambahkan dahulu json kedalam collection:
```json
{
  "_id": ObjectId("60c72b2f4f1a4e3a7c8b4567"),
  "username": "user1",
  "createdAt": ISODate("2024-06-09T00:00:00Z")
}
```
atau
```json
{
  "_id": {
    "$oid": "60c72b2f4f1a4e3a7c8b4567"
  },
  "username": "user1",
  "createdAt": {
    "$date": "2024-06-09T00:00:00Z"
  }
}

```
buka mongoshell jalankan:
```sh
use yourDatabase

db.yourCollection.createIndex(
   { "createdAt": 1 },
   { expireAfterSeconds: 300 } // 300 seconds = 5 menit
)
```
Cek hasilnya
```sh
use yourDatabase

db.yourCollection.getIndexes()
```
![image](https://github.com/awangga/nopanel/assets/11188109/400b3d79-b557-4002-80a3-762a8c48e528)  

Jika ingin melakukan update detiknya maka lakukan drop dulu dan buat lagi:

```sh
db.collection.dropIndex("createdAt_1");
db.collection.createIndex({ createdAt: 1 }, { expireAfterSeconds: 300 });
```

### Kode Golang
Buat dahulu field yang berbasiskan waktu, contoh field CreatedAt ditambahkan pada Struct Document:
```go
type Document struct {
    ID        string    `bson:"_id,omitempty"`
    UserID    string    `bson:"userid"`
    CreatedAt time.Time `bson:"createdAt"`
}
```
Cara insert dan mengisi createdAt:
```go
collection := client.Database("yourDatabase").Collection("yourCollection")

document := bson.D{
    {Key: "username", Value: "user1"},
    {Key: "createdAt", Value: time.Now()},
}

_, err = collection.InsertOne(context.TODO(), document)
if err != nil {
    log.Fatal(err)
}
```
