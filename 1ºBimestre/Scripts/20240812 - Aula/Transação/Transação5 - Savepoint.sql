USE exemplo;
GO
 
TRUNCATE TABLE produto;
 
BEGIN TRANSACTION 
	INSERT INTO produto VALUES(1,'notebook', 10);
	SAVE TRANSACTION inserindoDados;
 
	INSERT INTO produto VALUES(2,'tv oled', 12);
	SAVE TRANSACTION inserindoDados;
 
	INSERT INTO produto VALUES(3,'smartphone', 34);

	ROLLBACK TRANSACTION inserindoDados;
 
	COMMIT
 
	SELECT * FROM produto;