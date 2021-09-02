# Triger siti dan siap

Langkah :

1. buka navicat pilih database siti atau siap cari tabel simak_besan_user klik kanan Design Table pilih triger
2. hapus triger lama atau rename dulu, kemudian buat ulang triger dan config nya
3. pada triger st_user_insert_after, fires=after, yang dicentang hanya insert, masukan config berikut
	BEGIN
    
	IF NOT EXISTS (SELECT * FROM besan_users WHERE user_name = new.user_name) THEN
	   
	      INSERT INTO `besan_users`
			 (`user_id`,
			  `user_name`,
			  `user_password`,
			  `user_email`,
			  `user_birthdate`,
			  `user_aim`,
			  `user_icq`,
			  `user_msn`,
			  `user_sig`,
			  `user_rights`,
			  `user_groups`,
			  `user_level`)
	      VALUES    (  new.user_id,
			   new.user_name,
			   new.user_password,
			   new.user_email,
			   new.user_birthdate,
			   new.user_aim,
			   new.user_icq,
			   new.user_msn,
			   new.user_sig,
			   new.user_rights,
			   new.user_groups,
			   new.user_level);
	END IF;	
        IF NOT EXISTS (SELECT * FROM simak_mst_karyawan WHERE login = new.user_name) THEN
                   INSERT INTO simak_mst_karyawan (Login, LevelID,password)
                   VALUES (
                                      new.user_name, 
                                      MID(new.user_groups,2,3),
                                      left(new.user_password,10)
                                   );
        END IF;
    END

4 pada triger st_user_update_after, fires=after, yang dicentang hanya update, masukan config berikut

	BEGIN   
	DECLARE	ls_group VARCHAR(5);	
	IF (new.user_name <> old.user_name) OR (new.user_password <> old.user_password) OR (new.user_groups <> old.user_groups) OR (new.user_status <> old.user_status)  THEN
		
		SET 	ls_group = MID(new.user_groups,2,3);
			
		UPDATE  besan_users
		SET	user_name     = new.user_name,	
			user_password = new.user_password,
			user_groups   = new.user_groups,	
			user_status   = new.user_status	
		WHERE	user_name     = old.user_name;
	    
		IF ls_group = '221' THEN
		
		   UPDATE  simak_mst_mahasiswa
		   SET	   Login= new.user_name,
			   Password= LEFT(new.user_password,10),
			   LevelID = MID(new.user_groups,2,3)
		   WHERE   MhswId= old.user_name;
		
		ELSEIF ls_group = '224' THEN
		
		       UPDATE  simak_mst_alumni
		       SET	   Login = new.user_name,
			   PASSWORD = LEFT(new.user_password,10),
			   LevelID = MID(new.user_groups,2,3)
		      WHERE   Login = old.user_name;
		      ELSEIF ls_group = '222' THEN
		
		         UPDATE  simak_mst_dosen
		            SET	   Login = new.user_name,
			   PASSWORD = LEFT(new.user_password,10),
			   LevelID = MID(new.user_groups,2,3)
		             WHERE   Login = old.user_name;
		   
		       ELSE	
		
		            UPDATE  simak_mst_karyawan
		              SET	          Login = new.user_name,
			                             PASSWORD = LEFT(new.user_password,10),
                                                                                    LevelID = MID(new.user_groups,2,3)
		             WHERE   Login = old.user_name;
		
		      END IF;
		
	                    END IF;
	                     UPDATE  ws_user
		   SET	   username= new.user_name,
			   Password= LEFT(new.user_password,10)
			   
		   WHERE   username= old.user_name;
    END


# Error Input Nilai Pada siti

Langkah :

1. buka navicat pilih database siti, kemudian cari tabel simak_mst_mahasiswa
2. klik kanan pada tabel simak_mst_mahasiswa pilih design tabel, pilih triger
3. rename triger yang sebelumnya, kemudian buat triger baru dengan nama yg sama dengan triger sebelumnya, setelah itu masukan config dan save.
4. pada triger st_mhs_insert_after, fires=after yang di centang hanya insert saja, masukan config berikut

BEGIN

        IF NOT EXISTS (SELECT * FROM ws_user  WHERE username= new.mhswid) THEN
                   INSERT INTO ws_user (username, password,type_user,nama,url_foto,npm)
                   VALUES (
                                      new.mhswid, 
                                      left(new.password,10),
                                      'MAHASISWA',
                                      new.nama,
                                      new.foto,
                                      new.mhswid
                                   ),
                                   (
                                      concat('1',new.mhswid), 
                                      left(new.password,10),
                                      'ORTU',
                                      new.nama,
                                      new.foto,
                                      new.mhswid
                                   );
        END IF;

END

5. pada triger st_mhs_update_after, fires=after yang di centang hanya update saja, masukan config berikut

BEGIN

	IF (new.Foto<> old.Foto) OR (new.Nama <> old.Nama) THEN UPDATE  ws_user
          SET	   url_foto= new.Foto,  nama= new.Nama			   
		   WHERE   username= old.mhswid;
	END IF;

	INSERT INTO ws_user(username,PASSWORD,type_user,nama,url_foto,npm)
	SELECT MhswID,PASSWORD,'MAHASISWA',nama,CONCAT('https://siti.stimlog.ac.id/stimlog/modul/simpati/',foto),MhswID
	FROM   simak_mst_mahasiswa t
	WHERE  MhswID = new.MhswID 
	ON DUPLICATE KEY UPDATE PASSWORD = t.password;
	END