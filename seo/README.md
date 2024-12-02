# Custom robots.txt

https://www.example.com/robots.txt

Gunakan custom robots.txt untuk mengkostumasi sub menu di hasil pencarian:  
```txt
User-agent: *
Allow: /
Sitemap: https://raw.githubusercontent.com/awangga/blogger/main/sitemap/bukupedia.co.id/sitemap.xml
```

isi sitemap.xml:  
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset
      xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
            http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">

<url>
  <loc>https://www.bukupedia.co.id/</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>1.00</priority>
</url>
<url>
  <loc>https://katalog.bukupedia.co.id/</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.80</priority>
</url>
<url>
  <loc>https://penulis.bukupedia.co.id/</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.80</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/p/layanan.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.80</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/p/perjanjian.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.60</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/p/drafting.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.60</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/search/label/editor</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/09/dera-thorani.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/09/roni-andarsyah-st-mkom-sfpc.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/09/rolly-maulana-awanggastmtcaip-sfpc.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/nisa-hanum-harani-skom-mt.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/nama-syafrial-fachri-panest-mti.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/cahyo-prianto-spd-mt.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/roni-habibi-skom-mt.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/mohamad-nurkamal-fauzan-st-mt.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/m-yusril-helmi-setyawan-skom-mkom.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/nurul-fazriyah-spd-mpd.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>
<url>
  <loc>https://www.bukupedia.co.id/2022/08/ari-nurfikri-skm-mmr.html</loc>
  <lastmod>2022-10-18T09:47:19+00:00</lastmod>
  <priority>0.40</priority>
</url>


</urlset>
```